//
//  DKListDetailViewController.h
//  iDook
//
//  Created by sunshilong on 15/7/27.
//  Copyright (c) 2015年 sunshilong. All rights reserved.
//

#import "DKBaseViewController.h"

@interface DKListDetailViewController : DKBaseViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,retain)UITableView *listDetailTableView;/**<好友名片*/
@property (nonatomic,retain)NSString    *userOriginId;//一个人（线索）的原始id
@end
