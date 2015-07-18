//
//  DKAddressListViewController.h
//  iDook
//
//  Created by sunshilong on 15/7/17.
//  Copyright (c) 2015年 sunshilong. All rights reserved.
//  通讯录

#import "DKBaseViewController.h"

@interface DKAddressListViewController : DKBaseViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,retain) UITableView *addresstableView;/**<通讯录列表*/


@end
