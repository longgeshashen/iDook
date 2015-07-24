//
//  DKAudioRecordViewController.h
//  iDook
//
//  Created by sunshilong on 15/7/24.
//  Copyright (c) 2015年 sunshilong. All rights reserved.
//

#import "DKBaseViewController.h"
@protocol DKAudioRecordViewControllerDelegate <NSObject>

- (void)getAudio:(NSString *)audioPath andAudioTime:(CGFloat)audiotime;

@end
@interface DKAudioRecordViewController : DKBaseViewController

@property (nonatomic)id<DKAudioRecordViewControllerDelegate>delegate;
@end
