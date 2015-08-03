//
//  DKActivityDetailViewController.m
//  iDook
//
//  Created by sunshilong on 15/8/1.
//  Copyright (c) 2015年 sunshilong. All rights reserved.
//

#import "DKActivityDetailViewController.h"

@interface DKActivityDetailViewController ()
{
    UIWebView *webView;
}
@end

@implementation DKActivityDetailViewController
@synthesize urlString;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"图文详情";
    
    webView = [[UIWebView alloc]  initWithFrame:CGRectMake(0, 0, kWidth, kHeight)];
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
    
    [self.view addSubview:webView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
