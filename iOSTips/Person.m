//
//  Person.m
//  iOSTips
//
//  Created by Kenvin on 17/1/10.
//  Copyright © 2017年 上海方创金融信息服务股份有限公司. All rights reserved.
//

#import "Person.h"

static NSString *const NAME = @"name";
@implementation Person

//实现手动通知的类必须重写NSObject中对automaticallyNotifiesObserversForKey:方法的实现。这个方法是在NSKeyValueObserving协议中声明的。这个方法返回一个布尔值(默认是返回YES)，以标识参数key指定的属性是否支持自动KVO。如果我们希望手动去发送通知，则针对指定的属性返回NO。

+ (BOOL)automaticallyNotifiesObserversForKey:(NSString *)key {
    
    BOOL automatic = YES;
    //如果检测到健值为 name的key,指定为非自动监测对象。
    if ([key isEqualToString:NAME]) {
        automatic = NO;
    } else {
        automatic = [super automaticallyNotifiesObserversForKey:key];
    }
    
    return automatic;
}

//重写要手动实现kvo的属性的setter。

- (void)setName:(NSString *)name{
    //做这个判断以后只有在属性值真的改变以后才会激发kvo

    if (name != _name) {
        [self willChangeValueForKey:NAME];
        _name = name;
        [self didChangeValueForKey:NAME];
    }
}


@end
