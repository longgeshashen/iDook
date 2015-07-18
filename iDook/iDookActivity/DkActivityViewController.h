//
//  DkActivityViewController.h
//  iDook
//
//  Created by sunshilong on 15/7/17.
//  Copyright (c) 2015年 sunshilong. All rights reserved.
//  动态

#import "DKBaseViewController.h"
#import "DKActivityTableViewCell.h"

@interface DkActivityViewController : DKBaseViewController<UITableViewDataSource,UITableViewDelegate,DKActivityTableViewCellDelegate>

@property (nonatomic,retain) UITableView *dkActTableView;/**<动态列表*/

@end
