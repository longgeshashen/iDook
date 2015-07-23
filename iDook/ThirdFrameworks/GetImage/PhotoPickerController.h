//
//  PhotoPickerController.h
//  Sample
//
//  Created by Kirby Turner on 2/2/10.
//  Copyright 2010 White Peak Software Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoPickerController : NSObject <UINavigationControllerDelegate, UIImagePickerControllerDelegate> {
   id delegate_;
   UIImagePickerController *imagePicker_;
   BOOL isFromCamera_;
   BOOL mediaTypeIsVideo;
    
    NSString *useCameraName;
    
}
@property (nonatomic,retain)NSString *useCameraName;

/*
 @method     
 @author      lijie
 @date        2013-04-26
 @description 创建拍照、视频的对象
 @param       使用拍照的控制器
 @result      生成用于拍照、视频的对象
 */
- (id)initWithDelegate:(id)delegate;

/*
 @method     
 @author      lijie
 @date        2013-04-25
 @description 调用摄像头拍照
 @param       
 @result      拍照
 */
- (void)showWithCamera;

/*
 @method
 @author      wangbo
 @date        2013-04-25
 @description 调用自定义的摄像头拍照
 @param
 @result      拍照
 */
- (void)showWithCameraByDefined;

/*
 @method     
 @author      lijie
 @date        2013-04-26
 @description 调用摄像头打开图片库 wangbo:打开的是相册，不是图片库
 @param       
 @result      获取图片库里的照片
 */
- (void)showWithPhotoLibrary;

/*
 @method     
 @author      wangbo
 @date        2013-06-09
 @description 调用摄像头打开图片库
 @param       
 @result      获取图片库里的照片
 */
- (void)showWithAllPictureLibrary;


/*
 @method     
 @author      lijie
 @date        2013-04-25
 @description 调用摄像头录制视频
 @param       
 @result      视频录制
 */
- (void)showWithVideo;

@end

@protocol PhotoPickerControllerDelegate <NSObject> 
@optional
//摄像头返回拍完的照片image;isFromCamera标示是否来自图库还是拍照
- (void)photoPickerController:(PhotoPickerController *)controller didFinishPickingWithImage:(UIImage *)image isFromCamera:(BOOL)isFromCamera;
//摄像头返回录制完的视频信息字典
- (void)imagePickerController:(PhotoPickerController *)controller didFinishPickingVideoWithInfo:(NSDictionary *)info;

- (void)photoPickerControllerCancel:(PhotoPickerController *)controller;
@end;
