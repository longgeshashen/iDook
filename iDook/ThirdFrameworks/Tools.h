//
//  Tools.h
//  SuperClassRepresentative
//
//  Created by User on 15/4/13.
//  Copyright (c) 2015年 wangbo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import <CoreLocation/CoreLocation.h>
#import <CoreLocation/CLLocationManagerDelegate.h>
#import "AppDelegate.h"

@interface Tools : NSObject {
    
}

#pragma mark 颜色创建图片
+ (UIImage *)createImageWithColor:(UIColor *)color;

#pragma mark 根据文字，文本字体，文字大小，文字宽度计算文字占视图大小
+ (CGSize)getTextSizeByText:(NSString *)text andFontName:(NSString *)fontName andFontSize:(float)fontSize andWidth:(float)width;

#pragma mark 判断是不是emoji表情字符
+ (BOOL)stringContainsEmoji:(NSString *)strings;

#pragma mark 验证手机号码
+(BOOL)isValidateMobileNumber:(NSString *)number;

#pragma mark 验证email
+ (BOOL)validateEmail:(NSString *)email;

#pragma mark- 获取时间的时间戳
+(CGFloat)getTimeStampBy:(NSDate *)date;

#pragma mark- 根据时间戳获取日期
+(NSString *)getDayByTimeInteger:(NSString *)timeInteger;

#pragma mark- 获取当前时间的日期
+(NSString *)getDayByToday;

#pragma mark- 获取时间 几分钟内,几小时内,7个天内,年月日
+(NSString *)getNowTimeByTimeStr:(NSString *)timeStr;

#pragma mark- 获取与当前时间的时间差
+(CGFloat)getTimeStampByNowTime:(NSDate *)date;
+(CGFloat)getTimeStampByNowTimeStamp:(NSInteger)timeStamp;

#pragma mark 取得唯一的用户标示
+(NSString *)getUniqueKey;

#pragma mark- 压缩图片,最小边为length,如果最小比例的边为length
+ (UIImage *)scaleImage:(UIImage *)_images length:(float)length;

#pragma mark- 使用系统方法缩图片
+(UIImage *)scaleImage:(UIImage *)_images multiple:(CGFloat)_multiple;

#pragma mark 获取dataDict文件数据字典的数据
+ (NSDictionary *)getDataDict;

#pragma mark 获取addressDict文件数据字典的数据
+ (NSDictionary *)getAddressDict;

#pragma mark 获取filePath文件数据字典的数据
+ (NSDictionary *)getDictByFilePath:(NSString *)filePath;

#pragma mark -使用MD5
+ (NSString *)getMd5:(NSString *)inPutText;


#pragma mark --文件和路径管理--
//获取程序的Home目录路径
+(NSString *)GetHomeDirectoryPath;
//获取document目录路径
+(NSString *)GetDocumentPath;
//返回Documents下的指定文件路径(加创建)
+(NSString *)GetDirectoryForDocuments:(NSString *)dir;
//获取Cache目录路径
+(NSString *)GetCachePath;
//获取Library目录路径
+(NSString *)GetLibraryPath;
//获取Tmp目录路径
+(NSString *)GetTmpPath;
//创建目录文件夹
+(NSString *)CreateList:(NSString *)List ListName:(NSString *)Name;
//写入NsArray文件
+(BOOL)WriteFileArray:(NSArray *)ArrarObject SpecifiedFile:(NSString *)path;
//写入NSDictionary文件
+(BOOL)WriteFileDictionary:(NSMutableDictionary *)DictionaryObject SpecifiedFile:(NSString *)path;
//是否存在该文件
+(BOOL)IsFileExists:(NSString *)filepath;
//是否存在目录，没有就创建
+(BOOL)IsFilePathExists:(NSString *)filepath;
//如果不存在，创建文件
+(BOOL)buildFileBy:(NSString *)filepath;
//删除指定文件
+(BOOL)DeleteFile:(NSString*)filepath;
//删除 document/dir 目录下 所有文件
+(void)deleteAllForDocumentsDir:(NSString*)dir;
//获取目录列表里所有的文件名
+(NSArray *)GetSubpathsAtPath:(NSString *)path;

//直接取文件数据
+(NSData*)GetDataForResource:(NSString*)name inDir:(NSString*) dir;
+(NSData*)GetDataForDocuments:(NSString *)name inDir:(NSString*)dir;
+(NSData*)GetDataForPath:(NSString*)path;

//获取文件路径
+(NSString*)GetPathForCaches:(NSString *)filename;
+(NSString*)GetPathForCaches:(NSString *)filename inDir:(NSString*)dir;

+(NSString*)GetPathForDocuments:(NSString*)filename;
+(NSString*)GetPathForDocuments:(NSString *)filename inDir:(NSString*)dir;

+(NSString*)GetPathForResource:(NSString *)name;
+(NSString*)GetPathForResource:(NSString *)name inDir:(NSString*)dir;
#pragma mark --------


@end
