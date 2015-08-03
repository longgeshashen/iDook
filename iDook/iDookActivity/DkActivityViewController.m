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
#import "DKActivityDetailViewController.h"

@interface DkActivityViewController ()
{
    User *user;
    NSInteger pageNumber;//当前页数
    
}
@end

@implementation DkActivityViewController
@synthesize dkActTableView;
@synthesize dataArray;

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
    
    user = [[DKUserServerce sharedInstance] getMyself];
    //服务器获取动态列表
    NSMutableDictionary *entity =[[NSMutableDictionary alloc] init];
    [entity setObject:user.user_serverId forKey:@"uId"];
    [entity setObject:[NSString stringWithFormat:@"%d",pageNumber] forKey:@"start"];
    [entity setObject:[NSString stringWithFormat:@"5"] forKey:@"limit"];
    
    
    NSMutableDictionary *entDict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:entity, @"entity", nil];
    NSString * url = [APP_SERVER stringByAppendingString:HTTP_getDynamicList];
    
    [CoreHttp postUrl:url params:entDict success:^(id obj) {
        //
        debugLog(@"获取的动态列表是%@",obj);
        if([obj objectForKey:@"data"]!=nil){
            
            //保存个人信息
            [self performSelectorOnMainThread:@selector(saveDynamicList:) withObject:[obj objectForKey:@"data"] waitUntilDone:YES];
        }
        
    } errorBlock:^(CoreHttpErrorType errorType) {
        //
        
    }];
    
}
#pragma mark - 保存动态列表
- (void)saveDynamicList:(NSDictionary*)dictionary{
    dataArray = [[NSMutableArray alloc] initWithArray:[dictionary objectForKey:@"list"]];
    [dkActTableView reloadData];
//    debugLog(@"保存shuzu 字典%@",dataArray);
}
- (void)loadMyView{
    //列表
    dkActTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeight) style:UITableViewStyleGrouped];
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
    return [dataArray count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0.5;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 330;
}
#pragma mark--新建按钮

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *listDic;
    if ([dataArray count]!=0) {
        listDic = [dataArray objectAtIndex:indexPath.row];
    }
    
    static NSString *aCell = @"activityCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:aCell];
    if (cell==nil) {
        //自定义cell
        DKActivityTableViewCell *dkcell = [[[NSBundle mainBundle] loadNibNamed:@"DKActivityTableViewCell" owner:self options:nil] lastObject];
        [dkcell loadActivitytableViewCellWith:listDic];
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
    
    DKActivityDetailViewController *activityDetailV = [[DKActivityDetailViewController alloc] init];
    activityDetailV.hidesBottomBarWhenPushed = YES;
    activityDetailV.urlString = [[dataArray objectAtIndex:indexPath.row] objectForKey:@"url"];
    
    [self.navigationController pushViewController:activityDetailV animated:YES];
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
