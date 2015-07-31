//
//  UITabBarItem+Universal.m
//  KYSAPP
//
//  Created by admin on 14-7-23.
//  Copyright (c) 2014年 emotte. All rights reserved.
//

#import "UITabBarItem+Universal.h"

@implementation UITabBarItem (Universal)
+ (instancetype)itemWithTitle:(NSString *)title image:(UIImage *)image selectedImage:(UIImage *)selectedImage
{
    UITabBarItem *tabBarItem = nil;
    if ([[[UIDevice currentDevice] systemVersion]floatValue]>=7.0) {
        tabBarItem = [[UITabBarItem alloc] initWithTitle:title image:image selectedImage:selectedImage];
        [tabBarItem setFinishedSelectedImage:selectedImage withFinishedUnselectedImage:image];
    } else {
        tabBarItem = [[UITabBarItem alloc] initWithTitle:title image:nil tag:0];
        [tabBarItem setFinishedSelectedImage:selectedImage withFinishedUnselectedImage:image];
    }
    return tabBarItem;
}

@end
