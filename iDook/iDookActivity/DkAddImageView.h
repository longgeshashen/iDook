//
//  DkAddImageView.h
//  iDook
//
//  Created by sunshilong on 15/7/21.
//  Copyright (c) 2015年 sunshilong. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol DkAddImageViewDelegate <NSObject>

- (void)startGetImage;//点击开始拍照
- (void)showBigImage:(NSInteger)index;//查看大图

@end

@interface DkAddImageView : UIView<UIScrollViewDelegate>

@property (nonatomic)id<DkAddImageViewDelegate>deleget;
@property (nonatomic,retain) UIButton *addButton;
@property (nonatomic,retain) NSArray *imageArray;
@property (nonatomic,retain) NSArray *titleArray;

- (void)loadscrollViewWithImages:(NSArray *)imageArr andTitles:(NSArray *)titleArr;

@end
