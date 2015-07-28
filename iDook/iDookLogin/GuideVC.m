//
//  GuideVC.m
//  SHBAPP
//
//  Created by admin on 13-9-11.
//  Copyright (c) 2013年 dongwei xin. All rights reserved.
//

#import "GuideVC.h"
#import "Tools.h"
@interface GuideVC ()

@end
@implementation GuideVC
@synthesize pageControl;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor clearColor];
    UIScrollView * scrollView = [[UIScrollView alloc] init];
    [scrollView setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [scrollView setContentSize:CGSizeMake(self.view.frame.size.width * 4, self.view.frame.size.height)];
    [scrollView setShowsHorizontalScrollIndicator:NO];
    //引导页面图片图片
    NSArray *imageNameArray=[NSArray arrayWithObjects:@"APP01",@"APP02",@"APP03",@"APP04", nil];
    for (int i=0;i<imageNameArray.count;i++) {
        UIImageView  *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width*i,0, self.view.frame.size.width,self.view.frame.size.height)];
        UIImage *image= [UIImage imageNamed:[imageNameArray objectAtIndex:i]];
        UIImage *scale_image=image;
        [imageView setImage:scale_image];
        if (i==3) {
            UIImage *imagebtn=[UIImage imageNamed:@"newopen_btn"];
            UIImage *scale_imagebtn=imagebtn;
            UIButton *button=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, scale_imagebtn.size.width,scale_imagebtn.size.height)];
            [imageView setUserInteractionEnabled:YES];
            [button setCenter:CGPointMake([UIScreen mainScreen].bounds.size.width/2, [UIScreen mainScreen].bounds.size.height*0.8)];
            [button addTarget:self action:@selector(gotoMainPage) forControlEvents:UIControlEventTouchUpInside];
            [button setImage:scale_imagebtn forState:UIControlStateNormal];
            [button setAlpha:1.0f];
            [imageView addSubview:button];
        }
        [scrollView addSubview:imageView];
    }
    [scrollView setAlwaysBounceHorizontal:YES];
    scrollView.pagingEnabled=YES;
    scrollView.delegate=self;
    [self.view addSubview:scrollView];
    
    self.pageControl = [[UIPageControl alloc] init];
    [self.pageControl setFrame:CGRectMake(0, 0, 160,20)];
    [self.pageControl setCurrentPageIndicatorTintColor:colorNavbg];
    [self.pageControl setPageIndicatorTintColor:[UIColor lightGrayColor]];
    [self.pageControl setBackgroundColor:[UIColor clearColor]];
    [self.pageControl setHidesForSinglePage:YES];
    [self.pageControl setNumberOfPages:4];
    [self.pageControl setCenter:CGPointMake([UIScreen mainScreen].bounds.size.width/2, [UIScreen mainScreen].bounds.size.height*0.92)];
    [self.pageControl setEnabled:NO];
    [self.view addSubview:self.pageControl];
    
}

#pragma mark ---转向主页面---
-(void)gotoMainPage
{
    AppDelegate *appdelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];

    NSUserDefaults *userDefault=[NSUserDefaults standardUserDefaults];
    [userDefault setObject:myAPPVersion forKey:@"appversion"];
    [userDefault synchronize];
    [appdelegate gotoMainPage];
}
#pragma mark ----UIScrollViewDelegate--
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat pageWidth = self.view.frame.size.width;
    int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    pageControl.currentPage = page;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
