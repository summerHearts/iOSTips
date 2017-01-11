//
//  NotificationCenterController.m
//  iOSTips
//
//  Created by Kenvin on 17/1/10.
//  Copyright © 2017年 上海方创金融信息服务股份有限公司. All rights reserved.
//

#import "NotificationCenterController.h"

static NSString *const TEST_NOTIFICATION = @"TEST_NOTIFICATION";

@interface NotificationCenterController ()<NSMachPortDelegate>

@property (nonatomic) NSMutableArray    *notifications;         // 通知队列
@property (nonatomic) NSThread          *notificationThread;    // 期望线程
@property (nonatomic) NSLock            *notificationLock;      // 用于对通知队列加锁的锁对象，避免线程冲突
@property (nonatomic) NSMachPort        *notificationPort;      // 用于向期望线程发送信号的通信端口


@end

@implementation NotificationCenterController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    /*
     尽量在一个线程中处理通知相关的操作，大部分情况下，这样做都能确保通知的正常工作。不过，我们无法确定到底会在哪个线程中调用dealloc方法，所以这一点还是比较困难。
     注册监听都时，使用基于block的API。这样我们在block还要继续调用self的属性或方法，就可以通过weak-strong的方式来处理。具体大家可以改造下上面的代码试试是什么效果。
     使用带有安全生命周期的对象，这一点对象单例对象来说再合适不过了，在应用的整个生命周期都不会被释放。
     使用代理。

     */

    NSLog(@"current thread = %@", [NSThread currentThread]);
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleNotification:) name:TEST_NOTIFICATION object:nil];
//    
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        //主线程中注册了通知的观察者，但在全局队列中post的Notification，并不是在主线程处理的。所以，这时候就需要注意，如果我们想在回调中处理与UI相关的操作，需要确保是在主线程中执行回调。
//        [[NSNotificationCenter defaultCenter] postNotificationName:TEST_NOTIFICATION object:nil userInfo:nil];
//    });
    
    // 初始化
    self.notifications = [[NSMutableArray alloc] init];
    self.notificationLock = [[NSLock alloc] init];
    
    self.notificationThread = [NSThread currentThread];
    self.notificationPort = [[NSMachPort alloc] init];
    self.notificationPort.delegate = self;
    
    // 往当前线程的run loop添加端口源
    // 当Mach消息到达而接收线程的run loop没有运行时，则内核会保存这条消息，直到下一次进入run loop
    [[NSRunLoop currentRunLoop] addPort:self.notificationPort
                                forMode:(__bridge NSString *)kCFRunLoopCommonModes];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(processNotification:) name:TEST_NOTIFICATION object:nil];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [[NSNotificationCenter defaultCenter] postNotificationName:TEST_NOTIFICATION object:nil userInfo:nil];
        
    });
}


- (void)handleMachMessage:(void *)msg {
    
    [self.notificationLock lock];
    
    while ([self.notifications count]) {
        NSNotification *notification = [self.notifications objectAtIndex:0];
        [self.notifications removeObjectAtIndex:0];
        [self.notificationLock unlock];
        [self processNotification:notification];
        [self.notificationLock lock];
    };
    
    [self.notificationLock unlock];
}

- (void)processNotification:(NSNotification *)notification {
    
    if ([NSThread currentThread] != _notificationThread) {
        // Forward the notification to the correct thread.
        [self.notificationLock lock];
        [self.notifications addObject:notification];
        [self.notificationLock unlock];
        [self.notificationPort sendBeforeDate:[NSDate date]
                                   components:nil
                                         from:nil
                                     reserved:0];
    }
    else {
        // Process the notification here;
        NSLog(@"current thread = %@", [NSThread currentThread]);
        NSLog(@"process notification");
    }
}


- (void)handleNotification:(NSNotification *)notification{
    NSLog(@"current thread = %@", [NSThread currentThread]);
    NSLog(@"test notification");
}

@end
