//
//  DKUserServerce.h
//  iDook
//
//  Created by sunshilong on 15/7/31.
//  Copyright (c) 2015年 sunshilong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
@interface DKUserServerce : NSObject

+ (id)sharedInstance;
- (User*)getMyself;
@end
