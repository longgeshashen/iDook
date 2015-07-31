//
//  DkMineViewController.m
//  iDook
//
//  Created by sunshilong on 15/7/17.
//  Copyright (c) 2015年 sunshilong. All rights reserved.
//

#import "DkMineViewController.h"
#import "DKMineInfoViewController.h"
#import "User.h"
#import "UIImageView+WebCache.h"
#import "DKUserServerce.h"

@interface DkMineViewController ()
{
    User *user;
}
@end

@implementation DkMineViewController

@synthesize mineTableView;

- (void)viewDidLoad {
    self.isBoot = YES;
    [super viewDidLoad];
    NSLog(@"我的页面");
    self.title = @"我的";
    [self loadMyView];
    user = [[DKUserServerce sharedInstance] getMyself];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - 加载视图
- (void)loadMyView{
    mineTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeight) style:UITableViewStyleGrouped];
    mineTableView.dataSource = self;
    mineTableView.delegate = self;
    if ([mineTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [mineTableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([mineTableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [mineTableView setLayoutMargins:UIEdgeInsetsZero];
    }
    
    [self.view addSubview:mineTableView];
    
}
#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 1;
    }else if (section==1){
        return 4;
    }else{
        return 1;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        return 83;
    }
    return 45;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return 0.5;
    }
    return 5.0;
    
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *Cell = @"mineTableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Cell];
    if (cell==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Cell];
        if(indexPath.section==0){
            //头像
            UIImageView *portrialImagView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 63, 63)];
            if ([user.user_headimgurl isKindOfClass:[NSString class]] && [user.user_headimgurl length] > 0) {
                [portrialImagView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@?imageView2/1/w/200/h/200",user.user_headimgurl]] placeholderImage:[UIImage imageNamed:@"headerimg01"]];
            }
            else {
                [portrialImagView setImage:[UIImage imageNamed:@"headerimg01"]];
            }
            portrialImagView.image = [UIImage imageNamed:@"noimage_tucao"];
            [cell.contentView addSubview:portrialImagView];
            //名字
            UILabel *nameL = [[UILabel alloc] initWithFrame:CGRectMake(90, 13, 180, 40)];
            nameL.text = @"个人账户";
            [cell.contentView addSubview:nameL];
            //是否在线
            UILabel *isOnlineL = [[UILabel alloc] initWithFrame:CGRectMake(90, 45, 120, 30)];
            isOnlineL.font = [UIFont systemFontOfSize:12.0];
            isOnlineL.textColor = colorLightGray;
            if ([[NSUserDefaults standardUserDefaults] objectForKey:@"isLogin"]) {
                isOnlineL.text = @"在线";
            }else{
                isOnlineL.text = @"未登录";
            }
            
            [cell.contentView addSubview:isOnlineL];
            //row
            UIImageView *imaVrow = [[UIImageView alloc] initWithFrame:CGRectMake(kWidth-25, 31, 20, 20)];
            imaVrow.image = [UIImage imageNamed:@"iDook_icon_goright"];
            [cell.contentView addSubview:imaVrow];
        
        }else if (indexPath.section==1){
            //
            UIImageView *imaV = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 25, 25)];
            imaV.image = [UIImage imageNamed:[NSString stringWithFormat:@"iDook_my_0%d",indexPath.row+1]];
            [cell.contentView addSubview:imaV];
            //
            UILabel *praiseL = [[UILabel alloc] initWithFrame:CGRectMake(38, 7, 120, 30)];
            [cell.contentView addSubview:praiseL];
            //row
            UIImageView *imaVrow = [[UIImageView alloc] initWithFrame:CGRectMake(kWidth-25, 12, 20, 20)];
            imaVrow.image = [UIImage imageNamed:@"iDook_icon_goright"];
            [cell.contentView addSubview:imaVrow];
            switch (indexPath.row) {
                    
                case 0:
                {
                    praiseL.text = @"我的点赞";
                }
                    break;
                case 1:
                {
                    praiseL.text = @"我的回复";
                }
                    break;
                case 2:
                {
                    praiseL.text = @"我的转发";
                }
                    break;
                case 3:
                {
                    praiseL.text = @"我的报告";
                }
                    break;
                    
                default:
                    break;
            }
            
        }else if (indexPath.section==2){
            //
            UIImageView *imaV = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 25, 25)];
            imaV.image = [UIImage imageNamed:@"iDook_my_05"];
            [cell.contentView addSubview:imaV];
            //
            UILabel *praiseL = [[UILabel alloc] initWithFrame:CGRectMake(38, 7, 120, 30)];
            praiseL.text = @"设置";
            [cell.contentView addSubview:praiseL];
            //row
            UIImageView *imaVrow = [[UIImageView alloc] initWithFrame:CGRectMake(kWidth-25, 12, 20, 20)];
            imaVrow.image = [UIImage imageNamed:@"iDook_icon_goright"];
            [cell.contentView addSubview:imaVrow];
        }
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    debugLog(@"我的选择%d",indexPath.row);
    if (indexPath.section==0) {
        DKMineInfoViewController *mineInfo = [[DKMineInfoViewController alloc] init];
        mineInfo.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:mineInfo animated:YES];
    }
    
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
