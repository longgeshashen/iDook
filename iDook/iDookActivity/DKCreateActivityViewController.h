//
//  DKCreateActivityViewController.h
//  iDook
//
//  Created by sunshilong on 15/7/21.
//  Copyright (c) 2015年 sunshilong. All rights reserved.
//

#import "DKBaseViewController.h"
#import "DkAddImageView.h"
#import "CTAssetsPickerController.h"
#import "PhotoPickerController.h"

@interface DKCreateActivityViewController : DKBaseViewController<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate,DkAddImageViewDelegate,UIActionSheetDelegate,CTAssetsPickerControllerDelegate,PhotoPickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic,retain) UITableView *createTableView;//列表

@end
