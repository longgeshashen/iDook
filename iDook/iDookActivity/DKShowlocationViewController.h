//
//  DKShowlocationViewController.h
//  iDook
//
//  Created by sunshilong on 15/7/24.
//  Copyright (c) 2015年 sunshilong. All rights reserved.
//

#import "DKBaseViewController.h"
#import <BaiduMapAPI/BMapKit.h>
@protocol DKShowlocationViewControllerDelegate<NSObject>
- (void)getMylocation:(NSString *)myLocation;
@end

@interface DKShowlocationViewController : DKBaseViewController<BMKMapViewDelegate,BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate>

@property (nonatomic)id<DKShowlocationViewControllerDelegate>delegate;
@end
