//
//  ImageDownloadOperation.h
//  iOSTips
//
//  Created by Kenvin on 17/1/12.
//  Copyright © 2017年 上海方创金融信息服务股份有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^completeHanderBlock)(NSURLResponse *response, NSData *data, NSError *connectionError);

@interface ImageDownloadOperation : NSOperation

/**
 *  图片地址
 */
@property (nonatomic, copy) NSString *imageUrl;

@property (nonatomic,copy)  completeHanderBlock  completeBlock;

/**
 *  下载图片的网路请求类
 *
 *  @param url           下载的网址
 *  @param downloadBlock 回调
 *  @return 实例
 */

+ (instancetype)operationWithImageUrl:(NSString *)url
                              completeHander:(completeHanderBlock)downloadBlock;
@end
