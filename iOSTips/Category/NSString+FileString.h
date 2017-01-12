//
//  NSString+FileString.h
//  iOSTips
//
//  Created by Kenvin on 17/1/12.
//  Copyright © 2017年 上海方创金融信息服务股份有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (FileString)
+ (NSString *)MD5HashWithString:(NSString *)string;
+ (NSString *)pathWithFileName:(NSString *)name;
@end
