#include <linux/kernel.h>
#include <linux/sched.h>
#include <linux/init.h>
#include <linux/module.h>
#include <linux/list.h>
#include <linux/init_task.h>

static int traverse_init(void)
{
        struct task_struct *task;

        printk(KERN_INFO "Hello, world. \n");

        for_each_process(task) 
                printk(KERN_INFO "%s[%d]\n", task->comm, task->pid);

        return 0;
}

static void traverse_exit(void)
{
       printk(KERN_INFO "Finish.\n"); 
}

module_init(traverse_init);
module_exit(traverse_exit);
