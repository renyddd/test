#include <linux/kernel.h>
#include <linux/sched.h>
#include <linux/init.h>
#include <linux/module.h>
#include <linux/list.h>
#include <linux/init_task.h>

static int __init traverse_init(void)
{
        struct task_struct *task;

        for (task = current; task != &init_task; task = task->parent)
                ;

        printk("Hey, I am traversing.\n");
        return 0;
}

static void __exit traverse_exit(void)
{
       printk("Bye\n"); 
}

module_init(traverse_init);
module_exit(traverse_exit);

MODULE_LICENSE("GPL");
