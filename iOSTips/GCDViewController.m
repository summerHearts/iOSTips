//
//  GCDViewController.m
//  iOSTips
//
//  Created by Kenvin on 17/1/10.
//  Copyright © 2017年 上海方创金融信息服务股份有限公司. All rights reserved.
//

#import "GCDViewController.h"


@interface GCDViewController ()

@end

@implementation GCDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*
     1: GCD 是什么？
     GCD全称Grand Central Dispatch
     
     GCD 在后端管理着一个线程池。GCD 不仅决定着你的代码块将在哪个线程被执行，它还根据可用的系统资源对这些线程进行管理。这样可以将开发者从线程管理的工作中解放出来，通过集中的管理线程，来缓解大量线程被创建的问题。
     GCD 带来的另一个重要改变是，作为开发者可以将工作考虑为一个队列，而不是一堆线程，这种并行的抽象模型更容易掌握和使用。当多个队列要处理块时，系统可以自由分配额外的线程来同时调用块。当队列变空时，这些线程会自动释放.
     
     首先，系统提供给你一个叫做 主队列（main queue） 的特殊队列。和其它串行队列一样，这个队列中的任务一次只能执行一个。然而，它能保证所有的任务都在主线程执行，而主线程是唯一可用于更新 UI 的线程。这个队列就是用于发生消息给 UIView 或发送通知的。
     
     系统同时提供给你好几个并发队列。它们叫做 全局调度队列（Global Dispatch Queues） 。目前的四个全局队列有着不同的优先级：background、low、default 以及 high。要知道，Apple 的 API 也会使用这些队列，所以你添加的任何任务都不会是这些队列中唯一的任务。
     
     最后，你也可以创建自己的串行队列或并发队列。
        主队列、
        串行队列、
        并发队列。
     
     2.GCD相比其他多线程有哪些优点？
     
     GCD 能通过推迟昂贵计算任务并在后台运行它们来改善你的应用的响应性能。
     GCD 提供一个易于使用的并发模型而不仅仅只是锁和线程，以帮助我们避开并发陷阱。
     GCD 具有在常见模式（例如单例）上用更高性能的原语优化你的代码的潜在能力。
     GCD 会自动利用更多的CPU内核（比如双核、四核）
     3.GCD术语
     
     串行（Serial）：让任务一个接着一个地执行（一个任务执行完毕后，再执行下一个任务）
     并发（Concurrent）：可以让多个任务并发（同时）执行（自动开启多个线程同时执行任务）并发功能只有在异步（dispatch_async）函数下才有效。
     同步（Synchronous）：在当前线程中执行任务，不具备开启新线程的能力
     异步（Asynchronous）：在新的线程中执行任务，具备开启新线程的能力

     */
    
    /*
     1 ：GCD队列类型：
     
     类型	描述
     Serial	串行队列将任务以先进先出(FIFO)的顺序来执行，所以串行队列经常用来做访问某些特定资源的同步处理。你可以也根据需要创建多个队列，而这些队列相对其他队列都是并发执行的。换句话说，如果你创建了4个串行队列，每一个队列在同一时间都只执行一个任务，对这四个任务来说，他们是相互独立且并发执行的。如果需要创建串行队列，一般用dispatch_queue_create这个方法来实现。
     Concurrent	并发队列虽然是能同时执行多个任务，但这些任务仍然是按照先到先执行(FIFO)的顺序来执行的。并发队列会基于系统负载来合适地选择并发执行这些任务。在iOS5之前，并发队列一般指的就是全局队列(Global queue)，进程中存在四个全局队列：高、中(默认)、低、后台四个优先级队列，可以调用dispatch_get_global_queue函数传入优先级来访问队列。而在iOS5之后，我们也可以用dispatch_queue_create，并指定队列类型DISPATCH_QUEUE_CONCURRENT，来自己创建一个并发队列。
   
     */
    // 异步全局队列： Concurrent 又称为global dispatch queue，可以并发地执行多个任务，但是执行完成的顺序是随机的。
    // 同步主队列： Main dispatch queue	与主线程功能相同。实际上，提交至main queue的任务会在主线程中执行。main queue可以调用dispatch_get_main_queue()来获得。因为main queue是与主线程相关的，所以这是一个串行队列。和其它串行队列一样，这个队列中的任务一次只能执行一个。它能保证所有的任务都在主线程执行，而主线程是唯一可用于更新 UI 的线程。
    
    //[self dispatch_serialQueue];
    
    //[self dispatch_concurrentQueue];
    
    
    //2: GCD里面有多少种全局队列？
    /*
     　Global Dispatch Queue有如下8种:
     
     　　　　Global Dispatch Queue (High priority)
     　　　　Global Dispatch Queue (Default priority)
     　　　　Global Dispatch Queue (Low priority)
     　　　　Global Dispatch Queue (Background priority)
     　　　　Global Dispatch Queue (High overcommit priority)
     　　　　Global Dispatch Queue (Default overcommit priority)
     　　　　Global Dispatch Queue (Low overcommit priority)
     　　　　Global Dispatch Queue (Background overcommit priority)
     
     　　注意前面四种 和后面四种不同优先级的Queue有一词之差:Overcommit。其区别就在于Overcommit Queue不管系统状态如何都会强制生成线程队列。
     */

   // [self dispath_mainQueue];
    
   // [self dispatch_queue_t];
   
   // [self dispatch_semaphore];

   // [self dispatch_barrier_async];
    
    //[self dispatch_once_t];
   
    //[self dispatch_queue_after];
    
    //[self dispatch_queue_group];

  
   // [self dispatchQueueQuestion];
}

#pragma mark - 常见问题总结


- (void)dispatchQueueQuestion{
    /*
     dispatch_sync表示同步的执行任务，也就是说执行dispatch_sync后，当前队列会阻塞。而dispatch_sync中的block如果要在当前队列中执行，就得等待当前队列程执行完成。
     
     在上面这个例子中，主队列在执行dispatch_sync，随后队列中新增一个任务block。因为主队列是同步队列，所以block要等dispatch_sync执行完才能执行，但是dispatch_sync是同步派发，要等block执行完才算是结束。在主队列中的两个任务互相等待，导致了死锁。
     */
    NSLog(@"current thread = %@", [NSThread currentThread]);

    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    dispatch_sync(mainQueue,^{
        NSLog(@"current thread = %@", [NSThread currentThread]);
        NSLog(@"该句话不会被执行");
    });
}


#pragma mark - 串行队列
- (void)dispatch_serialQueue{
    //串行队列
    dispatch_queue_t serialQueue;
    serialQueue = dispatch_queue_create("com.example.SerialQueue", DISPATCH_QUEUE_SERIAL);// dispatch_queue_attr_t设置成NULL的时候默认代表串行。
    dispatch_async(serialQueue, ^{
         // something
         NSLog(@"current thread = com.example.SerialQueue  %@", [NSThread currentThread]);
    });
}
#pragma mark - 并发队列
- (void)dispatch_concurrentQueue{
    //并发队列
    dispatch_queue_t concurrentQueue;
    concurrentQueue = dispatch_queue_create("com.example.ConcurrentQueue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        // something
        NSLog(@"current thread = com.example.ConcurrentQueue %@", [NSThread currentThread]);
    });
}

#pragma mark - 主队列
- (void)dispath_mainQueue{
    // 主队列：
    dispatch_queue_t mainQueue;
    mainQueue = dispatch_get_main_queue();
    
    dispatch_async(dispatch_get_main_queue(), ^{
        // something
        NSLog(@"current thread = %@  main ", [NSThread currentThread]);
        
    });
}

#pragma mark - 自定义dispatch_queue_t
- (void)dispatch_queue_t{
    // 自定义dispatch_queue_t
    dispatch_queue_t emailQueue = dispatch_queue_create("www.summerHearts@163.com", NULL);
    dispatch_async(emailQueue, ^{
        NSLog(@"current thread = %@", [NSThread currentThread]);
    });
}

#pragma mark -信号量
- (void)dispatch_semaphore{
    //信号量：
    /*
     dispatch Semaphore 是持有计数的信号，该计数是多线程编程中的计数类型信号。所谓信号，就是过马路时常用的手旗。可以通过时举起手旗，不可通过时放下手旗。使用计数来实现该功能。计数为0时等待，计数为1或者大于1，减去1而不等待。
     */
    
    dispatch_queue_t queues = dispatch_queue_create(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(1);
    
    NSMutableArray *array = [NSMutableArray array];
    
    for (int i = 0; i <  10; ++i) {
        dispatch_async(queues, ^{
            /*
             * 等待 Dispatch Semaphore.
             * 一直等待，直到Dispatch Semaphore的计数达到大于等于1
             *  // 由于是异步执行的，所以每次循环Block里面的dispatch_semaphore_signal根本还没有执行就会执行dispatch_semaphore_wait，从而semaphore-1.当循环10此后，semaphore等于0，则会阻塞线程，直到执行了Block的dispatch_semaphore_signal 才会继续执行
             */
            
            long result =  dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
            NSLog(@">>>>   %ld",result);
            
            /*
                此时 result为0， 可安全的执行需要进行排他控制的处理。该处理结束的时候通过dispatch_semaphore_signal函数将dispatch_semaphore的计数值加1.
             */
            /*
             由于Dispatch semaphore 的计数值达到大于或者等于等一1,所以将 Dispatch semaphore的计数值减去1. dispatch_semaphore_wait函数执行返回。即执行到此，Dispatch semaphore 的计数值为0.
             
             */
            [array addObject:[NSNumber numberWithInt:i]];
            
            /*
             dispatch_semaphore_signal函数将dispatch semaphore 的计数值加1.如果有通过 dispatch_semaphore_wait函数等待 dispatch semaphore的计数值增加的线程就由最先等待的线程执行。
             */
            dispatch_semaphore_signal(semaphore);
        });
            //dispatch_semaphore_wait 函数等待Dispatch Semaphore的计数值达到大于或者等于1.当计数值大于等于1，或者在待机中技术值大于或者等于1，对该计数进行减法并从dispatch_semaphore_wait函数返回。
    }
}
#pragma mark - 栅栏
- (void)dispatch_barrier_async{
    // 自定义并发队列
    /*
     通过dispatch_barrier_async函数提交的任务会等它前面的任务执行完才开始，然后它后面的任务必须等它执行完毕才能开始.
     必须使用dispatch_queue_create创建的队列才会达到上面的效果.dispatch_barrier_async 起到了“承上启下”的作用。它保证此前的任务都先于自己执行，此后的任务也迟于自己执行。正如barrier的含义一样，它起到了一个栅栏、或是分水岭的作用。
     这样一来，使用并行队列和 dispatc_barrier_async 方法，就可以高效的进行数据和文件读写了。
    */

    /*
     dispatch_barrier_async函数会等待追加到concurrent dispatch queue 上的并行执行的处理全部结束之后，再将制订的处理追加到该concurrent dispatch queue中。然后再由dispatch_barrier_async函数追加的处理执行完毕之后，concurrent dispatch queue才恢复过来一般的动作，追加到该concurrent dispatch queue的处理又开始并行执行。
     */
    /*----------------------------------------------*/
    // 自定义串行队列
    dispatch_queue_t serialQueue = dispatch_queue_create("my.concurrent.queue", DISPATCH_QUEUE_SERIAL);
    
    dispatch_async(serialQueue, ^() {
        NSLog(@"dispatch_async--1");
    });
    
    dispatch_async(serialQueue, ^() {
        NSLog(@"dispatch_async--2");
    });
    
    dispatch_barrier_async(serialQueue, ^() {
        NSLog(@"dispatch-barrier_async");
        sleep(1);
    });
    
    // 虽然异步, 但是在串行队列中, 会按照顺序执行
    dispatch_async(serialQueue, ^() {
        NSLog(@"dispatch_async--3");
        sleep(1);
    });
    
    dispatch_async(serialQueue, ^() {
        NSLog(@"dispatch_async--4");
    });
}

#pragma mark - 一次操作
- (void)dispatch_once_t{
    // 一次性执行：
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // code to be executed once
    });
}
#pragma mark -延时执行操作
- (void)dispatch_queue_after{
    // 延迟2秒执行：
    double delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        // code to be executed on the main queue after delay
    });
}
#pragma mark - 线程组
- (void)dispatch_queue_group{
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_async(group, dispatch_get_global_queue(0,0), ^{
        // 并行执行的线程一
    });
    dispatch_group_async(group, dispatch_get_global_queue(0,0), ^{
        // 并行执行的线程二
    });
    dispatch_group_notify(group, dispatch_get_global_queue(0,0), ^{
        
        NSLog(@"current thread = %@", [NSThread currentThread]);
        
    });
}


@end
