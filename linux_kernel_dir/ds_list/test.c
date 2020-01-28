#include <stdlib.h>
#include <stdio.h>

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
 * 在版本 2 的基础上，
 * 发现了在使用 malloc 分配类型错误的问题，
 * 在这里主要探究 list_entry 之类的使用。
 * 2020-01-26-21:49
 * renyddd@gmail.com
 */

struct fox {
        int data;
        struct list_head list;
};


int main()
{
        LIST_HEAD(fox_list);
        
        struct list_head *pos, *n; //n for removal use.
        struct fox *f;
        int i;

        printf("the size of struct list_head: %ld\n", sizeof(struct list_head));
        printf("the size of struct fox: %ld\n", sizeof(struct fox));

        for (i = 0; i < 3; i++) {
                f = (struct fox *)malloc(sizeof(struct fox));
                f->data = 0 + i;
                list_add_tail(&f->list, &fox_list);
        }

        i = 0; // count the loop times.
        list_for_each_entry(f, &fox_list, list) {
                printf("info: %d\n", f->data);
                i++; // 循环是从表头结点开始
        }
        printf("the loop turns %d times\n", i);

        i = 0;
        list_for_each(pos, &fox_list) {
                printf("%d inner memory address: %p\n", i++, pos);
                f = list_entry(pos, struct fox, list);
                // 这种方式同样能接近外层封装的结构体变量，按需输出
                printf("info: %d\n", f->data);
        }
        printf("the loop turns %d times\n", i);

        // free action.
        list_for_each_safe(pos, n, &fox_list) {
                f = list_entry(pos, struct fox, list);
                free(f);
        }



        return 0;
}
