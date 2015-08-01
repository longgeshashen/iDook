//
//  DKListDetailViewController.m
//  iDook
//
//  Created by sunshilong on 15/7/27.
//  Copyright (c) 2015年 sunshilong. All rights reserved.
//

#import "DKListDetailViewController.h"

@interface DKListDetailViewController ()
{
    User *user;
    NSMutableArray *dataArray;
    NSDictionary *dataDictionary;
    
    NSString *mobileString;
    NSString *emailString;
}
@end

@implementation DKListDetailViewController
@synthesize listDetailTableView;
@synthesize userOriginId;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"好友名片";
//    [self loadMyData];
    [self loadMyView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated{
    [self loadMyData];
}
- (void)loadMyData{
    mobileString = @"888888";
    emailString = @"8888@126.com";
    
    user = [[DKUserServerce sharedInstance] getMyself];
    //服务器获取动态列表
    NSMutableDictionary *entity =[[NSMutableDictionary alloc] init];
    [entity setObject:user.user_serverId forKey:@"uId"];
    [entity setObject:userOriginId forKey:@"fmId"];
    
    NSMutableDictionary *entDict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:entity, @"entity", nil];
    NSString * url = [APP_SERVER stringByAppendingString:HTTP_contactDetail];
    
    [CoreHttp postUrl:url params:entDict success:^(id obj) {
        //
        debugLog(@"获取的线索详情是%@",obj);
        if([obj objectForKey:@"data"]!=nil){
            
            //保存个人信息
            [self performSelectorOnMainThread:@selector(saveData:) withObject:[obj objectForKey:@"data"] waitUntilDone:YES];
        }
        
    } errorBlock:^(CoreHttpErrorType errorType) {
        //
        
    }];
}
- (void)saveData:(NSDictionary*)dictionary{
    dataDictionary = [[NSDictionary alloc] initWithDictionary:dictionary];
    [listDetailTableView reloadData];
//    [listDetailTableView reloadSections:[[NSIndexSet alloc] initWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
    debugLog(@"保存字典%@",dataDictionary);

}
- (void)loadMyView{
    listDetailTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeight) style:UITableViewStyleGrouped];
    listDetailTableView.dataSource = self;
    listDetailTableView.delegate = self;
    [self.view addSubview:listDetailTableView];
    //更多按钮
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 25, 25);
    [rightBtn addTarget:self action:@selector(getMore) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"iDook_more_btn"] forState:UIControlStateNormal];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
}
- (void)getMore{
    
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
        return 45.0;
    }else if (indexPath.section==2){
        return 100.0;
    }else{
        return 45.0;
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
    if (cell) {
        cell = nil;
    }
    //
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Cell];
    if (indexPath.section==0) {
        //
        UIImageView *portrialView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, 60, 60)];
        //            portrialView.image = [UIImage imageNamed:@"iDook_headerimg"];
        NSString *imageUrl = [[dataDictionary objectForKey:@"entity"] objectForKey:@"headimgurl"];
        if ([imageUrl isKindOfClass:[NSString class]] && [imageUrl length] > 0) {
            [portrialView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@?imageView2/1/w/200/h/200",imageUrl]] placeholderImage:[UIImage imageNamed:@"headerimg01"]];
        }
        else {
            [portrialView setImage:[UIImage imageNamed:@"headerimg01"]];
        }
        [cell.contentView addSubview:portrialView];
        //
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, 20, 80, 30)];
        nameLabel.text = [[dataDictionary objectForKey:@"entity"] objectForKey:@"name"];
        [cell.contentView addSubview:nameLabel];
        //
        UIImageView *sexImag = [[UIImageView alloc] initWithFrame:CGRectMake(140, 25, 13, 13)];
        int sexS = [[[dataDictionary objectForKey:@"entity"] objectForKey:@"sex"] intValue];
        if (sexS==1) {
            sexImag.image = [UIImage imageNamed:@"iDook_sex_male"];
        }else{
            sexImag.image = [UIImage imageNamed:@"iDook_sex_female"];
        }
        [cell.contentView addSubview:sexImag];
        //
        NSString *provinceS = [[dataDictionary objectForKey:@"entity"] objectForKey:@"province"];
        NSString *cityS = [[dataDictionary objectForKey:@"entity"] objectForKey:@"city"];
        
        UILabel *addressL = [[UILabel alloc] initWithFrame:CGRectMake(90, 50, 180, 30)];
        addressL.text = [NSString stringWithFormat:@"%@ %@",provinceS,cityS];
        addressL.font = [UIFont systemFontOfSize:12];
        addressL.textColor = colorLightGray;
        [cell.contentView addSubview:addressL];
        //
        UIImageView *editIma = [[UIImageView alloc] initWithFrame:CGRectMake(kWidth-50, 20, 30, 30)];
        editIma.image = [UIImage imageNamed:@"iDook_editBtn"];
        [cell.contentView addSubview:editIma];
    }else if (indexPath.section==1){
        //row
        UIImageView *imaVrow = [[UIImageView alloc] initWithFrame:CGRectMake(kWidth-25, 12.5, 20, 20)];
        imaVrow.image = [UIImage imageNamed:@"iDook_icon_goright"];
        [cell.contentView addSubview:imaVrow];
        //
        //
        NSDictionary *dicEntity = [dataDictionary objectForKey:@"entity"];
        NSArray *keyArr = [dicEntity allKeys];
        for (id object in keyArr) {
            if ([object isKindOfClass:[NSString class]]) {
                if ([object isEqualToString:@"mobile"]) {
                    mobileString = [dicEntity objectForKey:object];
                }else if ([object isEqualToString:@"email"]){
                    emailString = [dicEntity objectForKey:object];
                }
            }
        }
        //
        if (indexPath.row==0) {
            UILabel *phoneL = [[UILabel alloc] initWithFrame:CGRectMake(20, 7.5, 80, 30)];
            phoneL.text = @"手机号";
            [cell.contentView addSubview:phoneL];
            
            UILabel *phoneLabel = [[UILabel alloc]initWithFrame:CGRectMake(kWidth-40-120, 7.5, 120, 30)];
            phoneLabel.text = mobileString;
            phoneLabel.textColor = colorLightGray;
            phoneLabel.textAlignment = NSTextAlignmentRight;
            phoneLabel.font = [UIFont systemFontOfSize:12];
            [cell.contentView addSubview:phoneLabel];
        }else{
            UILabel *emailL = [[UILabel alloc] initWithFrame:CGRectMake(20, 7.5, 80, 30)];
            emailL.text = @"邮箱";
            [cell.contentView addSubview:emailL];
            //
            UILabel *emailLabel = [[UILabel alloc]initWithFrame:CGRectMake(kWidth-40-180, 7.5, 180, 30)];
            emailLabel.text = emailString;
            emailLabel.textAlignment = NSTextAlignmentRight;
            emailLabel.textColor = colorLightGray;
            emailLabel.font = [UIFont systemFontOfSize:12];
            [cell.contentView addSubview:emailLabel];
        }
        
        
        
    }else if (indexPath.section==3){
        //row
        UIImageView *imaVrow = [[UIImageView alloc] initWithFrame:CGRectMake(kWidth-25, 12.5, 20, 20)];
        imaVrow.image = [UIImage imageNamed:@"iDook_icon_goright"];
        [cell.contentView addSubview:imaVrow];
        
        UILabel *historyL = [[UILabel alloc] initWithFrame:CGRectMake(20, 7.5, 80, 30)];
        historyL.text = @"历史记录";
        [cell.contentView addSubview:historyL];
    }

    //
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
