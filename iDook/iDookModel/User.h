//
//  User.h
//  iDook
//
//  Created by sunshilong on 15/7/28.
//  Copyright (c) 2015年 sunshilong. All rights reserved.
//  本人信息

#import "BaseModel.h"

@interface User : BaseModel

@property (nonatomic,copy) NSString *user_name;      /**<用户名  */
@property (nonatomic,copy) NSString *user_headimgurl;/**<头像地址 */
@property (nonatomic,copy) NSString *user_nickname;  /**<昵称 */
@property (nonatomic,copy) NSString *user_sex;       /**<性别 */

@property (nonatomic,copy) NSString *user_mobile;    /**<手机号 */
@property (nonatomic,copy) NSString *user_email;     /**<邮箱 */
@property (nonatomic,copy) NSString *user_openid;    /**<openid */
@property (nonatomic,copy) NSString *user_unionid;   /**<unionid */


///**<级别 */
//@property (nonatomic,assign) NSUInteger level;
//
///**<账户余额 */
//@property (nonatomic,assign) CGFloat accountMoney;
//
///**<是否是vip：产品狗新加 */
//@property (nonatomic,assign) BOOL isVip;

@end
