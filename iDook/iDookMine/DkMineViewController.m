//
//  DkMineViewController.m
//  iDook
//
//  Created by sunshilong on 15/7/17.
//  Copyright (c) 2015年 sunshilong. All rights reserved.
//

#import "DkMineViewController.h"
#import "DKLoginViewController.h"
@interface DkMineViewController ()

@end

@implementation DkMineViewController

- (void)viewDidLoad {
    self.isBoot = YES;
    [super viewDidLoad];
    NSLog(@"我的页面");
    self.title = @"我的";
    
    UIButton *loginBtn = [[UIButton alloc] initWithFrame:CGRectMake(30, 260, kWidth-60, 40)];
    loginBtn.backgroundColor= [UIColor grayColor];
    [loginBtn addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)login:(UIButton*)sender{
    DKLoginViewController *loginV = [[DKLoginViewController alloc] init];
    loginV.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:loginV animated:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
