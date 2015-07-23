//
//  DKBaseViewController.h
//  iDook
//
//  Created by sunshilong on 15/7/17.
//  Copyright (c) 2015年 sunshilong. All rights reserved.
//  根视图

#import <UIKit/UIKit.h>

@interface DKBaseViewController : UIViewController

@property (nonatomic, assign) BOOL isBoot;//是否是根视图，不是加返回按钮
@property (nonatomic, retain) NSString *pageName;//页面title

- (void)loadViews; //加载基本试图
- (void)backButtonClick:(UIButton *)btn;//返回按钮

@end
