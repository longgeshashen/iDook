//
//  AppDelegate.h
//  iDook
//
//  Created by sunshilong on 15/7/17.
//  Copyright (c) 2015年 sunshilong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WXApi.h"
#import "DKLoginViewController.h"


@interface AppDelegate : UIResponder <UIApplicationDelegate,UITabBarControllerDelegate,WXApiDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UITabBarController *DKTabBarController;//主tabbar控制器



#pragma mark ----刷新tabbar----
- (void)reloadTabBar;

@end

