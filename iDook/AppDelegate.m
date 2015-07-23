//
//  AppDelegate.m
//  iDook
//
//  Created by sunshilong on 15/7/17.
//  Copyright (c) 2015年 sunshilong. All rights reserved.
//

#import "AppDelegate.h"
#import "DKBaseNavigationViewController.h"
#import "UITabBarItem+Universal.h"
#import "Tools.h"
@interface AppDelegate ()

@end

@implementation AppDelegate
@synthesize DKTabBarController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    //初始化控制器
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    DKTabBarController = [[UITabBarController alloc] init];
    

    NSArray *tabImage = @[@"btnav-act",@"btnav-mclass",@"btnav-my"];
    NSArray *tabImage_select = @[@"btnav-act2",@"btnav-mclass2",@"btnav-my2"];//这里可以不加选中变色的图片
    NSArray *viewControllerArray=@[@"DkActivityViewController",@"DKAddressListViewController",@"DkMineViewController"];
    NSArray *tabTitle=@[@"图文",@"线索",@"我的"];
    NSMutableArray *recordViewControllers=[[NSMutableArray alloc]initWithCapacity:0];
    for (unsigned i=0; i<[viewControllerArray count]; i++) {
        NSString *viewControllersString=[viewControllerArray objectAtIndex:i];
        NSString *title=[tabTitle objectAtIndex:i];
        UIImage *scale_image=[UIImage imageNamed:[tabImage objectAtIndex:i]];
        UIImage *scale_selectimage=[UIImage imageNamed:[tabImage_select objectAtIndex:i]];
        UIViewController *viewControllerClass=[[NSClassFromString(viewControllersString) alloc]initWithNibName:nil bundle:nil];
        DKBaseNavigationViewController *_navigationController=[[DKBaseNavigationViewController alloc]initWithRootViewController:viewControllerClass];
        UITabBarItem *tabBarItem=[UITabBarItem itemWithTitle:title image:scale_image selectedImage:scale_selectimage];
        [_navigationController setTabBarItem:tabBarItem];
        [recordViewControllers addObject:_navigationController];
    }
    //tabbar选中颜色和title颜色
    if ([[[UIDevice currentDevice]systemVersion]floatValue]<7.0) {
        
        [[UITabBar appearance] setBackgroundImage:[Tools createImageWithColor:[UIColor colorWithRed:1.000 green:1.000 blue:1.000 alpha:1]]];
        
        [[UITabBar appearance] setSelectionIndicatorImage:[UIImage new]];
        [[UITabBarItem appearance] setTitleTextAttributes:
         @{ UITextAttributeTextShadowOffset: [NSValue valueWithUIOffset:UIOffsetMake(0, 0)],
            UITextAttributeTextColor: [UIColor colorWithRed:22/255.0 green:170/255.0 blue:254/255.0 alpha:1.0] }
                                                 forState:UIControlStateSelected];
        
    }else{
        [[UITabBarItem appearance] setTitleTextAttributes:
         @{ UITextAttributeTextShadowOffset: [NSValue valueWithUIOffset:UIOffsetMake(0, 0)],
            UITextAttributeTextColor: colorTabBar,UITextAttributeFont:[UIFont systemFontOfSize:13 weight:1.0]} forState:UIControlStateSelected];
        [[UITabBarItem appearance] setTitleTextAttributes:
         @{ UITextAttributeTextShadowOffset: [NSValue valueWithUIOffset:UIOffsetMake(0, 0)],
            UITextAttributeTextColor: [UIColor darkGrayColor],UITextAttributeFont:[UIFont systemFontOfSize:13 weight:1.0]} forState:UIControlStateNormal];

    }
    
    [DKTabBarController.tabBar setSelectedImageTintColor:colorTabBar];
    [DKTabBarController setViewControllers:recordViewControllers animated:YES];
    [DKTabBarController setSelectedIndex:0];
    [DKTabBarController setDelegate:self];
    
    [self reloadTabBar];
    
    //欢迎页
//    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"appversion"]floatValue]<[myAPPVersion floatValue])  {
//        GuideVC *guideVC=[[GuideVC alloc] init];
//        self.window.rootViewController = guideVC;
//    }
//    else{
        self.window.rootViewController = DKTabBarController;
//    }
    [self.window makeKeyAndVisible];
    
    
    return YES;
}
#pragma mark -  自定义TabBar方法
- (void)reloadTabBar{
    NSLog(@"刷新TabBar,更新消息数量");
}
#pragma mark - 控制器默认方法
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
