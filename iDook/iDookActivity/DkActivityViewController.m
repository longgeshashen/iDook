//
//  DkActivityViewController.m
//  iDook
//
//  Created by sunshilong on 15/7/17.
//  Copyright (c) 2015年 sunshilong. All rights reserved.
//

#import "DkActivityViewController.h"
#import "DKActivityTableViewCell.h"
#import "DKCreateActivityViewController.h"

@interface DkActivityViewController ()

@end

@implementation DkActivityViewController
@synthesize dkActTableView;
- (void)viewDidLoad {
    self.isBoot = YES;
    [super viewDidLoad];
    self.title = @"图文";
    [self loadMydata];
    [self loadMyView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)loadMydata{
    //服务器获取数据
    
}
- (void)loadMyView{
    //列表
    dkActTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeight) style:UITableViewStylePlain];
    dkActTableView.delegate = self;
    dkActTableView.dataSource = self;
   
    if ([dkActTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [dkActTableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([dkActTableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [dkActTableView setLayoutMargins:UIEdgeInsetsZero];
    }
    [self.view addSubview:dkActTableView];
    
    //新建按钮
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 25, 25);
    [rightBtn addTarget:self action:@selector(addNewActivity) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"iDook_publish_btn"] forState:UIControlStateNormal];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
}

#pragma mark - UITableviewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0.5;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 150;
}
#pragma mark--新建按钮
//- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    //
//    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth, 50)];
//    bgView.backgroundColor = [UIColor colorWithRed:236/255.0 green:236/255.0 blue:236/255.0 alpha:1.0];
//    UIButton *addActivityBtn = [[UIButton alloc] initWithFrame:CGRectMake(0 , 0, kWidth, 40)];
//    [addActivityBtn setTitle:@"＋发布新动态" forState:UIControlStateNormal];
//    [addActivityBtn setTitleColor:[UIColor colorWithRed:85/255.0 green:103/255.0 blue:121/255.0 alpha:1.0] forState:UIControlStateNormal];
//    addActivityBtn.backgroundColor = [UIColor whiteColor];
//    [addActivityBtn addTarget:self action:@selector(addNewActivity) forControlEvents:UIControlEventTouchUpInside];
//    [bgView addSubview:addActivityBtn];
//    return bgView;
//}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *aCell = @"activityCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:aCell];
    if (cell==nil) {
        //自定义cell
        DKActivityTableViewCell *dkcell = [[[NSBundle mainBundle] loadNibNamed:@"DKActivityTableViewCell" owner:self options:nil] lastObject];
        [dkcell loadActivitytableViewCellWith:nil];
        dkcell.delegate = self;
//        CGRect frame = dkcell.frame;
//        frame.size.width = kWidth;
//        dkcell.frame = frame;
        
        cell = dkcell;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    debugLog(@"选中某一行，查看动态详情，加载url数据");
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
#pragma mark - 新建activity
- (void)addNewActivity{
    debugLog(@"新建动态");
    DKCreateActivityViewController *create = [[DKCreateActivityViewController alloc] init];
    create.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:create animated:YES];
}
#pragma mark - DKActivityTableViewCellDelegate
- (void)tapCellButtonIndex:(NSInteger)index{
    if (index==101) {
        debugLog(@"去报表");
    }else if (index==102){
        debugLog(@"去编辑");
    }else if (index==103){
        debugLog(@"去转发");
    }
}

@end
