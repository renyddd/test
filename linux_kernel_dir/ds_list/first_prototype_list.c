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
/*
 * --------------------------------------------------------------------------
 * 这个版本已经可以正确使用 container_of 宏
 * 及正确构建嵌入 list_head 结构的链表。
 * 同时也有正确使用 list_first_entry 函数的例子。
 * 20200126
 */

struct fox {
        long tail_length;
        long weight;
        bool is_fantastic;
        struct list_head list;
};



int main()
{
        LIST_HEAD(fox_list);
        struct fox *f; // loop item.
        struct list_head *tmp;
        int i;

        for (i = 0; i < 5; i++) {
                f = (struct fox *) malloc(sizeof(struct fox *));
                f->tail_length = 40 + i;
                f->weight = 6 + i;
                f->is_fantastic = true;
                list_add_tail(&f->list, &fox_list); // use this function.
        }

        // list_for_each_entry(f, &fox_list, list) {
                // printf("info: %ld,%ld,%d\n", f->tail_length, f->weight, f->is_fantastic);
        // }

//        list_for_each(tmp, &fox_list);
        f = list_first_entry(&fox_list, struct fox, list);
        printf("info: %ld,%ld,%d\n", f->tail_length, f->weight, f->is_fantastic);

        return 0;
}
