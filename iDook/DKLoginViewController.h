//
//  DKLoginViewController.h
//  iDook
//
//  Created by sunshilong on 15/7/27.
//  Copyright (c) 2015年 sunshilong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WXApi.h"
#import "DkActivityViewController.h"


@interface DKLoginViewController : UIViewController<WXApiDelegate>
@property (nonatomic,retain)DkActivityViewController *viewController;

@end
