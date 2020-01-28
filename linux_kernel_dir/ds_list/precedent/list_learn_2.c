#include "list.h"

struct test_list {
	int data;
	struct list_head list;
};

int main()
{
	struct test_list myList;
	struct test_list *tmp;
	struct list_head *tmp_list;
	unsigned int i;

	// 初始化表头结点，表头结点的 data 域无意义
	INIT_LIST_HEAD(&myList.list);
	
	// 此时才开始创建链表的其与元素
	for (i = 5; i; i--) 
	{
		tmp = (struct test_list *)malloc(sizeof(struct test_list));
		printf("initializing list items %d... \n", i);
		tmp->data = i;
		list_add(&(tmp->list), &(myList.list));
	}

	printf("initialization finished. \n");

    __list_for_each(tmp_list, &(myList.list))
		printf("%p: ", tmp_list); // 地址以 32 为存储成功
        // 此时没办法引用 list_head 结构体外的数据

//	list_for_each_entry(tmp, &(myList.list), tmp->list)
//		printf("%d\n", tmp->data);
//

    // 根据list变量地址，获取entry的地址
    // list_entry(myList.list, (struct test_list), list); 

	return 0;
}
// https://www.cnblogs.com/muahao/p/8109733.html
// https://www.cnblogs.com/Anker/p/3472271.html
// https://blog.csdn.net/ggxxkkll/article/details/7591766
