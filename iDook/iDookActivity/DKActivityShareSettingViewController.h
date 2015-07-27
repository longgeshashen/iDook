//
//  DKActivityShareSettingViewController.h
//  iDook
//
//  Created by sunshilong on 15/7/27.
//  Copyright (c) 2015年 sunshilong. All rights reserved.
//

#import "DKBaseViewController.h"
#import "CTAssetsPickerController.h"
#import "PhotoPickerController.h"
@interface DKActivityShareSettingViewController : DKBaseViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UITextViewDelegate,UIActionSheetDelegate,CTAssetsPickerControllerDelegate,PhotoPickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic,retain)UITableView *shareSettingTableView;

@end
