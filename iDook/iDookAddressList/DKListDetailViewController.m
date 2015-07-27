//
//  DKListDetailViewController.m
//  iDook
//
//  Created by sunshilong on 15/7/27.
//  Copyright (c) 2015年 sunshilong. All rights reserved.
//

#import "DKListDetailViewController.h"

@interface DKListDetailViewController ()

@end

@implementation DKListDetailViewController
@synthesize listDetailTableView;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"好友名片";
    [self loadMyView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadMyView{
    listDetailTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeight) style:UITableViewStyleGrouped];
    listDetailTableView.dataSource = self;
    listDetailTableView.delegate = self;
    [self.view addSubview:listDetailTableView];
}
#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 1;
    }else if (section==1){
        return 2;
    }else if (section==2){
        return 1;
    }else{
        return 1;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        return 100.0;
    }else if (indexPath.section==1){
        return 60.0;
    }else if (indexPath.section==2){
        return 100.0;
    }else{
        return 60.0;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return 0.5;
    }else if (section==1){
        return 10;
    }else if (section==2){
        return 40;
    }else{
        return 10;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section==3) {
        return 100.0;
    }
    else{
        return 0.5;
    }
}
- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section==3) {
        UIView *viewF = [[UIView alloc] initWithFrame:CGRectMake(0, 10, kWidth, 100.0)];
        viewF.backgroundColor = [UIColor clearColor];
        UIButton *addToAddressBtn = [[UIButton alloc] initWithFrame:CGRectMake(15, 15, kWidth-30, 60)];
        [addToAddressBtn setTitle:@"添加到通讯录" forState:UIControlStateNormal];
        addToAddressBtn.backgroundColor = [UIColor colorWithRed:57/255.0 green:170/255.0 blue:254/255.0 alpha:1.0];
        addToAddressBtn.layer.cornerRadius = 4.0;
        addToAddressBtn.layer.borderWidth = 0.5;
        addToAddressBtn.layer.borderColor = [[UIColor colorWithRed:57/255.0 green:170/255.0 blue:254/255.0 alpha:1.0] CGColor];
        [addToAddressBtn addTarget:self action:@selector(addToAddressBook:) forControlEvents:UIControlEventTouchUpInside];
        [viewF addSubview:addToAddressBtn];
        return viewF;
    }else{
        return nil;
    }
    
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSString *titileS = @"我们的关系";
    if (section==2) {
        return titileS;
    }else{
        return nil;
    }
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *Cell = @"AddressListDetail";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Cell];
    if (cell==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Cell];
        if (indexPath.section==0) {
            //
            UIImageView *portrialView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, 60, 60)];
            portrialView.image = [UIImage imageNamed:@"iDook_headerimg"];
            [cell.contentView addSubview:portrialView];
            //
            UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, 20, 80, 30)];
            nameLabel.text = @"王宝强";
            [cell.contentView addSubview:nameLabel];
            //
            UIImageView *sexImag = [[UIImageView alloc] initWithFrame:CGRectMake(170, 20, 20, 20)];
            sexImag.image = [UIImage imageNamed:@"iDook_sex_man"];
            [cell.contentView addSubview:sexImag];
            //
            UILabel *addressL = [[UILabel alloc] initWithFrame:CGRectMake(90, 50, 180, 30)];
            addressL.text = @"北京市，朝内大街10号";
            addressL.font = [UIFont systemFontOfSize:12];
            addressL.textColor = colorLightGray;
            [cell.contentView addSubview:addressL];
            //
            UIImageView *editIma = [[UIImageView alloc] initWithFrame:CGRectMake(kWidth-50, 20, 30, 30)];
            editIma.image = [UIImage imageNamed:@"iDook_editBtn"];
            [cell.contentView addSubview:editIma];
        }else if (indexPath.section==1){
            if (indexPath.row==0) {
                UILabel *phoneL = [[UILabel alloc] initWithFrame:CGRectMake(20, 15, 80, 30)];
                phoneL.text = @"手机号";
                [cell.contentView addSubview:phoneL];
                //
                UILabel *phoneLabel = [[UILabel alloc]initWithFrame:CGRectMake(kWidth-40-120, 15, 120, 30)];
                phoneLabel.text = @"18602335689";
                phoneLabel.textColor = colorLightGray;
                phoneLabel.textAlignment = NSTextAlignmentRight;
                phoneLabel.font = [UIFont systemFontOfSize:12];
                [cell.contentView addSubview:phoneLabel];
            }else{
                UILabel *emailL = [[UILabel alloc] initWithFrame:CGRectMake(20, 15, 80, 30)];
                emailL.text = @"邮箱";
                [cell.contentView addSubview:emailL];
                //
                UILabel *emailLabel = [[UILabel alloc]initWithFrame:CGRectMake(kWidth-40-180, 15, 180, 30)];
                emailLabel.text = @"18602457896@126.com";
                emailLabel.textAlignment = NSTextAlignmentRight;
                emailLabel.textColor = colorLightGray;
                emailLabel.font = [UIFont systemFontOfSize:12];
                [cell.contentView addSubview:emailLabel];
            }
            
            
            //
            
        }else if (indexPath.section==3){
            UILabel *historyL = [[UILabel alloc] initWithFrame:CGRectMake(20, 15, 80, 30)];
            historyL.text = @"历史记录";
            [cell.contentView addSubview:historyL];
        }
        
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    debugLog(@"选择cell");
}
#pragma mark - 添加到手机通讯录
- (void)addToAddressBook:(UIButton*)sender{
    debugLog(@"添加到手机通讯录");
}
@end
