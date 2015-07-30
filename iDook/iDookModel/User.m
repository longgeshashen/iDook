//
//  User.m
//  iDook
//
//  Created by sunshilong on 15/7/28.
//  Copyright (c) 2015年 sunshilong. All rights reserved.
//

#import "User.h"

@implementation User

/** 描述 */
-(NSString *)description{
//    return [NSString stringWithFormat:@"userName=%@,level=%@,accountMoney=%@,isVip=%@",self.userName,@(self.level),@(self.accountMoney),@(self.isVip)];
    return [NSString stringWithFormat:@"user_name=%@,user_headimgurl=%@,user_nickname=%@,user_sex=%@,user_mobile=%@,user_email=%@,user_openid=%@,user_unionid=%@",self.user_name,self.user_headimgurl,self.user_nickname,self.user_sex,self.user_mobile,self.user_email,self.user_openid,self.user_unionid];
}

@end
