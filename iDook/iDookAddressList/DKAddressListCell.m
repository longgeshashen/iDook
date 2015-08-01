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
    NSString *imageUrl = [[dictionary objectForKey:@"entity"] objectForKey:@"headimgurl"];
    portrialImagView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, 60, 60)];

    if ([imageUrl isKindOfClass:[NSString class]] && [imageUrl length] > 0) {
        [portrialImagView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@?imageView2/1/w/200/h/200",imageUrl]] placeholderImage:[UIImage imageNamed:@"headerimg01"]];
    }
    else {
        [portrialImagView setImage:[UIImage imageNamed:@"headerimg01"]];
    }
    
    portrialImagView.layer.cornerRadius = 4;
    portrialImagView.layer.borderWidth = 0.2;
    portrialImagView.layer.borderColor = [colorLightGray CGColor];
    [self addSubview:portrialImagView];
    //name
    NSString *nameS = [[dictionary objectForKey:@"entity"] objectForKey:@"name"];
    nameLab = [[UILabel alloc] initWithFrame:CGRectMake(90, 10, 80, 30)];
    nameLab.text = nameS;
//    nameLab.textAlignment = NSTextAlignmentRight;
    [self addSubview:nameLab];
    //sex
    int sexS = [[[dictionary objectForKey:@"entity"] objectForKey:@"sex"] intValue];
    sexImagView = [[UIImageView alloc] initWithFrame:CGRectMake(140, 20, 13, 13)];
    if (sexS==1) {
        sexImagView.image = [UIImage imageNamed:@"iDook_sex_male"];
    }else{
        sexImagView.image = [UIImage imageNamed:@"iDook_sex_female"];
    }
    [self addSubview:sexImagView];
    //recentList
    NSString *doWhatString;
    int uq = [[[dictionary objectForKey:@"dynamic"] objectForKey:@"uq"] intValue];
    int doWhat = [[[dictionary objectForKey:@"dynamic"] objectForKey:@"md"] intValue];
    if(uq==1){
        if (doWhat==1000) {
            doWhatString = @"赞了我的动态";
        }else if (doWhat==1001){
            doWhatString = @"评论了我的动态";
        }else if (doWhat==1002){
            doWhatString = @"分享了我的动态";
        }else{
            doWhatString = @"浏览了我的动态";
        }
    }else{
        if (doWhat==1000) {
            doWhatString = @"赞了他的动态";
        }else if (doWhat==1001){
            doWhatString = @"评论了他的动态";
        }else if (doWhat==1002){
            doWhatString = @"分享了他的动态";
        }else{
            doWhatString = @"浏览了他的动态";
        }
    }
    
    
    recentListLab = [[UILabel alloc] initWithFrame:CGRectMake(90, 40, 150, 30)];
    recentListLab.font = [UIFont systemFontOfSize:11];
    recentListLab.text = doWhatString;
    recentListLab.textColor = [UIColor grayColor];
    [self addSubview:recentListLab];
    //relationCount
    NSString *distance = [[dictionary objectForKey:@"relation"] objectForKey:@"distance"];
    relationCountLab = [[UILabel alloc] initWithFrame:CGRectMake(kWidth-70, 25, 50, 30)];
    relationCountLab.textAlignment = NSTextAlignmentCenter;
    relationCountLab.layer.cornerRadius = 5;
    relationCountLab.layer.borderWidth = 1;
    relationCountLab.layer.borderColor = [[UIColor blueColor] CGColor];
    relationCountLab.text = [NSString stringWithFormat:@"%@度",distance];
    [self addSubview:relationCountLab];
    
}

@end
