//
//  SecondViewController.m
//  iOSTips
//
//  Created by Kenvin on 17/1/10.
//  Copyright © 2017年 上海方创金融信息服务股份有限公司. All rights reserved.
//

#import "SecondViewController.h"
#import "Student.h"
@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    Student *student = [[Student alloc]init];
    [student addObserver:self forKeyPath:@"desc" options:NSKeyValueObservingOptionNew context:NULL];
    
    student.name = @"BLANK";
    student.age = 10;
   
    //卸载观察者
    [student removeObserver:self forKeyPath:@"desc"];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    NSLog(@"keyPath = %@, change = %@, context = %s", keyPath, change, (char *)context);
}
@end
