//
//  DkAddImageView.m
//  iDook
//
//  Created by sunshilong on 15/7/21.
//  Copyright (c) 2015年 sunshilong. All rights reserved.
//

#import "DkAddImageView.h"

@implementation DkAddImageView

@synthesize addButton;

@synthesize imageArray;
@synthesize titleArray;
- (void)loadscrollViewWithImages:(NSArray *)imageArr andTitles:(NSArray *)titleArr{
    //测试
//    NSArray *imgArr = [[NSArray alloc]initWithObjects:@"createImage.jpg",@"createImage.jpg",@"createImage.jpg", nil];
    
    imageArray = [[NSArray alloc] initWithArray:imageArr];
    NSUInteger pageCount=[imageArray count];
    if (pageCount==0) {
        addButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 15, 70, 70)];
        [addButton setBackgroundImage:[UIImage imageNamed:@"iDook_addImage_btn"] forState:UIControlStateNormal];
        [addButton addTarget:self action:@selector(addPictures:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:addButton];
    }else {
        CGRect scrollRect;
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        scrollView.pagingEnabled = YES;
        scrollView.contentSize = CGSizeMake(80 * pageCount, scrollRect.size.height);
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.scrollsToTop = NO;
        scrollView.delegate = self;
        //
        if((kWidth - pageCount*75-30)>70){
            scrollRect = CGRectMake(0, 15, pageCount*75, 70);
            scrollView.scrollEnabled = NO;
        }else{
            scrollRect = CGRectMake(0, 15, (kWidth-80-30), 70);
            scrollView.scrollEnabled = YES;
        }
        scrollView.frame = scrollRect;
        //加载缩略图
        for (int i=0; i<pageCount; i++) {
//            NSString *imgURL=[imageArray objectAtIndex:i];
            UIImageView *imgView=[[UIImageView alloc] init];
//            if ([imgURL hasPrefix:@"http://"]) {
//                //网络图片 请使用ego异步图片库
//                //[imgView setImageWithURL:[NSURL URLWithString:imgURL]];
//            }
//            else{
//                UIImage *img=[UIImage imageNamed:[imageArray objectAtIndex:i]];
//                [imgView setImage:img];
//            }
            
            imgView.image = [imageArray objectAtIndex:i];
            
            [imgView setFrame:CGRectMake(75*i, 0,70, scrollRect.size.height)];
            imgView.tag=i;
            //
            UITapGestureRecognizer *Tap =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imagePressed:)];
            [Tap setNumberOfTapsRequired:1];
            [Tap setNumberOfTouchesRequired:1];
            imgView.userInteractionEnabled=YES;
            [imgView addGestureRecognizer:Tap];
            [scrollView addSubview:imgView];
        }
        [scrollView setContentOffset:CGPointMake(0, 0)];
        [self addSubview:scrollView];
        //
        addButton = [[UIButton alloc] initWithFrame:CGRectMake(scrollRect.size.width+5, 15, 70, 70)];
        [addButton setBackgroundImage:[UIImage imageNamed:@"iDook_addImage_btn"] forState:UIControlStateNormal];
        [addButton addTarget:self action:@selector(addPictures:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:addButton];
        
    }
}
- (void)addPictures:(UIButton*)sender{
    debugLog(@"回调相机");
    if (self.deleget&&[self.deleget respondsToSelector:@selector(startGetImage)]) {
        [self.deleget startGetImage];
    }
}
- (void)imagePressed:(UITapGestureRecognizer *)sender
{
    debugLog(@"点击图片,第几张");
    if(self.deleget&&[self.deleget respondsToSelector:@selector(showBigImage:)]){
        [self.deleget showBigImage:sender.view.tag];
    }
}
@end
