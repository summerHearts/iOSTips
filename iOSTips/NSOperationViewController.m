//
//  NSOperationViewController.m
//  iOSTips
//
//  Created by Kenvin on 17/1/11.
//  Copyright © 2017年 上海方创金融信息服务股份有限公司. All rights reserved.
//

#import "NSOperationViewController.h"
#import "DownloadOperation.h"
#import "ImageDownloadOperation.h"

 /*
     NSOperation 类有一个相当简短的声明。要定制一个操作，可以遵循以下步骤：
     
     继承NSOperation类
     重写“main”方法
 */

@interface NSOperationViewController ()

@property (nonatomic,strong) UIImageView *imageView1;

@property (nonatomic,strong) UIImageView *imageView2;

@end

@implementation NSOperationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    //[self customOperation];
    
    [self.view addSubview:self.imageView1];
    
    [self.view addSubview:self.imageView2];

    
    [self downloadImage];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)customOperation{
    //下载操作
    DownloadOperation *operation1 = [[DownloadOperation alloc]initWithDownLoadMark:@"downloadOperation1"];
    DownloadOperation *operation2 = [[DownloadOperation alloc]initWithDownLoadMark:@"downloadOperation2"];
    
    //将所有的任务放在操作队列中
    NSOperationQueue *operationQueue = [[NSOperationQueue alloc]init];
    operationQueue.name = @"downloadOperationQueue";
    
    operationQueue.maxConcurrentOperationCount = 100;
    
    [operation1 addDependency:operation2];
    
    [operationQueue addOperation:operation1];
    [operationQueue addOperation:operation2];
    // [operationQueue addOperation:operation2]; 重复添加operation，程序会崩溃。无法重复添加相同的操作队列，只能重新初始化操作队列。
    
    NSArray *allOperation = [operationQueue operations];
    NSLog(@">>>>  当前所有操作队列的集合是：%@",allOperation);
    
    //每个操作都有自己的完成回调
    [operation1 setCompletionBlock:^{
        NSLog(@">>>>>>   downloadOperation1 completion");
    }];
    
    [operation2 setCompletionBlock:^{
        NSLog(@">>>>>>   downloadOperation2 completion");
    }];
    
    // 取消某个操作任务
    [self execute:^{
        [operation1 cancel];
    } afterDelay:1.0f];
    
    //这个方法会挂起或者恢复一个执行的任务.挂起一个队列可以阻止该队列中没有开始的任务.换句话说,在任务队列中还没有开始执行的任务是会被挂起的,直到这个挂起操作被恢复.
    [self execute:^{
        //此时operation1还没有执行， 所以将会被挂起。 而已经执行的operation2将会继续执行，直至结束。
        [operationQueue setSuspended:YES];
    } afterDelay:0.3f];
    
    //恢复所有被挂起的操作
    [self execute:^{
        [operationQueue setSuspended:NO];
    } afterDelay:4.0f];
    
    //取消所有队列任务
    [self execute:^{
        /*
         要取消一个队列中的所有操作，只要调用“cancelAllOperations”方法即可。还记得之前提醒过经常检查NSOperation中的isCancelled属性吗？
         原因是“cancelAllOperations”并没有做太多的工作，他只是对队列中的每一个操作调用“cancel”方法 — 这并没有起很大作用！:] 如果一个操作并没有开始，然后你对它调用“cancel”方法，操作会被取消，并从队列中移除。然而，如果一个操作已经在执行了，这就要由单独的操作去识 别撤销（通过检查isCancelled属性）然后停止它所做的工作。
         */
        [operationQueue cancelAllOperations];
    } afterDelay:5.0f];
}
/*
    单个图片下载方法
 */
#pragma mark -图片下载方法
- (void)downloadImage{
    NSString *imageUrlStrin1 = @"http://ww2.sinaimg.cn/mw690/643be833gw1fba9vmlh08j21o42hc4qq.jpg";
    NSString *imageUrlString2 = @"http://wx4.sinaimg.cn/mw690/68147f68ly1fbnkw2voj1j207w04y3ye.jpg";

    NSOperationQueue *queue     = [[NSOperationQueue alloc] init];
    ImageDownloadOperation *imageDownOperation1 = [ImageDownloadOperation operationWithImageUrl:imageUrlStrin1 completeHander:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (data.length<=0) {
            return ;
        }else{
            self.imageView1.image = [UIImage imageWithData:data];
        }
    }];
    
    ImageDownloadOperation *imageDownOperation2 = [ImageDownloadOperation operationWithImageUrl:imageUrlString2 completeHander:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (data.length<=0) {
            return ;
        }else{
            self.imageView2.image = [UIImage imageWithData:data];
        }
    }];
    [queue addOperation:imageDownOperation1];
    [queue addOperation:imageDownOperation2];

}
/*
 需要注意的点：
 1:如果需要取消某个操作任务，可以调用 [operation cancle]方法。同时需要在重写的main函数中，做相应的移除，终止操作。
 2: 一旦操作提交到线程操作队列中，就不能设置某个操作任务的依赖属性等等。比如上边例子中 [operation1 addDependency:operation2]; 放在  [operationQueue addOperation:operation1]; 之前 和之后是完全不同的。放在加入操作队列之前还是能够起作用，放在之后，就不起任何作用。所以别放错位置。
 3: 取消了一个操作，它不会马上就发生。它会在未来的某个时候某人在“main”函数中明确地检查isCancelled == YES 时被取消掉；否则，操作会一直执行到完成为止。
    这样就会导致一个问题，可能这个操作任务在你调用取消函数之前就返回了，所以看到的情况就是我明明对该操作做了取消，为什么还有返回数据的原因。
 4: 挂起一个队列不会让一个已经执行的任务停止.
 5: NSOperationQueue并不能将单个的NSOperation进行挂起操作，NSOperation自身也无法将自己暂停后再进行恢复操作，当NSOperation取消了之后，你再也无法对其进行恢复操作了，在NSOperationQueue上，是无法实现的。
 */

- (void)execute:(dispatch_block_t)block   afterDelay:(int64_t)time{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time * NSEC_PER_SEC)), dispatch_get_main_queue(), block);
}

- (UIImageView *)imageView1{
    if (!_imageView1) {
        _imageView1 = [[UIImageView alloc]init];
        _imageView1.frame = CGRectMake(100, 100, 80, 80);
    }
    return _imageView1;
}

- (UIImageView *)imageView2{
    if (!_imageView2) {
        _imageView2 = [[UIImageView alloc]init];
        _imageView2.frame = CGRectMake(100, 200, 80, 80);
    }
    return _imageView2;
}
@end
