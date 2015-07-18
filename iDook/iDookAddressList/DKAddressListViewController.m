//
//  DKAddressListViewController.m
//  iDook
//
//  Created by sunshilong on 15/7/17.
//  Copyright (c) 2015年 sunshilong. All rights reserved.
//

#import "DKAddressListViewController.h"

@interface DKAddressListViewController ()

@end

@implementation DKAddressListViewController
@synthesize addresstableView;

- (void)viewDidLoad {
    self.isBoot = YES;
    [super viewDidLoad];
    NSLog(@"通讯录页面");
    self.title = @"通讯录";
    [self loadMydata];
    [self loadMyView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - 自定义方法初始化数据
- (void)loadMydata{
    
}
- (void)loadMyView{
//    self.view.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0];
    addresstableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 50, kWidth, kHeight) style:UITableViewStylePlain];
    addresstableView.delegate = self;
    addresstableView.dataSource = self;
    if ([addresstableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [addresstableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([addresstableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [addresstableView setLayoutMargins:UIEdgeInsetsZero];
    }

    [self.view addSubview:addresstableView];
}


#pragma mark - UiTableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 8;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *Cell = @"addresscell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Cell];
    if (cell==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Cell];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    debugLog(@"选中一个联系人查看详情");
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}
@end
