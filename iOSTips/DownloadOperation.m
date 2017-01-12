//
//  DownloadOperation.m
//  iOSTips
//
//  Created by Kenvin on 17/1/12.
//  Copyright © 2017年 上海方创金融信息服务股份有限公司. All rights reserved.
//

#import "DownloadOperation.h"

@interface DownloadOperation ()

@property (nonatomic,copy,readwrite) NSString *downloadMark;

@end

@implementation DownloadOperation

- (instancetype)initWithDownLoadMark:(NSString *)downloadMark{
    if (self == [super init]) {
        self.downloadMark = downloadMark;
    }
    return self;
}

// 必须实现main函数
- (void)main{
    @autoreleasepool {
        for (int i = 0; i< 10000; i++) {
            if (self.isCancelled) {
                break;
            }
            NSLog(@">>>  %@ 当前运行到 %d 个任务",self.downloadMark,i);
        }
    }
}
@end
