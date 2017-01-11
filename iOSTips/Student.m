//
//  Student.m
//  iOSTips
//
//  Created by Kenvin on 17/1/10.
//  Copyright © 2017年 上海方创金融信息服务股份有限公司. All rights reserved.
//

#import "Student.h"

@implementation Student

- (NSString *)desc{
    return [NSString stringWithFormat:@" name is %@  age is %ld",self.name,self.age];
}

+ (NSSet *)keyPathsForValuesAffectingDesc{
    return [NSSet setWithObjects:@"name", @"age", nil];
}
@end
