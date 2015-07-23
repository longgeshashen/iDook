//
//  DKActivityTableViewCell.m
//  iDook
//
//  Created by sunshilong on 15/7/18.
//  Copyright (c) 2015年 sunshilong. All rights reserved.
//

#import "DKActivityTableViewCell.h"

@implementation DKActivityTableViewCell
@synthesize dyImgView;
@synthesize dyTitleTextv;
//@synthesize lookImgView;
//@synthesize lookCount;
//@synthesize forwardImgView;
//@synthesize forwardCount;
//@synthesize reportBtn;
//@synthesize editBtn;
//@synthesize lookBtn;
//@synthesize forwardBtn;
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}
#pragma mark - initCell
- (void)loadActivitytableViewCellWith:(NSDictionary*)dictionary{
     self.backgroundColor = [UIColor colorWithRed:236/255.0 green:236/255.0 blue:236/255.0 alpha:1.0];
    //背景图
    UIView *cellbgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth, 150-10)];
    NSLog(@"cell的高度是%f",self.frame.size.height);
    cellbgView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:cellbgView];
    
    //封面图
    dyImgView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, 80, 80)];
    dyImgView.image = [UIImage imageNamed:@"noimage_tucao"];
    dyImgView.layer.cornerRadius = 3;
    
    [cellbgView addSubview:dyImgView];
    
    //分割线
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 100, kWidth, 0.5)];
    lineView.backgroundColor = colorLineView;
    [cellbgView addSubview:lineView];
    
    for (int i=1; i<=3; i++) {
        if (i<3) {
            UIView *linView = [[UIView alloc] initWithFrame:CGRectMake(kWidth*i/3, 105, 0.5, 30)];
            linView.backgroundColor = colorLineView;
            [cellbgView addSubview:linView];
        }
        //btn
        UIButton *cellbtn = [[UIButton alloc] initWithFrame:CGRectMake(kWidth*(i-1)/3+5, 107, kWidth/3-10, 26)];
        [cellbtn addTarget:self action:@selector(tapCellButton:) forControlEvents:UIControlEventTouchUpInside];
        cellbtn.tag = 100+i;
        [cellbgView addSubview:cellbtn];
        //img,动态的小图标
        UIImageView *iconcellImg = [[UIImageView alloc] initWithFrame:CGRectMake(kWidth*(2*i-1)/6-20, 110, 20, 20)];
        iconcellImg.image = [UIImage imageNamed:[NSString stringWithFormat:@"icon-activity-%d",i]];
        [cellbgView addSubview:iconcellImg];
        //label
        UILabel *cellLabel = [[UILabel alloc]initWithFrame:CGRectMake(kWidth*(2*i-1)/6, 105, kWidth/6, 30)];
        cellLabel.font = [UIFont systemFontOfSize:12];
        cellLabel.textColor = [UIColor lightGrayColor];
        switch (i) {
            case 1:
            {
                cellLabel.text = @"报表";
            }
                break;
            case 2:
            {
                cellLabel.text = @"编辑";
            }
                break;
            case 3:
            {
                cellLabel.text = @"转发";
            }
                break;
                
            default:
                break;
        }
        [cellbgView addSubview:cellLabel];
    }
    
    //标题描述
    dyTitleTextv = [[UITextView alloc] initWithFrame:CGRectMake(100, 8, kWidth-105, 60)];
    dyTitleTextv.font = [UIFont systemFontOfSize:15];
    dyTitleTextv.text = @"明天在太阳系有重要活动，希望届时所有星球前去参加好不好";
    if ([dyTitleTextv.text length]>24) {
        //字数超过24，省略
        NSString *textString = [[dyTitleTextv.text substringToIndex:24] stringByAppendingString:@"..."];
        dyTitleTextv.text = textString;
    }
    dyTitleTextv.scrollEnabled = NO;
    dyTitleTextv.editable = NO;
    [cellbgView addSubview:dyTitleTextv];
    
    
    //time
    UILabel *timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(110, 50, 80, 40)];
    timeLabel.text = @"2小时前";
    timeLabel.font = [UIFont systemFontOfSize:15];
    timeLabel.textColor = colorLightGray;
    timeLabel.textAlignment = NSTextAlignmentLeft;
    [cellbgView addSubview:timeLabel];
    
    //浏览和转发
    UIView *lookAndForwardView = [[UIView alloc] initWithFrame:CGRectMake(kWidth-155, 50, 140, 40)];
//    lookAndForwardView.backgroundColor = [UIColor purpleColor];
    [cellbgView addSubview:lookAndForwardView];
    UIView *lineV = [[UIView alloc] initWithFrame:CGRectMake(70, 13, 0.5, 14)];
    lineV.backgroundColor = colorLightGray;
    [lookAndForwardView addSubview:lineV];
    //look
    NSString *lookCounStr = @"524";
    UILabel *lookLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 70, 40)];
    lookLabel.text = [NSString stringWithFormat:@"浏览%@",lookCounStr];
    lookLabel.font = [UIFont systemFontOfSize:14];
    lookLabel.textColor = colorLightGray;
    lookLabel.textAlignment = NSTextAlignmentLeft;
    [lookAndForwardView addSubview:lookLabel];
    
    NSString *forwardCounStr = @"124";
    UILabel *forwardLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 0, 70, 40)];
    forwardLabel.text = [NSString stringWithFormat:@"转发%@",forwardCounStr];
    forwardLabel.font = [UIFont systemFontOfSize:14];
    forwardLabel.textColor = colorLightGray;
    forwardLabel.textAlignment = NSTextAlignmentRight;
    [lookAndForwardView addSubview:forwardLabel];
    
    
}

#pragma mark - tapCellBtn
- (void)tapCellButton:(UIButton *)sender
{
    NSLog(@"点击cell%ld",(long)sender.tag);
    if (self.delegate&&[self.delegate respondsToSelector:@selector(tapCellButtonIndex:)]) {
        [self.delegate tapCellButtonIndex:sender.tag];
    }

}

@end
