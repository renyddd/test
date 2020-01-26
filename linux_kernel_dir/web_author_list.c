#include <stdlib.h>
#include <stdio.h>
#include <stdbool.h>

struct list_head {
        struct list_head *next, *prev;
};

#define LIST_HEAD_INIT(name) { &(name), &(name) }

#define LIST_HEAD(name) \
        struct list_head name = LIST_HEAD_INIT(name)

#define INIT_LIST_HEAD(ptr) do { \
	(ptr)->next = (ptr); (ptr)->prev = (ptr); \
} while (0)

#define LIST_POISON1  ((void *) 0x00100100)
#define LIST_POISON2  ((void *) 0x00200200)

static inline void __list_add(struct list_head *new,
			      struct list_head *prev,
			      struct list_head *next)
{
	next->prev = new;
	new->next = next;
	new->prev = prev;
	prev->next = new;
}

static inline void list_add(struct list_head *new, struct list_head *head)
{
	__list_add(new, head, head->next);
}


static inline void list_add_tail(struct list_head *new, struct list_head *head)
{
	__list_add(new, head->prev, head);
}

static inline void __list_del(struct list_head * prev, struct list_head * next)
{
	next->prev = prev;
	prev->next = next;
}

static inline void list_del(struct list_head *entry)
{
	__list_del(entry->prev, entry->next);
	entry->next = LIST_POISON1;
	entry->prev = LIST_POISON2;
}

#define offsetof(TYPE, MEMBER) ((size_t) &((TYPE *)0)->MEMBER)

#define container_of(ptr, type, member) ({              \
                const typeof( ((type *)0)->member ) *__mptr = (ptr); \
                (type *)( (char *)__mptr - offsetof(type,member) );})

#define list_entry(ptr, type, member) \
	container_of(ptr, type, member)

// linux-5.3.8 list_for_aech no prefetch.
#define list_next_entry(pos, member) \
	list_entry((pos)->member.next, typeof(*(pos)), member)

#define list_first_entry(ptr, type, member) \
	list_entry((ptr)->next, type, member)

#define list_last_entry(ptr, type, member) \
	list_entry((ptr)->prev, type, member)

#define list_for_each(pos, head) \
	for (pos = (head)->next; pos != (head); pos = pos->next)

#define list_for_each_entry(pos, head, member)				\
	for (pos = list_first_entry(head, typeof(*pos), member);	\
	     &pos->member != (head);					\
	     pos = list_next_entry(pos, member))

#define list_for_each_safe(pos, n, head) \
	for (pos = (head)->next, n = pos->next; pos != (head); \
		pos = n, n = pos->next)
/*
 * --------------------------------------------------------------------------
 * 中文博客地址：https://www.cnblogs.com/hwy89289709/p/6754300.html
 * 原文地址：http://isis.poly.edu/kulesh/stuff/src/klist/
 */

struct kool_list{
        int to;
        struct list_head list;
        int from;
};

int main(int argc, char **argv)
{
        struct kool_list *tmp;
        struct list_head *pos, *q;
        unsigned int i;

        struct kool_list mylist;
        INIT_LIST_HEAD(&mylist.list);
        /* or you could have declared this with the following macro
         * LIST_HEAD(mylist); which declares and initializes the list
         */

        /* adding elements to mylist */
        for(i = 3; i != 0; --i) {
                tmp = (struct kool_list *)malloc(sizeof(struct kool_list));

                /* INIT_LIST_HEAD(&tmp->list);
                 *
                 * this initializes a dynamically allocated list_head. we
                 * you can omit this if subsequent call is add_list() or
                 * anything along that line because the next, prev
                 * fields get initialized in those functions.
                 */
                tmp->to = i + 5;
                tmp->from = i;

                /* add the new item 'tmp' to the list of items in mylist */
                list_add(&(tmp->list), &(mylist.list));
                /* you can also use list_add_tail() which adds new items to
                 * the tail end of the list
                 */
        }
        printf("\n");


        /* now you have a circularly linked list of items of type struct kool_list.
         * now let us go through the items and print them out
         */


        /* list_for_each() is a macro for a for loop.
         * first parameter is used as the counter in for loop. in other words, inside the
         * loop it points to the current item's list_head.
         * second parameter is the pointer to the list. it is not manipulated by the macro.
         */
        printf("traversing the list using list_for_each()\n");
        list_for_each(pos, &mylist.list){

                /* at this point: pos->next points to the next item's 'list' variable and
                 * pos->prev points to the previous item's 'list' variable. Here item is
                 * of type struct kool_list. But we need to access the item itself not the
                 * variable 'list' in the item! macro list_entry() does just that. See "How
                 * does this work?" below for an explanation of how this is done.
                 */
                tmp= list_entry(pos, struct kool_list, list);

                /* given a pointer to struct list_head, type of data structure it is part of,
                 * and it's name (struct list_head's name in the data structure) it returns a
                 * pointer to the data structure in which the pointer is part of.
                 * For example, in the above line list_entry() will return a pointer to the
                 * struct kool_list item it is embedded in!
                 */

                printf("to= %d from= %d\n", tmp->to, tmp->from);

        }
        printf("\n");
        /* since this is a circularly linked list. you can traverse the list in reverse order
         * as well. all you need to do is replace 'list_for_each' with 'list_for_each_prev'
         * everything else remain the same!
         *
         * Also you can traverse the list using list_for_each_entry() to iterate over a given
         * type of entries. For example:
         */
        printf("traversing the list using list_for_each_entry()\n");
        list_for_each_entry(tmp, &mylist.list, list)
                printf("to= %d from= %d\n", tmp->to, tmp->from);
        printf("\n");


        /* now let's be good and free the kool_list items. since we will be removing items
         * off the list using list_del() we need to use a safer version of the list_for_each()
         * macro aptly named list_for_each_safe(). Note that you MUST use this macro if the loop
         * involves deletions of items (or moving items from one list to another).
         */
        printf("deleting the list using list_for_each_safe()\n");
        list_for_each_safe(pos, q, &mylist.list){
                tmp= list_entry(pos, struct kool_list, list);
                printf("freeing item to= %d from= %d\n", tmp->to, tmp->from);
                list_del(pos);
                free(tmp);
        }

        return 0;
}
