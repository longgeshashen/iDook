//
//  UITabBarItem+Universal.h
//  KYSAPP
//
//  Created by admin on 14-7-23.
//  Copyright (c) 2014年 emotte. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITabBarItem (Universal)
+ (instancetype)itemWithTitle:(NSString *)title image:(UIImage *)image selectedImage:(UIImage *)selectedImage;
@end
