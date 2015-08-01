//
//  DKUserServerce.m
//  iDook
//
//  Created by sunshilong on 15/7/31.
//  Copyright (c) 2015年 sunshilong. All rights reserved.
//

#import "DKUserServerce.h"
#import "User.h"
@implementation DKUserServerce
+ (id)sharedInstance
{
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (User*)getMyself{
    NSArray *userArr = [User selectWhere:@"user_relationship=0" groupBy:nil orderBy:nil limit:nil];
    User *user = [userArr objectAtIndex:0];
//    NSLog(@"人信息是＊＊＊＊\n%@",user);
    return user;
}

@end
