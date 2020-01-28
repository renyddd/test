Linux kernel 中存在着太多的宏，虽说这样做有助于开发人员对内核代码的复用，但这无疑提高了你一窥内核的门槛。

我共选择参考了三个内核版本互作补充，它们是 2.6.11、2.6.34.5 以及 5.3.8。这样做的唯一原因便是，避开一些宏的依赖，以便你能立马执行从 kernel 中摘出的代码。

我需要再次强调的是，我们避开的仅仅是那些为了系统或是编译器优化而存在的宏（就像  WRITE_ONCE、prefetch(x) 这样的），而非大量关键的、必要的宏。也许日后的某一天，我们会讨论到它们。

只要是你在后面看到的内核代码，你都可以在 kernel.org 网站中免费下载。

同时接下来链表部分的代码，你都可在源代码目录的 include/linux/list.h 文件中找见他们。
## 内核链表的结构
首先你能从下面的定义中看出来的是，struct list_head 是一个双向链表，没错，它的定义就是下面这么简单。
```c
struct list_head {
	struct list_head *next, *prev;
};
```
![在这里插入图片描述](https://img-blog.csdnimg.cn/20200128153242840.png =200x)
不过它与你之前所学习的链表有一处不同，我相信你也会觉得它在哪里怪怪的，它没有数据域！乍看起来，它就好像没有操作系统的电脑一样，除了会占用空间好像并没什么用。

再来回忆一下，你之前学习的链表也许是这样定义的，
```c
struct normal_list {
	int data;
	struct normal_list *next, *prev;
 };
```
![在这里插入图片描述](https://img-blog.csdnimg.cn/20200128153855130.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzM5MTMxMA==,size_16,color_FFFFFF,t_70 =200x)
而在你对 kernel 提供给你的链表进行封装之后，便是这个样子：
![在这里插入图片描述](https://img-blog.csdnimg.cn/20200128173903769.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MzM5MTMxMA==,size_16,color_FFFFFF,t_70 =200x)
后面的代码，我们就将对  struct fox 构成的链表进行操作。
```c
struct fox {
	int data;
	struct list_head list;                                                                
};
```

这就是内核黑客们的高明之处了，你需要先将其嵌入到你所需要的数据结构中，而后使用。换句话说，你不是向链表这个结构内塞入数据，而是将 kernel 提供给你的这个链表节点塞入到你的数据中。
## 内核链表的构造
有了你的节点结构后，kernel 也提供给你了构造链表的宏 ，

```c
LIST_HEAD(fox_list)
```
执行上述代码系统便为你定义并初始化了一个  struct list_head 类型的头节点 fox_list，只不过此时它仅仅还是只有一个节点的双向循环链表。
![在这里插入图片描述](https://img-blog.csdnimg.cn/20200128164344143.png =100x)
这里放上宏定义的源代码：
```c
#define LIST_HEAD_INIT(name) { &(name), &(name) }

#define LIST_HEAD(name) \
	struct list_head name = LIST_HEAD_INIT(name)
```
## 为其添加新节点
当然 kernel 不会仅仅给你一个节点的构造方案，它还提供给你了一整套链表的操作，这些也正是运行在世界上成千上万台 Linux 主机上的代码，首先你将看到的是：
```c
static inline void __list_add(struct list_head *new,
	struct list_head *prev,                                         
	struct list_head *next)
{
	next->prev = new;
	new->next = next;
	new->prev = prev;
	prev->next = new;
}

static inline void list_add_tail(struct list_head *new, struct list_head *head)
{
	 __list_add(new, head->prev, head);
}
```
在这里我仅仅画出，为头节点添加第一个节点的过程，后面就需要你自己来体验 kernel 链表设计的巧妙了。
```c
list_add_tail(&(f->list),   &(fox_list));
```
![在这里插入图片描述](https://img-blog.csdnimg.cn/2020012817592434.png =400x)
## 节点的遍历
这里先给出你可以复用的 kernel 链表结构的代码，然后再来讨论两种不同的遍历方式。
```c
struct fox {
	int data;
	struct list_head list;
};
int main()
{
	LIST_HEAD(fox_list);
	      
	struct  list_head  *pos,  *n; //n for removal use.
	struct  fox  *f;  // f for loop use.
	int i;
	
	for (i = 0; i < 3; i++) {
	    f = (struct fox *)malloc(sizeof(struct fox));
	    f->data = 0 + i;
	     list_add_tail(&f->list, &fox_list);
	     
	return 0;
}
```
阅读上面的代码，你会发现这样一个问题：上面在循环时，你仅仅用 f 这个循环变量接收过 struct fox 结构的地址，那么你所拥有的仅仅是内嵌的链表结构的每一个前后指针，以及一个头结点的地址；换句话说，此时你还是很难输出 struct fox 中数据域的值。
### 方式一：list_for_each
不过在这种情况下，你还是可以来遍历输出他们的地址玩一玩的。
```c
#define list_for_each(pos, head) \
	for (pos = (head)->next; pos != (head); pos = pos->next)
                
// 定义与应用

list_for_each(pos, &fox_list) 
	printf("%d memory address: %p\n", i++, pos);
```
其中 pos 为 struct list_head 类型的指针变量，用作为循环变量；head 则为你的表头节点的地址。此时我们进行输出的内容为嵌入在内的链表结构的起始地址。

接下来要用到的 list_entry 宏，又引出了另一个重要的宏 container_of 
```c
#define list_entry(ptr, type, member) \
	container_of(ptr, type, member)
                
#define container_of(ptr, type, member) ({      						      	 \
	const typeof( ((type *)0)->member ) *__mptr = (ptr); 	 \
	(type *)( (char *)__mptr - offsetof(type,member) );})
                
 /**
 * container_of - cast a member of a structure out to the containing structure
 * @ptr:				the pointer to the member.
 * @type:				the type of the container struct this is embedded in.
 * @member:		the name of the member within the struct.
 */
```
此处我们只对 container_of 的用处做分析，container 即为容器之意，再回想前文的内容，kernel 对链表结构的处理是将其嵌入到所需处的结构之中。接着再来看看 container_of 的参数，ptr 为指向某容器内内嵌变量的指针；type 为嵌入在容器内的结构体类型；member 为你定义的嵌入在容器内的变量名。

```c
list_for_each(pos,   &fox_list)   {
	f   =   list_entry(pos,   struct fox,   list);
	printf("info: %d\n",   f->data);
}
```
经过这样处理，你就可以从指向 struct list_head 类型变量的指针中，获得它的容器即 struct fox 类型变量的地址了。
### 方式二：list_for_each_entry
与上面相比，方式二中用到的宏 list_for_each_enrty 已对宏 list_entry 进行了封装，便更为灵活更为优雅。

还要再加上两个新的宏，一个是将指针搬移到链表的第一个节点，另一个是搬移到下一个节点，都不过是宏 list_entry 的封装罢了。
```c
#define list_next_entry(pos, member) \
	list_entry((pos)->member.next, typeof(*(pos)), member)

#define list_first_entry(ptr, type, member) \
	list_entry((ptr)->next, type, member)

/**
 * list_for_each_entry	-	iterate over list of given type
 * @pos:	the type * to use as a loop cursor.
 * @head:	the head for your list.
 * @member:	the name of the list_head within the struct.
 */
#define list_for_each_entry(pos, head, member)								\
	for (pos = list_first_entry(head, typeof(*pos), member);	\
		&pos->member != (head);												\
		pos = list_next_entry(pos, member))
```
其参数与方式一中提到的都较为相似，毕竟 list_for_each_enrty 算是他们的混合体吧，下面同样给出一个遍历的应用：
```c
list_for_each_entry(f,   &fox_list,   list)
	printf("info: %d\n",   f->data);
```
## 链表的销毁
这篇文章里暂不讨论链表的删改查操作，而是直接进行链表的销毁操作。
```c
#define list_for_each_entry_reverse(pos, head, member)
static inline void list_del(struct list_head *entry)
static inline void list_replace(struct list_head *old, struct list_head *new)
static inline void list_swap(struct list_head *entry1, struct list_head *entry2)
static inline void list_move(struct list_head *list, struct list_head *head)
static inline void list_cut_before(struct list_head *list, struct list_head *head, struct list_head *entry)
/*
 * ......
 */
```
向上面这些见名知意的操作，你都可以在  include/linux/list.h 文件中找见他们，并且免费使用。

那么接着刚刚的程序，离一个完整的链表应用，你所差的也就是对 malloc 所分配来的动态内存进行释放操作了。同样，先放出来需要用到的新的宏：
```c
/**
 * list_for_each_safe - iterate over a list safe against removal of list entry
 * @pos:	the &struct list_head to use as a loop cursor.
 * @n:		another &struct list_head to use as temporary storage
 * @head:	the head for your list.
 */
#define list_for_each_safe(pos, n, head) \
	for (pos = (head)->next, n = pos->next; pos != (head); \
	pos = n, n = pos->next)
```
而后是释放操作的代码，
```c
list_for_each_safe(pos,   n,   &fox_list) {
	f   =   list_entry(pos,   struct fox,   list);
	free(f);
}
```
还好这与之前所学的不带 safe 后缀的遍历还是蛮像的嘛，这里仅仅是多了一个与 pos 同类型的变量 n，n 是作为遍历链表时对下一个节点地址的临时存储，以免发生遍历时找不到后继节点的情况。
