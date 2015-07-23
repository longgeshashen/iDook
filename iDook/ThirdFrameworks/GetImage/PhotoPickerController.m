//
//  PhotoPickerController.m
//  Sample
//
//  Created by Kirby Turner on 2/2/10.
//  Copyright 2010 White Peak Software Inc. All rights reserved.
//

#import "PhotoPickerController.h"
#import "Tools.h"

#define BUTTON_TAKEPHOTO 0
#define BUTTON_USELIBRARY 1
#define BUTTON_CANCEL 2

@interface PhotoPickerController (Private)
- (UIImagePickerController *)imagePicker;
@end

@implementation PhotoPickerController
@synthesize useCameraName;

- (id)initWithDelegate:(id)delegate {
   if (self = [super init]) {
      delegate_ = delegate;
   }
   return self;
}


- (void)showImagePicker
{
    if ([delegate_ respondsToSelector:@selector(presentModalViewController:animated:)]) {
        if([[[UIDevice currentDevice] systemVersion] floatValue]>=8.0) {
            [delegate_ setModalPresentationStyle:UIModalPresentationOverCurrentContext];
        }
        [delegate_ presentModalViewController:imagePicker_ animated:YES];
    }
}


- (void)showWithCamera {
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        mediaTypeIsVideo = NO;
        isFromCamera_ = YES;
        UIImagePickerController *cameraPicker = [self imagePicker];
        [cameraPicker setSourceType:UIImagePickerControllerSourceTypeCamera];
        [cameraPicker setMediaTypes:[NSArray arrayWithObject:@"public.image"]];
        
        [self showImagePicker];
        
    }
    else
    {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"对不起，该设备没有摄像头" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
    }
}

- (void)showWithCameraByDefined {
    mediaTypeIsVideo = NO;
    isFromCamera_ = YES;
    UIImagePickerController *cameraPicker = [self imagePicker];
    [cameraPicker setSourceType:UIImagePickerControllerSourceTypeCamera];
    [cameraPicker setMediaTypes:[NSArray arrayWithObject:@"public.image"]];
    [cameraPicker setCameraDevice:UIImagePickerControllerCameraDeviceRear];
    
    [self myCameraView];
    
    [self showImagePicker];
}

- (void)myCameraView {
    
    [self imagePicker].showsCameraControls = NO;

    UIView *coverView = [[UIView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 100, [UIScreen mainScreen].bounds.size.width, 100)];
    coverView.backgroundColor = [UIColor clearColor];
    
    UIView *btnBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 100)];
    btnBgView.backgroundColor = [UIColor blackColor];
    btnBgView.alpha = 0.4;
    [coverView addSubview:btnBgView];
    
    UIButton *switchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    switchBtn.frame = CGRectMake(10, 27, 36, 36);
    switchBtn.showsTouchWhenHighlighted = YES;
    switchBtn.backgroundColor = [UIColor clearColor];
    [switchBtn setImage:[UIImage imageNamed:@"camera-change"] forState:UIControlStateNormal];
    [switchBtn addTarget:self action:@selector(switchBtnCameraDevice:) forControlEvents:UIControlEventTouchUpInside];
    [coverView addSubview:switchBtn];

    UIButton *libraryBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    libraryBtn.frame = CGRectMake(80, 27, 36, 36);
    libraryBtn.showsTouchWhenHighlighted = YES;
    libraryBtn.backgroundColor = [UIColor clearColor];
    [libraryBtn setImage:[UIImage imageNamed:@"camera-img"] forState:UIControlStateNormal];
    [libraryBtn addTarget:self action:@selector(changeLibrary) forControlEvents:UIControlEventTouchUpInside];
        [coverView addSubview:libraryBtn];
    
    UIButton *cameraBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cameraBtn.frame = CGRectMake(coverView.bounds.size.width/2 - 18, 27, 36, 36);
    cameraBtn.showsTouchWhenHighlighted = YES;
    cameraBtn.backgroundColor = [UIColor clearColor];
    [cameraBtn setImage:[UIImage imageNamed:@"camera-photo"] forState:UIControlStateNormal];
    [cameraBtn addTarget:self action:@selector(takePicture) forControlEvents:UIControlEventTouchUpInside];
    [coverView addSubview:cameraBtn];

    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.frame = CGRectMake(coverView.bounds.size.width - 70, 27, 36, 36);
    cancelBtn.showsTouchWhenHighlighted = YES;
    cancelBtn.backgroundColor = [UIColor clearColor];
    [cancelBtn setImage:[UIImage imageNamed:@"camera-delete"] forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
    [coverView addSubview:cancelBtn];
    
    [self imagePicker].cameraOverlayView = coverView;
}

- (void)showWithPhotoLibrary {
    isFromCamera_ = NO;
    mediaTypeIsVideo = NO;
    UIImagePickerController *photoPicker = [self imagePicker];
    [photoPicker setSourceType:UIImagePickerControllerSourceTypeSavedPhotosAlbum];
    [photoPicker setMediaTypes:[NSArray arrayWithObject:@"public.image"]];
    [self showImagePicker];
}

- (void)showWithAllPictureLibrary {
    isFromCamera_ = NO;
    mediaTypeIsVideo = NO;
    UIImagePickerController *allPicturePicker = [self imagePicker];
    [allPicturePicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    [allPicturePicker setAllowsEditing:NO];
    [allPicturePicker setToolbarHidden:YES];
    [self showImagePicker];
    
}

- (void)showWithVideo
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        mediaTypeIsVideo = YES;
        isFromCamera_ = YES;
        UIImagePickerController *videoPicker = [self imagePicker];
        [videoPicker setSourceType:UIImagePickerControllerSourceTypeCamera];
        [videoPicker setAllowsEditing:YES];
        [videoPicker setVideoQuality:UIImagePickerControllerQualityTypeMedium];
        [videoPicker setMediaTypes:[NSArray arrayWithObject:@"public.movie"]];
        [self showImagePicker];
    }
    else
    {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"对不起，该设备没有摄像头" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
    }
}

- (UIImagePickerController *)imagePicker {
   if (imagePicker_) {
      return imagePicker_;
   }   
   imagePicker_ = [[UIImagePickerController alloc] init];
   [imagePicker_ setDelegate:self];
   [imagePicker_ setAllowsEditing:NO];
   return imagePicker_;
}

#pragma mark -
#pragma mark UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:^{
        if (mediaTypeIsVideo)
        {
            if ([delegate_ respondsToSelector:@selector(imagePickerController:didFinishPickingVideoWithInfo:)])
            {
                
                [delegate_ imagePickerController:self didFinishPickingVideoWithInfo:info];
            }
        }
        else
        {
            UIImage *newImage = [info objectForKey:UIImagePickerControllerOriginalImage];
            UIImageOrientation imageOrientation=newImage.imageOrientation;
            if(imageOrientation!=UIImageOrientationUp)
            {
                // 原始图片可以根据照相时的角度来显示，但UIImage无法判定，于是出现获取的图片会向左转９０度的现象。
                // 以下为调整图片角度的部分
                UIGraphicsBeginImageContext(newImage.size);
                [newImage drawInRect:CGRectMake(0, 0, newImage.size.width, newImage.size.height)];
                newImage = UIGraphicsGetImageFromCurrentImageContext();
                UIGraphicsEndImageContext();
                // 调整图片角度完毕
            }
            [picker dismissViewControllerAnimated:YES completion:nil];
            if ([delegate_ respondsToSelector:@selector(photoPickerController:didFinishPickingWithImage:isFromCamera:)])
            {
                
                [delegate_ photoPickerController:self didFinishPickingWithImage:newImage isFromCamera:isFromCamera_];
            }
        }
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:^{
        if ([delegate_ respondsToSelector:@selector(photoPickerControllerCancel:)]) {
            [delegate_ photoPickerControllerCancel:self];
        }
    }];
}

//切换前后置摄像头
- (void)switchBtnCameraDevice:(id)sender {
    if ([self imagePicker].cameraDevice == UIImagePickerControllerCameraDeviceRear) {
        [[self imagePicker] setCameraDevice:UIImagePickerControllerCameraDeviceFront];
    }
    else {
        [[self imagePicker] setCameraDevice:UIImagePickerControllerCameraDeviceRear];
    }
}

- (void)changeLibrary{
    [[self imagePicker] dismissViewControllerAnimated:NO completion:^{
        [self showWithAllPictureLibrary];
    }];
}

- (void)takePicture {
    [[self imagePicker] takePicture];
}

- (void)cancel {
    [[self imagePicker] dismissViewControllerAnimated:YES completion:^{
        if ([delegate_ respondsToSelector:@selector(photoPickerControllerCancel:)]) {
            [delegate_ photoPickerControllerCancel:self];
        }
    }];
}


@end
