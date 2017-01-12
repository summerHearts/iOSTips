//
//  DownloadOperation.h
//  iOSTips
//
//  Created by Kenvin on 17/1/12.
//  Copyright © 2017年 上海方创金融信息服务股份有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DownloadOperation : NSOperation

@property (nonatomic,copy,readonly) NSString *downloadMark;

- (instancetype)initWithDownLoadMark:(NSString *)downloadMark;

@end
