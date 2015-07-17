//
//  Tools.m
//  SuperClassRepresentative
//
//  Created by User on 15/4/13.
//  Copyright (c) 2015年 wangbo. All rights reserved.
//

#import "Tools.h"
#import "SSKeychain.h"
#import "CommonCrypto/CommonDigest.h"

#define kSSToolkituuidServiceName @"SuperClassRepresentative"
#define kSSToolkituuidaccount @"uuid"


@implementation Tools


#pragma mark- 颜色创建图片
#pragma mark ------
+ (UIImage*)createImageWithColor:(UIColor *)color {
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

#pragma mark 根据文字，文本字体，文字大小，文字宽度计算文字占视图大小
+ (CGSize)getTextSizeByText:(NSString *)text andFontName:(NSString *)fontName andFontSize:(float)fontSize andWidth:(float)width {
    CGSize textSize = [text sizeWithFont:[UIFont fontWithName:fontName size:fontSize]
                       constrainedToSize:CGSizeMake(width, CGFLOAT_MAX)
                           lineBreakMode:NSLineBreakByClipping];
    return textSize;
}

#pragma mark 判断是不是emoji表情字符
+ (BOOL)stringContainsEmoji:(NSString *)string {
    __block BOOL returnValue = NO;
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:
     ^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
         const unichar hs = [substring characterAtIndex:0];
         // surrogate pair
         if (0xd800 <= hs && hs <= 0xdbff) {
             if (substring.length > 1) {
                 const unichar ls = [substring characterAtIndex:1];
                 const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                 if (0x1d000 <= uc && uc <= 0x1f77f) {
                     returnValue = YES;
                 }
             }
         } else if (substring.length > 1) {
             const unichar ls = [substring characterAtIndex:1];
             if (ls == 0x20e3) {
                 returnValue = YES;
             }
             
         } else {
             // non surrogate
             if (0x2100 <= hs && hs <= 0x27ff) {
                 returnValue = YES;
             } else if (0x2B05 <= hs && hs <= 0x2b07) {
                 returnValue = YES;
             } else if (0x2934 <= hs && hs <= 0x2935) {
                 returnValue = YES;
             } else if (0x3297 <= hs && hs <= 0x3299) {
                 returnValue = YES;
             } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                 returnValue = YES;
             }
         }}];
    return returnValue;
}

#pragma mark 验证手机号码
+(BOOL)isValidateMobileNumber:(NSString *)number
{
    NSString * MOBILE = @"^1[34578]\\d{9}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    
    if ([regextestmobile evaluateWithObject:number] == YES)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

#pragma mark 验证email
+ (BOOL)validateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

#pragma mark - 获取时间的时间戳
+(CGFloat)getTimeStampBy:(NSDate *)date
{
    NSTimeInterval time = [date timeIntervalSince1970];
    NSLog(@"%f",time);
    return time;
}

#pragma mark- 根据时间戳获取日期
+(NSString *)getDayByTimeInteger:(NSString *)timeInteger {
    NSTimeInterval timeInt = [timeInteger doubleValue];
    NSTimeInterval secTimeInt = timeInt/1000;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:secTimeInt];
    NSTimeZone *timeZonr = [NSTimeZone defaultTimeZone];
    NSDateFormatter *formatter =  [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    [formatter setTimeZone:timeZonr];
    NSString *timeString = [formatter stringFromDate:date];
    [formatter release];
    return timeString;
}

#pragma mark- 获取当前时间的日期
+(NSString *)getDayByToday {
    NSDate *date =[NSDate date];
    NSTimeZone *timeZonr = [NSTimeZone defaultTimeZone];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    [formatter setTimeZone:timeZonr];
    NSString *timeString = [formatter stringFromDate:date];
    [formatter release];
    return timeString;
}

#pragma mark- 获取时间 几分钟内,几小时内,7个天内,年月日
+(NSString *)getNowTimeByTimeStr:(NSString *)timeStr {
    NSTimeInterval timeInt = [timeStr doubleValue];
    NSTimeInterval secTimeInt = timeInt/1000;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:secTimeInt];
    int timeCha = 0-[self getTimeStampByNowTime:date];
    
    NSTimeZone *timeZonr = [NSTimeZone defaultTimeZone];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    [formatter setTimeZone:timeZonr];

    if (timeCha < -60) {
        return [formatter stringFromDate:date];
    }
    else if (timeCha < 60) {
        return @"刚刚";
    }
    else if (timeCha < 3600) {
        return [NSString stringWithFormat:@"%d分钟前",timeCha/60];
    }
    else if (timeCha < 86400) {
        return [NSString stringWithFormat:@"%d小时前",timeCha/3600];
    }
    else if (timeCha < 604800) {
        return [NSString stringWithFormat:@"%d天前",timeCha/86400];
    }
    else {
        return [formatter stringFromDate:date];
    }
    
}

#pragma mark- 获取与当前时间的时间差
+(CGFloat)getTimeStampByNowTime:(NSDate *)date;
{
    NSTimeInterval time = [date timeIntervalSinceNow];
    NSLog(@"%f",time);
    return time;
}

+(CGFloat)getTimeStampByNowTimeStamp:(NSInteger)timeStamp {
    return [self getTimeStampByNowTime:[NSDate dateWithTimeIntervalSince1970:timeStamp]];
}

#pragma mark 设备的uuid
+(NSString*) uuid {
    CFUUIDRef puuid = CFUUIDCreate( nil );
    CFStringRef uuidString = CFUUIDCreateString( nil, puuid );
    NSString * result = (NSString *)CFStringCreateCopy( NULL, uuidString);
    CFRelease(puuid);
    CFRelease(uuidString);
    return [result autorelease];
}

#pragma mark 取得唯一的用户标示
+(NSString *)getUniqueKey
{
    NSError *error = nil;
    [SSKeychain passwordForService:kSSToolkituuidServiceName account:kSSToolkituuidaccount error:&error];
    if ([error code] == SSKeychainErrorNotFound) {
        NSString *uuid=[self uuid];
        [SSKeychain setPassword: [NSString stringWithFormat:@"%@", uuid]
                     forService:kSSToolkituuidServiceName account:kSSToolkituuidaccount];
    }
    NSString *retrieveuuid = [[SSKeychain passwordForService:kSSToolkituuidServiceName account:kSSToolkituuidaccount] stringByReplacingOccurrencesOfString:@"-" withString:@""];
    return retrieveuuid;
}

#pragma mark- 压缩图片,最小边为length,如果最小比例的边为length
+ (UIImage *)scaleImage:(UIImage *)_images length:(float)length{
    UIImage *res_image = nil;
    
//    float scWidth = [UIScreen mainScreen].bounds.size.width * 2;
//    float scHeight = [UIScreen mainScreen].bounds.size.height;
//    float scBili = scWidth/scHeight;
    
    float imgWidth = _images.size.width;
    float imgHeight = _images.size.height;
    float imgBili = imgWidth/imgHeight;
    
    float imagebili;
    
    if (imgBili > 1) {
        if (imgHeight < length) {
            return _images;
        }
        else {
            imagebili = length/imgHeight;
        }
    }
    else {
        if (imgWidth < length) {
            return _images;
        }
        else {
            imagebili = length/imgWidth;
        }
    }
    
    if (_images) {
//        res_image = [UIImage imageWithCGImage:_images.CGImage scale:imagebili orientation:UIImageOrientationUp];
        UIGraphicsBeginImageContext(CGSizeMake(imgWidth*imagebili, imgHeight*imagebili));
        [_images drawInRect:CGRectMake(0, 0, imgWidth*imagebili, imgHeight*imagebili)];
        UIImage *newimage=UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return newimage;

    }
    return res_image;
}

#pragma mark- 使用系统方法缩图片
+(UIImage *)scaleImage:(UIImage *)_images multiple:(CGFloat)_multiple
{
    UIImage *res_image = nil;
    if (_images) {
        res_image = [UIImage imageWithCGImage:_images.CGImage scale:_multiple orientation:UIImageOrientationUp];
    }
    return res_image;
}

#pragma mark 获取dataDict文件数据字典的数据
+ (NSDictionary *)getDataDict {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"dataDict" ofType:@"plist"];
    NSDictionary *dataDict = [[NSDictionary alloc] initWithContentsOfFile:filePath];
    return dataDict;
}

#pragma mark 获取addressDict文件数据字典的数据
+ (NSDictionary *)getAddressDict {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"addressDict" ofType:@"plist"];
    NSDictionary *dataDict = [[NSDictionary alloc] initWithContentsOfFile:filePath];
    return dataDict;
}

#pragma mark 获取filePath文件数据字典的数据
+ (NSDictionary *)getDictByFilePath:(NSString *)filePath {
    NSDictionary *dataDict = [[NSDictionary alloc] initWithContentsOfFile:filePath];
    return dataDict;
}

#pragma mark -使用MD5
+ (NSString *)getMd5:(NSString *) inPutText
{
    const char *cStr = [inPutText UTF8String];
    unsigned char result[32];
    CC_MD5(cStr, strlen(cStr), result);
    
    return [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}


#pragma mark --文件和路径管理--
//获取程序的Home目录路径
+(NSString *)GetHomeDirectoryPath {
    return NSHomeDirectory();
}
//获取document目录路径
+(NSString *)GetDocumentPath {
    NSArray *Paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path=[Paths objectAtIndex:0];
    return path;
}
//返回Documents下的指定文件路径(加创建)
+(NSString *)GetDirectoryForDocuments:(NSString *)dir
{
    NSError* error;
    NSString* path = [[self GetDocumentPath] stringByAppendingPathComponent:dir];
    if(![[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&error])
    {
        NSLog(@"create dir error: %@",error.debugDescription);
    }
    return path;
}
//获取Cache目录路径
+(NSString *)GetCachePath {
    NSArray *Paths=NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *path=[Paths objectAtIndex:0];
    return path;
}
//返回Caches下的指定文件路径
+(NSString *)GetDirectoryForCaches:(NSString *)dir
{
    NSError* error;
    NSString* path = [[self GetCachePath] stringByAppendingPathComponent:dir];
    
    if(![[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&error])
    {
        NSLog(@"create dir error: %@",error.debugDescription);
    }
    return path;
}
//获取Library目录路径
+(NSString *)GetLibraryPath {
    NSArray *Paths=NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *path=[Paths objectAtIndex:0];
    return path;
}
//获取Tmp目录路径
+(NSString *)GetTmpPath {
    return NSTemporaryDirectory();
}
//创建目录文件夹
+(NSString *)CreateList:(NSString *)List ListName:(NSString *)Name {
    NSFileManager *fileManager=[NSFileManager defaultManager];
    NSString *FileDirectory=[List stringByAppendingPathComponent:Name];
    if ([self IsFileExists:Name])
    {
        NSLog(@"exist,%@",Name);
    }
    else
    {
        [fileManager createDirectoryAtPath:FileDirectory withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return FileDirectory;
}
//写入NsArray文件
+(BOOL)WriteFileArray:(NSArray *)ArrarObject SpecifiedFile:(NSString *)path {
    return [ArrarObject writeToFile:path atomically:YES];
}
//写入NSDictionary文件
+(BOOL)WriteFileDictionary:(NSMutableDictionary *)DictionaryObject SpecifiedFile:(NSString *)path {
    return [DictionaryObject writeToFile:path atomically:YES];
}
//是否存在该文件
+(BOOL)IsFileExists:(NSString *)filepath {
    return [[NSFileManager defaultManager] fileExistsAtPath:filepath];
}

//是否存在目录，没有就创建
+(BOOL)IsFilePathExists:(NSString *)filepath {
    NSFileManager *fm = [NSFileManager defaultManager];
    if (![fm fileExistsAtPath:filepath]) {
        return [fm createDirectoryAtPath:filepath withIntermediateDirectories:YES attributes:nil error:NULL];
    }
    return YES;
}

//如果不存在，创建文件
+(BOOL)buildFileBy:(NSString *)filepath {
    NSFileManager *fm = [NSFileManager defaultManager];
    if (![self IsFileExists:filepath]) {
        return [fm createFileAtPath:filepath contents:nil attributes:nil];
    }
    return YES;
}

//删除指定文件
+(BOOL)DeleteFile:(NSString*)filepath {
    if([[NSFileManager defaultManager]fileExistsAtPath:filepath])
    {
        return [[NSFileManager defaultManager] removeItemAtPath:filepath error:nil];
    }
    return NO;
}
//删除 document/dir 目录下 所有文件
+(void)deleteAllForDocumentsDir:(NSString*)dir {
    NSFileManager* fileManager = [NSFileManager defaultManager];
    NSArray *fileList = [fileManager contentsOfDirectoryAtPath:[self GetDirectoryForDocuments:dir] error:nil];
    for (NSString* filename in fileList) {
        [fileManager removeItemAtPath:[self GetPathForDocuments:filename inDir:dir] error:nil];
    }
}
//获取目录列表里所有的文件名
+(NSArray *)GetSubpathsAtPath:(NSString *)path {
    NSFileManager *fileManage=[NSFileManager defaultManager];
    NSArray *file=[fileManage subpathsAtPath:path];
    return file;
}

//直接取文件数据
+(NSData*)GetDataForResource:(NSString*)name inDir:(NSString*)dir {
    return [self GetDataForPath:[self GetPathForResource:name inDir:dir]];
}
+(NSData*)GetDataForDocuments:(NSString *)name inDir:(NSString*)dir {
    return [self GetDataForPath:[self GetPathForDocuments:name inDir:dir]];
}

+(NSData*)GetDataForPath:(NSString*)path {
    return [[NSFileManager defaultManager] contentsAtPath:path];
}

//获取文件路径
+(NSString*)GetPathForCaches:(NSString *)filename {
    return [[self GetCachePath] stringByAppendingPathComponent:filename];
}
+(NSString*)GetPathForCaches:(NSString *)filename inDir:(NSString*)dir {
    return [[self GetDirectoryForCaches:dir] stringByAppendingPathComponent:filename];
}

+(NSString*)GetPathForDocuments:(NSString*)filename {
    return [[self GetDocumentPath] stringByAppendingPathComponent:filename];
}
+(NSString*)GetPathForDocuments:(NSString *)filename inDir:(NSString*)dir {
    return [[self GetDirectoryForDocuments:dir] stringByAppendingPathComponent:filename];
}

+(NSString*)GetPathForResource:(NSString *)name {
    return [[NSBundle mainBundle].resourcePath stringByAppendingPathComponent:name];
}

+(NSString*)GetPathForResource:(NSString *)name inDir:(NSString*)dir {
    return [[[NSBundle mainBundle].resourcePath stringByAppendingPathComponent:dir] stringByAppendingPathComponent:name];
}

#pragma mark --------



@end
