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
@synthesize dyTitleLabel;
@synthesize lookImgView;
@synthesize lookCount;
@synthesize forwardImgView;
@synthesize forwardCount;
@synthesize reportBtn;
@synthesize editBtn;

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}
#pragma mark - initCell
- (void)loadActivitytableViewCellWith:(NSDictionary*)dictionary{
    //封面图
    dyImgView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, 80, 80)];
    dyImgView.image = [UIImage imageNamed:@"noimage_tucao"];
    dyImgView.layer.cornerRadius = 1.5;
    [self addSubview:dyImgView];
    
    //标题
    
    
}
@end
