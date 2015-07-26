//
//  DKAddressListCell.h
//  iDook
//
//  Created by long on 15-7-26.
//  Copyright (c) 2015年 sunshilong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DKAddressListCell : UITableViewCell
@property (nonatomic,retain) UIImageView *portrialImagView;//头像
@property (nonatomic,retain) UIImageView *sexImagView;     //性别
@property (nonatomic,retain) UILabel *nameLab;             //名字
@property (nonatomic,retain) UILabel *recentListLab;       //最近联系
@property (nonatomic,retain) UILabel *relationCountLab;    //关系维度

- (void)loadAddressListCellWithDictionary:(NSDictionary*)dictionary;
@end
