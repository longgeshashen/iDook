//
//  DKActivityTableViewCell.h
//  iDook
//
//  Created by sunshilong on 15/7/18.
//  Copyright (c) 2015年 sunshilong. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DKActivityTableViewCellDelegate <NSObject>

- (void)tapCellButtonIndex:(NSInteger)index;

@end

@interface DKActivityTableViewCell : UITableViewCell

@property (nonatomic)id<DKActivityTableViewCellDelegate>delegate;

@property (nonatomic,retain) UIImageView *dyImgView;       /**<封面图片*/
@property (nonatomic,retain) UITextView     *dyTitleTextv;    /**<标题*/
//@property (nonatomic,retain) UIImageView *lookImgView;     /**<浏览图标*/
//@property (nonatomic,retain) UILabel     *lookCount;       /**<浏览次数*/
//@property (nonatomic,retain) UIImageView *forwardImgView;  /**<转发图标*/
//@property (nonatomic,retain) UILabel     *forwardCount;    /**<转发次数*/
//@property (nonatomic,retain) UIButton    *reportBtn;       /**<报表按钮*/
//@property (nonatomic,retain) UIButton    *editBtn;         /**<编辑按钮*/
//@property (nonatomic,retain) UIButton    *lookBtn;         /**<浏览按钮*/
//@property (nonatomic,retain) UIButton    *forwardBtn;      /**<转发按钮*/

- (void)loadActivitytableViewCellWith:(NSDictionary*)dictionary; /**<初始化cell*/

@end
