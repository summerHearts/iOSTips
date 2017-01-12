//
//  FirstViewController.m
//  iOSTips
//
//  Created by Kenvin on 17/1/10.
//  Copyright © 2017年 上海方创金融信息服务股份有限公司. All rights reserved.
//

#import "FirstViewController.h"
#import "Person.h"
@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    Person *person = [[Person alloc]init];
    
    person.name = @"BLANK";

    //观察手动实现kvo的属性
    [person addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew context:nil];
    
    person.name = @"佐毅";
    
    [person removeObserver:self forKeyPath:@"name"];
    // Do any additional setup after loading the view from its nib.
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    NSLog(@"keyPath = %@, change = %@, context = %s", keyPath, change, (char *)context);
}

@end
