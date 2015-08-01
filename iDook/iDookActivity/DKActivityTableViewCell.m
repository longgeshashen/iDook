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
@synthesize lookCount;
//@synthesize forwardImgView;
@synthesize forwardCount;
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
    lookCount = 0;
    forwardCount = 0;
     self.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0];
    //背景图
    UIView *cellbgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth, 330-10)];
    NSLog(@"cell的高度是%f",self.frame.size.height);
    cellbgView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:cellbgView];
    
    //封面图
    NSArray *coverArr = [dictionary objectForKey:@"cover"];
    NSString *imageUrl = [[coverArr objectAtIndex:0] objectForKey:@"url"];
    dyImgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, kWidth-20, 200)];

    if ([imageUrl isKindOfClass:[NSString class]] && [imageUrl length] > 0) {
        [dyImgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@?imageView2/1/w/200/h/200",imageUrl]] placeholderImage:[UIImage imageNamed:@"noimage_tucao"]];
    }
    else {
        [dyImgView setImage:[UIImage imageNamed:@"noimage_tucao"]];
    }
    [cellbgView addSubview:dyImgView];
    
    //分割线
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 280, kWidth, 0.5)];
    lineView.backgroundColor = colorLineView;
    [cellbgView addSubview:lineView];
    
    for (int i=1; i<=3; i++) {
        if (i<3) {
            UIView *linView = [[UIView alloc] initWithFrame:CGRectMake(kWidth*i/3, 285, 0.5, 30)];
            linView.backgroundColor = colorLineView;
            [cellbgView addSubview:linView];
        }
        //btn
        UIButton *cellbtn = [[UIButton alloc] initWithFrame:CGRectMake(kWidth*(i-1)/3+5, 287, kWidth/3-10, 26)];
        [cellbtn addTarget:self action:@selector(tapCellButton:) forControlEvents:UIControlEventTouchUpInside];
        cellbtn.tag = 100+i;
        [cellbgView addSubview:cellbtn];
        //img,动态的小图标
        UIImageView *iconcellImg = [[UIImageView alloc] initWithFrame:CGRectMake(kWidth*(2*i-1)/6-20, 290, 20, 20)];
        iconcellImg.image = [UIImage imageNamed:[NSString stringWithFormat:@"iDook_icon_activity%d",i]];
        [cellbgView addSubview:iconcellImg];
        //label
        UILabel *cellLabel = [[UILabel alloc]initWithFrame:CGRectMake(kWidth*(2*i-1)/6, 285, kWidth/6, 30)];
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
    dyTitleTextv = [[UITextView alloc] initWithFrame:CGRectMake(10, 210, kWidth-20, 60)];
    dyTitleTextv.font = [UIFont systemFontOfSize:13];
    dyTitleTextv.text = [dictionary objectForKey:@"title"];
    if ([dyTitleTextv.text length]>45) {
        //字数超过45，省略
        NSString *textString = [[dyTitleTextv.text substringToIndex:24] stringByAppendingString:@"..."];
        dyTitleTextv.text = textString;
    }
    dyTitleTextv.scrollEnabled = NO;
    dyTitleTextv.editable = NO;
    [cellbgView addSubview:dyTitleTextv];
    
    
    //time
    UILabel *timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 254, 130, 30)];
    timeLabel.text = [NSString stringWithFormat:@"%@",[dictionary objectForKey:@"createTime"]];
    timeLabel.font = [UIFont systemFontOfSize:12];
    timeLabel.textColor = colorLightGray;
    timeLabel.textAlignment = NSTextAlignmentLeft;
    [cellbgView addSubview:timeLabel];
    
    //浏览和转发
    NSString *strEntity;
    NSDictionary *numsDic = [dictionary objectForKey:@"nums"];
    NSArray *allKeys = [numsDic allKeys];
    for (int i=0; i<[allKeys count]; i++) {
        NSObject *keysDicEntity = [allKeys objectAtIndex:i];
        if ([keysDicEntity isKindOfClass:[NSDictionary class]]) {
//            NSData* jsonDataa =[NSJSONSerialization dataWithJSONObject:keysDicEntity options:NSJSONWritingPrettyPrinted error: nil];
//            strEntity = [[NSString alloc] initWithData: jsonDataa encoding: NSUTF8StringEncoding];
        }
        else if ([keysDicEntity isKindOfClass:[NSString class]]) {
            strEntity = [NSString stringWithFormat:@"%@",keysDicEntity];
            if ([strEntity isEqualToString:@"1003"]) {
                lookCount = [numsDic objectForKey:keysDicEntity];
            }else if ([strEntity isEqualToString:@"1002"]){
                forwardCount = [numsDic objectForKey:keysDicEntity];
            }
        }
    }
   
    UIView *lookAndForwardView = [[UIView alloc] initWithFrame:CGRectMake(kWidth-155, 250, 140, 30)];
//    lookAndForwardView.backgroundColor = [UIColor purpleColor];
    [cellbgView addSubview:lookAndForwardView];
    UIView *lineV = [[UIView alloc] initWithFrame:CGRectMake(70, 15, 0.5, 10)];
    lineV.backgroundColor = colorLightGray;
    [lookAndForwardView addSubview:lineV];
    //look

    UILabel *lookLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 65, 40)];
    lookLabel.text = [NSString stringWithFormat:@"浏览%@",lookCount];
    lookLabel.font = [UIFont systemFontOfSize:12];
    lookLabel.textColor = colorLightGray;
    lookLabel.textAlignment = NSTextAlignmentRight;
    [lookAndForwardView addSubview:lookLabel];
    
    UILabel *forwardLabel = [[UILabel alloc] initWithFrame:CGRectMake(75, 0, 70, 40)];
    forwardLabel.text = [NSString stringWithFormat:@"转发%@",forwardCount];
    forwardLabel.font = [UIFont systemFontOfSize:12];
    forwardLabel.textColor = colorLightGray;
    forwardLabel.textAlignment = NSTextAlignmentLeft;
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
