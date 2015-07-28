//
//  DKLoginViewController.m
//  iDook
//
//  Created by sunshilong on 15/7/27.
//  Copyright (c) 2015年 sunshilong. All rights reserved.
//

#import "DKLoginViewController.h"

@interface DKLoginViewController ()

@end

@implementation DKLoginViewController
@synthesize viewController;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self loadMyView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadMyView{
    UIImage *bgImage = [UIImage imageNamed:@"iDook_login_bg"];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:bgImage]];
    //
    UIButton *loginBtn = [[UIButton alloc] initWithFrame:CGRectMake(30, 330, kWidth-60, 60)];
    loginBtn.backgroundColor= [UIColor clearColor];
    [loginBtn addTarget:self action:@selector(sendAuthRequest) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
}

#pragma mark - 微信登录，拉取授权

- (void)sendAuthRequest{
    SendAuthReq* req = [[SendAuthReq alloc] init];
    req.scope = @"snsapi_message,snsapi_userinfo,snsapi_friend,snsapi_contact"; // @"post_timeline,sns"
    req.state = @"iDookLogin";
    req.openID = WXAppkey;
    
    [WXApi sendAuthReq:req viewController:viewController delegate:nil];
}


@end
