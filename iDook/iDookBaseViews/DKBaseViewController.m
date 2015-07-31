//
//  DKBaseViewController.m
//  iDook
//
//  Created by sunshilong on 15/7/17.
//  Copyright (c) 2015年 sunshilong. All rights reserved.
//

#import "DKBaseViewController.h"

@interface DKBaseViewController ()

@end

@implementation DKBaseViewController
@synthesize isBoot;
@synthesize pageName;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadViews];
}
- (void)loadViews{
    //navColor
    if ([[[UIDevice currentDevice]systemVersion]floatValue]<7.0) {
        self.navigationController.navigationBar.tintColor = colorNavbg;
    }
    else{
        [self.navigationController.navigationBar setBarTintColor:colorNavbg];
    }
    //backBtn
    if (!isBoot) {
        UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *btnImage=[UIImage imageNamed:@"iDook_back_btn"];
        [backBtn setImage:btnImage forState:UIControlStateNormal];
        [backBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        backBtn.frame = CGRectMake(0, 0, 22.5, 22.5);
        [backBtn  addTarget:self action:@selector(backButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        UIBarButtonItem *backBarBtn = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
        self.navigationItem.leftBarButtonItem = backBarBtn;
    }
    //titilColor
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark － 返回上层菜单
- (void)backButtonClick:(UIButton *)btn {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
