#include <stdio.h>
#include <stdlib.h>
#include "list.h"
struct kool_list{
    int to;
    struct list_head list;
    int from;
};
int main(int argc, char **argv){
    struct kool_list *tmp;
    struct list_head *pos, *q;
    unsigned int i;
    struct kool_list mylist;
    INIT_LIST_HEAD(&mylist.list);
    /* 您也可以使用宏LIST_HEAD(mylist)来声明并初始化这个链表 */
    /*向链表中添加元素*/
    for(i=5; i!=0; --i){
        tmp= (struct kool_list *)malloc(sizeof(struct kool_list));
        /*INIT_LIST_HEAD(&tmp->list); 调用这个函数将初始化一个动态分配的list_head。也可以不调用它，因为在后面调用的add_list()中将设置next和prev域。*/
        printf("enter to and from:");
        scanf("%d %d", &tmp->to, &tmp->from);
        /*将tmp添加到mylist链表中*/
        list_add(&(tmp->list), &(mylist.list));
        /*也可以使用list_add_tail()将新元素添加到链表的尾部。*/
    }
    printf("/n");
    /*现在我们得到了数据结构struct kool_list的一个循环链表，我们将遍历这个链表，并打印其中的元素。*/
    /*list_for_each()定义了一个for循环宏，第一个参数用作for循环的计数器，换句话说，在整个循环过程中它指向了当前项的list_head。第二个参数是指向链表的指针，在宏中保持不变。*/
    printf("traversing the list using list_for_each()/n");
    list_for_each(pos, &mylist.list){
        /*此刻：pos->next指向了下一项的list变量，而pos->prev指向上一项的list变量。而每项都是 struct kool_list类型。但是，我们需要访问的是这些项，而不是项中的list变量。因此需要调用list_entry()宏。*/
        tmp= list_entry(pos, struct kool_list, list);
        /*给定指向struct list_head的指针，它所属的宿主数据结构的类型，以及它在宿主数据结构中的名称，list_entry返回指向宿主数据结构的指针。例如，在上面 一行， list_entry()返回指向pos所属struct kool_list项的指针。*/
        printf("to= %d from= %d/n", tmp->to, tmp->from);
    }
    printf("/n");
    /* 因为这是一个循环链表，我们也可以向前遍历。只需要将list_for_each替换为list_for_each_prev。我们也可以使用list_for_each_entry()遍历链表，在给定类型的项间进行循环。例如：*/
    printf("traversing the list using list_for_each_entry()/n");
    list_for_each_entry(tmp, &mylist.list, list)
    printf("to= %d from= %d/n", tmp->to, tmp->from);
    printf("/n");
    /*下面将释放这些项。因为我们调用list_del()从链表中删除各项，因此需要使用list_for_each()宏的"安全"版本，即 list_for_each_safe()。务必注意，如果在循环中有删除项（或把项从一个链表移动到另一个链表）的操作，必须使用这个宏。*/
    printf("deleting the list using list_for_each_safe()/n");
    list_for_each_safe(pos, q, &mylist.list){
        tmp= list_entry(pos, struct kool_list, list);
        printf("freeing item to= %d from= %d/n", tmp->to, tmp->from);
        list_del(pos);
        free(tmp);
    }
    return 0;
}
