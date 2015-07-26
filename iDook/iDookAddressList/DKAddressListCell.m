//
//  DKAddressListCell.m
//  iDook
//
//  Created by long on 15-7-26.
//  Copyright (c) 2015年 sunshilong. All rights reserved.
//

#import "DKAddressListCell.h"

@implementation DKAddressListCell
@synthesize portrialImagView,sexImagView;
@synthesize nameLab,relationCountLab,recentListLab;

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
- (void)loadAddressListCellWithDictionary:(NSDictionary *)dictionary{
    //potrial
    portrialImagView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, 60, 60)];
    portrialImagView.image = [UIImage imageNamed:@"iDook_headerimg"];
    portrialImagView.layer.cornerRadius = 4;
    portrialImagView.layer.borderWidth = 1;
    portrialImagView.layer.borderColor = [[UIColor redColor] CGColor];
    [self addSubview:portrialImagView];
    //name
    nameLab = [[UILabel alloc] initWithFrame:CGRectMake(90, 10, 80, 30)];
    nameLab.text = @"王宝强啊";
//    nameLab.textAlignment = NSTextAlignmentRight;
    [self addSubview:nameLab];
    //sex
    sexImagView = [[UIImageView alloc] initWithFrame:CGRectMake(175, 10, 20, 20)];
    sexImagView.image = [UIImage imageNamed:@""];
    [self addSubview:sexImagView];
    //recentList
    recentListLab = [[UILabel alloc] initWithFrame:CGRectMake(90, 40, 150, 30)];
    recentListLab.font = [UIFont systemFontOfSize:11];
    recentListLab.text = @"马云最近评论了你得动态";
    recentListLab.textColor = [UIColor grayColor];
    [self addSubview:recentListLab];
    //relationCount
    relationCountLab = [[UILabel alloc] initWithFrame:CGRectMake(kWidth-70, 25, 50, 30)];
    relationCountLab.textAlignment = NSTextAlignmentCenter;
    relationCountLab.layer.cornerRadius = 5;
    relationCountLab.layer.borderWidth = 1;
    relationCountLab.layer.borderColor = [[UIColor blueColor] CGColor];
    relationCountLab.text = @"5度";
    [self addSubview:relationCountLab];
    
}

@end
