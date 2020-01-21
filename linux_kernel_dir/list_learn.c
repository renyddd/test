#include <stdio.h>
#define LIST_POISON1  ((void *) 0x00100100)
#define LIST_POISON2  ((void *) 0x00200200)

struct list_head {
	struct list_head *next, *prev;
};

#define LIST_HEAD_INIT(name) { &(name), &(name) }

#define LIST_HEAD(name) \
	struct list_head name = LIST_HEAD_INIT(name)

#define INIT_LIST_HEAD(ptr) do { \
	(ptr)->next = (ptr); (ptr)->prev = (ptr); \
} while(0)

// __list_add(new,prev,next)函数表示在prev和next之间添加一个新的节点new
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

static inline void  list_add_tail(struct list_head *new, struct list_head *head)
{
	__list_add(new, head->prev, head);
}

static inline int list_empty(const struct list_head *head)
{
	return head->next == head;
}
static inline int list_empty_careful(const struct list_head *head)
{
    struct list_head *next = head->next;
    return (next == head) && (next == head->prev);
}

// delete
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

static inline void list_del_init(struct list_head *entry)
{
	__list_del(entry->prev, entry->next);
	INIT_LIST_HEAD(entry);
}

// 链表的遍历操作
//
#define list_entry(ptr, type, member) \
	container_of(ptr, typr, member)

/*
#define list_for_each(pos, head) \
	for (pos = (head)->next; prefetch(pos->next), pos != (head); \
			pos = pos->next)
			*/
#define __list_for_each(pos, head) \
	for (pos = (head)->next; pos != (head); pos = pos->next)

// 以上皆为内核中提供的不含数据域的链表结构，经过封装，可扩展
//
// 下面进行自定义的数据域的链表
//
struct test_list {
	int *testdata;
	struct list_head list;
};


int main()
{

	LIST_HEAD (mylist_head);

	struct test_list item;
	int a = 5;
	item.testdata = &a;
	list_add_tail(&(item.list) ,&mylist_head);

	printf("%d\n", *item.testdata);

	return 0;
}

// https://blog.csdn.net/tigerjibo/article/details/8299599

