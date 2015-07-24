//
//  DKAudioRecordViewController.m
//  iDook
//
//  Created by sunshilong on 15/7/24.
//  Copyright (c) 2015年 sunshilong. All rights reserved.
//

#import "DKAudioRecordViewController.h"
#import "LCVoice.h"
@interface DKAudioRecordViewController ()


@property(nonatomic,retain) LCVoice * voice;

@end

@implementation DKAudioRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"语音";
    [self loadMyViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark --------
//返回
- (void)backButtonClick:(UIButton *)btn {
    if (self.delegate&&[self.delegate respondsToSelector:@selector(getAudio: andAudioTime:)]) {
        [self.delegate getAudio:self.voice.recordPath andAudioTime:self.voice.recordTime];
    }
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}
#pragma mark - 录音
- (void)loadMyViews{
    self.voice = [[LCVoice alloc] init];
    
    // Add a button
    UIButton * button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.backgroundColor = [UIColor redColor];
    button.frame = CGRectMake(15, kHeight-65, kWidth-30, 50);
    [button setTitle:@"按住录音" forState:UIControlStateNormal];
    [self.view addSubview:button];
    
    // Set record start action for UIControlEventTouchDown
    [button addTarget:self action:@selector(recordStart) forControlEvents:UIControlEventTouchDown];
    // Set record end action for UIControlEventTouchUpInside
    [button addTarget:self action:@selector(recordEnd) forControlEvents:UIControlEventTouchUpInside];
    // Set record cancel action for UIControlEventTouchUpOutside
    [button addTarget:self action:@selector(recordCancel) forControlEvents:UIControlEventTouchUpOutside];
}

#pragma mark - 录音方法
-(void) recordStart
{
    [self.voice startRecordWithPath:[NSString stringWithFormat:@"%@/Documents/Audio/MySound.caf", NSHomeDirectory()]];
    
}

-(void) recordEnd
{
    [self.voice stopRecordWithCompletionBlock:^{
        
        if (self.voice.recordTime > 0.0f) {
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:nil
                                                             message:[NSString stringWithFormat:@"\nrecord finish ! \npath:%@ \nduration:%f",self.voice.recordPath,self.voice.recordTime]
                                                            delegate:nil
                                                   cancelButtonTitle:@"ok"
                                                   otherButtonTitles:nil, nil];
            [alert show];
    
        }
        
    }];
}

-(void) recordCancel
{
    [self.voice cancelled];
    
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:nil message:@"取消了" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
    [alert show];
    
}


@end
