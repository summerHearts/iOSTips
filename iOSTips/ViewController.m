//
//  ViewController.m
//  iOSTips
//
//  Created by Kenvin on 17/1/9.
//  Copyright © 2017年 上海方创金融信息服务股份有限公司. All rights reserved.
//

#import "ViewController.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "NotificationCenterController.h"
#import "GCDViewController.h"
static NSString *const CELLIDENTIFIER = @"CELLIDENTIFIER";
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong,nonatomic) NSMutableArray *dataSource;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"iOSTips";
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CELLIDENTIFIER];
    [self.tableView setDataSource:self];
    [self.tableView setDelegate:self];

    self.dataSource = [NSMutableArray arrayWithObjects:@"手动触发KVO",@"KVO集合属性的监听",@"多线程下的通知是否安全",@"GCD 多线程",nil];
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
    switch (indexPath.row) {
        case 0:{
            FirstViewController *firstViewController = [[FirstViewController alloc]init];
            [self.navigationController pushViewController:firstViewController animated:YES];
        }
            break;
        case 1:{
            SecondViewController *secondViewController = [[SecondViewController alloc]init];
            [self.navigationController pushViewController:secondViewController animated:YES];
        }
            break;
        case 2:{
            NotificationCenterController *notificationCenterController = [[NotificationCenterController alloc]init];
            notificationCenterController.urlString = @"http://southpeak.github.io/2015/03/14/nsnotification-and-multithreading/";
            [self.navigationController pushViewController:notificationCenterController animated:YES];
        }
            break;
        case 3:{
            GCDViewController *gcdViewController = [[GCDViewController alloc]init];
            [self.navigationController pushViewController:gcdViewController animated:YES];
        }
            break;
        default:
            break;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
