//
//  DKAddressListViewController.m
//  iDook
//
//  Created by sunshilong on 15/7/17.
//  Copyright (c) 2015年 sunshilong. All rights reserved.
//

#import "DKAddressListViewController.h"
#import "DKAddressListCell.h"
#import "DKListDetailViewController.h"

@interface DKAddressListViewController ()

@end

@implementation DKAddressListViewController
@synthesize addresstableView;

- (void)viewDidLoad {
    self.isBoot = YES;
    [super viewDidLoad];
    NSLog(@"线索页面");
    self.title = @"线索";
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
    
    addresstableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeight) style:UITableViewStylePlain];
    addresstableView.delegate = self;
    addresstableView.dataSource = self;
    if ([addresstableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [addresstableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([addresstableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [addresstableView setLayoutMargins:UIEdgeInsetsZero];
    }

    [self.view addSubview:addresstableView];
    
    //搜索按钮
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 25, 25);
    [rightBtn addTarget:self action:@selector(searchList) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"iDook_search_btn"] forState:UIControlStateNormal];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
    
}
#pragma mark - 进入搜索页面
- (void)searchList{
    debugLog(@"搜素线索");

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
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 5.0;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *Cell = @"addresscell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Cell];
    if (cell==nil) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Cell];
        DKAddressListCell *dkcell = [[[NSBundle mainBundle] loadNibNamed:@"DKAddressListCell" owner:self options:nil] lastObject];
        [dkcell loadAddressListCellWithDictionary:nil];
        cell = dkcell;
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    debugLog(@"选中一个联系人查看详情");
    // 选择一个人，查看详情
    DKListDetailViewController *listDetail = [[DKListDetailViewController alloc] init];
    listDetail.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:listDetail animated:YES];
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
