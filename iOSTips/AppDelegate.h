//
//  AppDelegate.h
//  iOSTips
//
//  Created by Kenvin on 17/1/9.
//  Copyright © 2017年 上海方创金融信息服务股份有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

