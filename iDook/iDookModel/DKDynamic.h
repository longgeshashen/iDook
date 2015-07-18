//
//  DKDynamic.h
//  iDook
//
//  Created by sunshilong on 15/7/17.
//  Copyright (c) 2015年 sunshilong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DKDynamic : NSObject

@property (nonatomic, copy) NSString *dynamicHostId;//服务器id
@property (nonatomic, copy) NSString *dynamicTitle; //标题
@property (nonatomic, copy) NSString *dynamicImage; //封面图片地址
@property (nonatomic, copy) NSString *dynamicDesc;  //简介
@property (nonatomic, copy) NSString *dynamicURL;   //加载的网址url

@property (nonatomic,assign) int      praiseCount;  //点赞数量
@property (nonatomic,assign) int      lookCount;    //浏览数量
@property (nonatomic,assign) int      forwardCount; //转发数量
@property (nonatomic,assign) int      isPraise;     //是否点赞，1赞，0未赞

@end
