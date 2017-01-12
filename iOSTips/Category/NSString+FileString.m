//
//  NSString+FileString.m
//  iOSTips
//
//  Created by Kenvin on 17/1/12.
//  Copyright © 2017年 上海方创金融信息服务股份有限公司. All rights reserved.
//

#import "NSString+FileString.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (FileString)

+ (NSString *)MD5HashWithString:(NSString *)string {
    
    CC_MD5_CTX md5;
    
    CC_MD5_Init(&md5);
    CC_MD5_Update(&md5, [string UTF8String], (CC_LONG) [string length]);
    
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5_Final(digest, &md5);
    
    NSString *s = [NSString stringWithFormat: @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                   digest[0],  digest[1],
                   digest[2],  digest[3],
                   digest[4],  digest[5],
                   digest[6],  digest[7],
                   digest[8],  digest[9],
                   digest[10], digest[11],
                   digest[12], digest[13],
                   digest[14], digest[15]];
    
    return s;
}

+ (NSString *)pathWithFileName:(NSString *)name {
    
    NSString *path = [NSString stringWithFormat:@"/Documents/%@", name];
    return [NSHomeDirectory() stringByAppendingPathComponent:path];
}

@end
