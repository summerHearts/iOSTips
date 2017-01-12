//
//  ImageDownloadOperation.m
//  iOSTips
//
//  Created by Kenvin on 17/1/12.
//  Copyright © 2017年 上海方创金融信息服务股份有限公司. All rights reserved.
//

#import "ImageDownloadOperation.h"
#import "NSString+FileString.h"

#define WEAKSELF typeof(self) __weak weakSelf = self;
#define STRONGSELF  typeof(self) __strong strongSelf = self;
#define STRONGTOWEAK  typeof(self) __strong weakSelfToStrong = weakSelf;


@interface ImageDownloadOperation (){
    BOOL        executing;
    BOOL        finished;
}

@property (nonatomic, copy) NSString  *md5String;
@property (nonatomic, copy) NSString  *filePathString;

- (void)completeOperation;
@end

@implementation ImageDownloadOperation


+ (instancetype)operationWithImageUrl:(NSString *)url
                       completeHander:(completeHanderBlock)downloadBlock{
    ImageDownloadOperation *operation = [[ImageDownloadOperation alloc] init];
    operation.imageUrl    = url;
    operation.completeBlock = downloadBlock;
    return operation;
}

- (id)init {
    self = [super init];
    if (self) {
        executing = NO;
        finished = NO;
    }
    return self;
}

- (BOOL)isConcurrent {
    return YES;
}

- (BOOL)isExecuting {
    return executing;
}

- (BOOL)isFinished {
    return finished;
}

- (void)completeOperation {
    [self willChangeValueForKey:@"isFinished"];
    [self willChangeValueForKey:@"isExecuting"];
    
    executing = NO;
    finished = YES;
    
    [self didChangeValueForKey:@"isExecuting"];
    [self didChangeValueForKey:@"isFinished"];
}

- (void)start {
    if ([self isCancelled]){
        [self willChangeValueForKey:@"isFinished"];
        finished = YES;
        [self didChangeValueForKey:@"isFinished"];
        return;
    }
    [self willChangeValueForKey:@"isExecuting"];
    [NSThread detachNewThreadSelector:@selector(main) toTarget:self withObject:nil];
    executing = YES;
    [self didChangeValueForKey:@"isExecuting"];
}


- (void)main {
    if (_imageUrl.length <= 0) {
        
        [self completeOperation];
        return;
    }
    
    // 生成文件路径
    self.md5String      = [NSString MD5HashWithString:_imageUrl];
    self.filePathString = [NSString pathWithFileName:self.md5String];
    
    // 文件如果存在则直接读取
    BOOL exist = [[NSFileManager defaultManager] fileExistsAtPath:self.filePathString isDirectory:nil];
    if (exist) {
        NSData *data =   [NSData dataWithContentsOfFile:self.filePathString];
        self.completeBlock(nil,data,nil);
        [self completeOperation];
        
        return;
    }
    
    NSURL *url = [NSURL URLWithString:self.imageUrl];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:30];
    
    NSURLSession *sharedSession = [NSURLSession sharedSession];
    WEAKSELF
    NSURLSessionDataTask *dataTask = [sharedSession dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        STRONGTOWEAK
        NSLog(@"%@",[NSThread currentThread]);
        if (data && (error == nil)) {
            NSLog(@"data=%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
            [weakSelfToStrong writeData:data toPath:weakSelfToStrong.filePathString];
        } else {
            NSLog(@"error=%@",error);
        }
        weakSelfToStrong.completeBlock(response,data,error);
        [weakSelfToStrong completeOperation];
    }];
    [dataTask resume];
    
    // 让线程不结束
    do {
        
        @autoreleasepool {
            
            [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.1]];
            
            if (self.isCancelled) {
                
                [self completeOperation];
            }
        }
        
    } while (self.isExecuting && self.isFinished == NO);
}

- (void)writeData:(NSData *)data toPath:(NSString *)path {
    //文件操作，需要注意两点：1: 不能同时读写。2:需要判断路径是否是唯一
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [data writeToFile:path atomically:YES];
    });
}
@end
