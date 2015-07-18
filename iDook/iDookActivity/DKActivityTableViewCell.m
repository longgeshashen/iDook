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
    UIView *cellbgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth, 120-10)];
    NSLog(@"cell的高度是%f",self.frame.size.height);
    cellbgView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:cellbgView];
    
    //封面图
    dyImgView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, 60, 60)];
    dyImgView.image = [UIImage imageNamed:@"noimage_tucao"];
    dyImgView.layer.cornerRadius = 3;
    
    [cellbgView addSubview:dyImgView];
    
    //分割线
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 80, kWidth, 0.5)];
    lineView.backgroundColor = colorLineView;
    [cellbgView addSubview:lineView];
    
    for (int i=1; i<=4; i++) {
        if (i<4) {
            UIView *linView = [[UIView alloc] initWithFrame:CGRectMake(kWidth*i/4, 85, 0.5, 20)];
            linView.backgroundColor = colorLineView;
            [cellbgView addSubview:linView];
        }
        //btn
        UIButton *cellbtn = [[UIButton alloc] initWithFrame:CGRectMake(kWidth*(i-1)/4+5, 82, kWidth/4-10, 26)];
        [cellbtn addTarget:self action:@selector(tapCellButton:) forControlEvents:UIControlEventTouchUpInside];
        cellbtn.tag = 100+i;
        [cellbgView addSubview:cellbtn];
        //img,动态的小图标
        UIImageView *iconcellImg = [[UIImageView alloc] initWithFrame:CGRectMake(kWidth*(2*i-1)/8-20, 85, 20, 20)];
        iconcellImg.image = [UIImage imageNamed:[NSString stringWithFormat:@"icon-activity-%d",i]];
        [cellbgView addSubview:iconcellImg];
        //label
        UILabel *cellLabel = [[UILabel alloc]initWithFrame:CGRectMake(kWidth*(2*i-1)/8, 80, kWidth/8, 30)];
        cellLabel.font = [UIFont systemFontOfSize:12];
        cellLabel.textColor = [UIColor lightGrayColor];
        switch (i) {
            case 1:
            {
                cellLabel.text = @"524";
            }
                break;
            case 2:
            {
                cellLabel.text = @"42";
            }
                break;
            case 3:
            {
                cellLabel.text = @"报表";
            }
                break;
            case 4:
            {
                cellLabel.text = @"编辑";
            }
                break;
                
            default:
                break;
        }
        [cellbgView addSubview:cellLabel];
    }
    
    //title
    dyTitleTextv = [[UITextView alloc] initWithFrame:CGRectMake(80, 10, kWidth-95, 60)];
    dyTitleTextv.font = [UIFont systemFontOfSize:15];
//    dyTitleLabel.textColor = [UIColor ];
    dyTitleTextv.text = @"明天在太阳系有重要活动，希望届时所有星球前去参加，表演节目有火星撞地球";
    dyTitleTextv.scrollEnabled = NO;
    dyTitleTextv.editable = NO;
    dyTitleTextv.textAlignment = NSTextAlignmentJustified;
    [cellbgView addSubview:dyTitleTextv];
    
    
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
