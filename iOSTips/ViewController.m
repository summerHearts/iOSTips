//
//  ViewController.m
//  iOSTips
//
//  Created by Kenvin on 17/1/9.
//  Copyright © 2017年 上海方创金融信息服务股份有限公司. All rights reserved.
//

#import "ViewController.h"


static NSString *const CELLIDENTIFIER = @"CELLIDENTIFIER";
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong,nonatomic) NSMutableArray *dataSource;

@property (strong,nonatomic) NSMutableArray *classNameArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"iOSTips";
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CELLIDENTIFIER];
    [self.tableView setDataSource:self];
    [self.tableView setDelegate:self];

    self.dataSource = [NSMutableArray arrayWithObjects:@"手动触发KVO",@"KVO集合属性的监听",@"多线程下的通知是否安全",@"GCD 多线程",@"使用NSOperation实现下载功能",nil];
    
    self.classNameArray = [NSMutableArray arrayWithObjects:@"FirstViewController",@"SecondViewController",@"NotificationCenterController",@"GCDViewController",@"NSOperationViewController",nil];
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELLIDENTIFIER];
    cell.textLabel.text = [self.dataSource objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *className = [self.classNameArray objectAtIndex:indexPath.row];
    UIViewController * viewcontroller = [[NSClassFromString(className) alloc] init];
    [self.navigationController pushViewController:viewcontroller animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
