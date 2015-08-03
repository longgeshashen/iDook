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
#import "DKShowlocationViewController.h"
#import "DKAudioRecordViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>

@interface DKCreateActivityViewController : DKBaseViewController<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate,DkAddImageViewDelegate,UIActionSheetDelegate,CTAssetsPickerControllerDelegate,PhotoPickerControllerDelegate,UINavigationControllerDelegate,DKShowlocationViewControllerDelegate,DKAudioRecordViewControllerDelegate>

@property (nonatomic, retain) UITableView *createTableView;//列表
@property (retain, nonatomic) AVAudioPlayer *avPlay;//play

@end
