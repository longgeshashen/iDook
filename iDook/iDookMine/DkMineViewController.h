//
//  DkMineViewController.h
//  iDook
//
//  Created by sunshilong on 15/7/17.
//  Copyright (c) 2015年 sunshilong. All rights reserved.
//  我的

#import "DKBaseViewController.h"

@interface DkMineViewController : DKBaseViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,retain) UITableView *mineTableView;

@end
