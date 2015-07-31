//
//  DKMineInfoViewController.h
//  iDook
//
//  Created by sunshilong on 15/7/31.
//  Copyright (c) 2015年 sunshilong. All rights reserved.
//

#import "DKBaseViewController.h"
#import "CTAssetsPickerController.h"
#import "PhotoPickerController.h"

@interface DKMineInfoViewController : DKBaseViewController<UITableViewDataSource,UITableViewDelegate,CTAssetsPickerControllerDelegate,PhotoPickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate>

@property (nonatomic,retain) UITableView *mineInfoTableView;

@end
