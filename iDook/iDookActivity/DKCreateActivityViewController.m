//
//  DKCreateActivityViewController.m
//  iDook
//
//  Created by sunshilong on 15/7/21.
//  Copyright (c) 2015年 sunshilong. All rights reserved.
//

#import "DKCreateActivityViewController.h"
#import "DkAddImageView.h"
#import "CTAssetsPickerController.h"
#import "PhotoPickerController.h"
#import "Tools.h"
#import "DKShowlocationViewController.h"
#import "DKBaseNavigationViewController.h"
#import "DKAudioRecordViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import "DKActivityShareSettingViewController.h"

@interface DKCreateActivityViewController ()
{
    UILabel *titleLabel;    //标题
    UILabel *faceLabel;     //封面
    UILabel *introductLabel;//简介
    UITextView *myTextView; //文字输入
    UILabel *overLab;       //计数
    
    PhotoPickerController *photoPicker;//
    NSMutableArray *dataArray;     //图片数组
    DkAddImageView *dkAddimage;    //加载图片
    
    UILabel *locationLabelDetial;       //显示位置的lab
    UIButton *deleteLocationBtn;  //删除位置的btn
    UIButton *deleteAudioBtn;  //删除位置的btn
    UIButton *playAudioBtn;  //播放语音
    NSString *playAudioPath;
}

@end

@implementation DKCreateActivityViewController
@synthesize createTableView;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"发布图文";
    [self loadMyViews];
    [self loadMyData];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)loadMyData{
    
    photoPicker = [[PhotoPickerController alloc] initWithDelegate:self];
    dataArray = [[NSMutableArray alloc] initWithCapacity:0];

}
- (void)loadMyViews{
    createTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeight-64) style:UITableViewStyleGrouped];
    createTableView.delegate = self;
    createTableView.dataSource = self;
    if ([createTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [createTableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([createTableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [createTableView setLayoutMargins:UIEdgeInsetsZero];
    }

    [self.view addSubview:createTableView];
    //地边视图
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, kHeight-64, kWidth, 64)];
    [self.view addSubview:bottomView];
    //取消
    UIButton *cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, kWidth/2-15, 44)];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    cancelBtn.backgroundColor = colorWhite;
    cancelBtn.tag = 11;
    cancelBtn.layer.cornerRadius = 4.0;
    cancelBtn.layer.borderWidth = 0.5;
    cancelBtn.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    [cancelBtn addTarget:self action:@selector(tapButton:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:cancelBtn];
    //发表
    UIButton *publishBtn = [[UIButton alloc] initWithFrame:CGRectMake(kWidth/2+5, 10, kWidth/2-15, 44)];
    [publishBtn setTitle:@"发表" forState:UIControlStateNormal];
    publishBtn.backgroundColor = [UIColor colorWithRed:22/255.0 green:170/255.0 blue:254/255.0 alpha:1.0];
    publishBtn.tag = 12;
    publishBtn.layer.cornerRadius = 4.0;
    publishBtn.layer.borderWidth = 0.5;
    publishBtn.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    [publishBtn addTarget:self action:@selector(tapButton:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:publishBtn];
    //文字输入初始化
    myTextView = [[UITextView alloc] initWithFrame:CGRectMake(10, 10, kWidth-20, 110)];
    myTextView.delegate = self;
    myTextView.font = [UIFont systemFontOfSize:15.0];
    myTextView.text = @"来说两句吧...";
    myTextView.textColor = [UIColor grayColor];
    myTextView.showsVerticalScrollIndicator = NO;
    myTextView.userInteractionEnabled = YES;
    myTextView.returnKeyType = UIReturnKeyDone;
//    myTextView.backgroundColor = [UIColor lightGrayColor];
    //剩余字数提示
    overLab = [[UILabel alloc] initWithFrame:CGRectMake(kWidth-70, 0, 70, 20)];
    [overLab setText:@"0/100"];
    overLab.textColor = colorLightGray;
    overLab.font = [UIFont systemFontOfSize:12];

    
}
#pragma mark - 底部按钮操作
- (void)tapButton:(UIButton*)sender{
    debugLog(@"点击%ld",(long)sender.tag);
    if(sender.tag==11){
        [self.navigationController popViewControllerAnimated:YES];
    }else if (sender.tag==12){
        //发表
        [self publishNewActivity];
    }
}
#pragma mark - 发表新的活动
- (void)publishNewActivity{
    
}
#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 2;
    }else {
        return 1;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            return 220.0;
        }else{
            return 70;
        }
    }else {
        return 70.0;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return 0.5;
    }else{
        return 10.0;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.5;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *Cell = @"createCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Cell];
    if (cell) {
        cell = nil;
    }
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Cell];
    switch (indexPath.section) {
        case 0:
        {
            if (indexPath.row==0) {
                [cell.contentView addSubview:myTextView];
                [cell.contentView addSubview:overLab];

                dkAddimage = [[DkAddImageView alloc] initWithFrame:CGRectMake(15, 120, kWidth-30, 100)];
                dkAddimage.deleget = self;
                [dkAddimage loadscrollViewWithImages:dataArray andTitles:nil];
                [cell.contentView addSubview:dkAddimage];
            }
            else{
                //img,语音小图标
                UIImageView *iconcellImg = [[UIImageView alloc] initWithFrame:CGRectMake(15, 25, 20, 20)];
                iconcellImg.image = [UIImage imageNamed:@"icon-activity-1"];
                [cell.contentView addSubview:iconcellImg];
                //
                UILabel *locationLabel = [[UILabel alloc] initWithFrame:CGRectMake(35, 20, 80, 30)];
                locationLabel.text = @"显示位置";
                [cell.contentView addSubview:locationLabel];
                //
                locationLabelDetial = [[UILabel alloc] initWithFrame:CGRectMake(120, 10, kWidth-160, 50)];
                locationLabelDetial.text = @"";
                locationLabelDetial.textColor = colorLightGray;
                locationLabelDetial.font = [UIFont systemFontOfSize:11];
                locationLabelDetial.numberOfLines = 0;
                [cell.contentView addSubview:locationLabelDetial];
                //
                deleteLocationBtn = [[UIButton alloc] initWithFrame:CGRectMake(kWidth-45, 20, 30, 30)];
                [deleteLocationBtn setBackgroundImage:[UIImage imageNamed:@"icon-activity-1"] forState:UIControlStateNormal];
                deleteLocationBtn.tag = 20;
                [deleteLocationBtn addTarget:self action:@selector(deleteLocationOrAudio:) forControlEvents:UIControlEventTouchUpInside];
                deleteLocationBtn.hidden = YES;
                [cell.contentView addSubview:deleteLocationBtn];
            }
            
            
        }
            break;
        case 1:
        {
            //img,语音小图标
            UIImageView *iconcellImg = [[UIImageView alloc] initWithFrame:CGRectMake(15, 25, 20, 20)];
            iconcellImg.image = [UIImage imageNamed:@"icon-activity-1"];
            [cell.contentView addSubview:iconcellImg];
            //
            UILabel *audioLabel = [[UILabel alloc] initWithFrame:CGRectMake(35, 20, 50, 30)];
            audioLabel.text = @"语音";
            [cell.contentView addSubview:audioLabel];
            //
            UILabel *audioLa = [[UILabel alloc] initWithFrame:CGRectMake(kWidth-150, 20, 130, 30)];
            audioLa.textColor = colorLightGray;
            audioLa.text = @"点击开始录音";
            audioLa.hidden = NO;
            [cell.contentView addSubview:audioLa];
            //
            playAudioBtn = [[UIButton alloc] initWithFrame:CGRectMake(kWidth-150, 20, 130, 30)];
            playAudioBtn.backgroundColor = [UIColor greenColor];
            [playAudioBtn addTarget:self action:@selector(playAudio:) forControlEvents:UIControlEventTouchUpInside];
            playAudioBtn.hidden = YES;
            [cell.contentView addSubview:playAudioBtn];
            //
            deleteAudioBtn = [[UIButton alloc] initWithFrame:CGRectMake(kWidth-45, 20, 30, 30)];
            [deleteAudioBtn setBackgroundImage:[UIImage imageNamed:@"icon-activity-1"] forState:UIControlStateNormal];
            deleteAudioBtn.tag = 21;
            [deleteAudioBtn addTarget:self action:@selector(deleteLocationOrAudio:) forControlEvents:UIControlEventTouchUpInside];
            deleteAudioBtn.hidden = YES;
            [cell.contentView addSubview:deleteAudioBtn];
        }
            break;
        case 2:
        {
            //img,语音小图标
            UIImageView *iconcellImg = [[UIImageView alloc] initWithFrame:CGRectMake(15, 25, 20, 20)];
            iconcellImg.image = [UIImage imageNamed:@"icon-activity-1"];
            [cell.contentView addSubview:iconcellImg];
            //
            UILabel *forwardLabel = [[UILabel alloc] initWithFrame:CGRectMake(35, 20, 80, 30)];
            forwardLabel.text = @"分享设置";
            [cell.contentView addSubview:forwardLabel];
        }
            break;
            
        default:
            break;
    }

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    debugLog(@"%ld",(long)indexPath.row);
    if (indexPath.section==0) {
        if (indexPath.row==1) {
            debugLog(@"显示位置");
            DKShowlocationViewController *showLocationv = [[DKShowlocationViewController alloc] init];
            showLocationv.delegate = self;
            DKBaseNavigationViewController *nav = [[DKBaseNavigationViewController alloc] initWithRootViewController:showLocationv];
            
            [self presentViewController:nav animated:YES completion:^{
                //
            }];
        }
    }else if (indexPath.section==1){
        DKAudioRecordViewController *audioV = [[DKAudioRecordViewController alloc] init];
        audioV.delegate = self;
        DKBaseNavigationViewController *nav = [[DKBaseNavigationViewController alloc] initWithRootViewController:audioV];
        [self presentViewController:nav animated:YES completion:^{
            //
        }];
    }else if (indexPath.section==2){
        DKActivityShareSettingViewController *shareV = [[DKActivityShareSettingViewController alloc] init];
        [self.navigationController pushViewController:shareV animated:YES];
//        DKBaseNavigationViewController *nav = [[DKBaseNavigationViewController alloc] initWithRootViewController:shareV];
//        [self presentViewController:nav animated:YES completion:^{
//            //
//        }];
    }
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}
#pragma mark - textView delegate
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@"来说两句吧..."]) {
        textView.text = @"";
        myTextView.textColor = [UIColor blackColor];
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@""]) {
        myTextView.text = @"来说两句吧...";
        myTextView.textColor = [UIColor grayColor];
    }
    else {
        myTextView.text = textView.text;
        myTextView.textColor = [UIColor blackColor];
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    NSString *string = [textView.text stringByReplacingCharactersInRange:range withString:text];
    if ([text isEqualToString:@"\n"])
    {
        [textView resignFirstResponder];
        return NO;
    }
    
    if ([string length] < 101) {
        overLab.text = [NSString stringWithFormat:@"%d/100",(int)[string length]];
        return YES;
    }
    else {
        textView.text = [string substringToIndex:100];
        overLab.text = [NSString stringWithFormat:@"100/100"];
        return NO;
    }
    return YES;
}
-(void)textViewDidChange:(UITextView *)textView
{
    if([textView.text length]<101)
    {
        overLab.text = [NSString stringWithFormat:@"%d/100",(int)[textView.text length]];
    }else
    {
        textView.text = [textView.text substringToIndex:101];
    }
}
#pragma mark - DKAddimageViewDelegate
- (void)startGetImage{
    debugLog(@"打开相机活着图库获取");
    UIActionSheet *pictureSheet = [[UIActionSheet alloc] initWithTitle:@"添加图片"
                                                              delegate:self
                                                     cancelButtonTitle:@"取消"
                                                destructiveButtonTitle:@"拍照"
                                                     otherButtonTitles:@"从相册选择", nil];
    [pictureSheet showInView:self.view];
    
}
#pragma mark - UIActionsheetDelegate 点击添加图片按钮
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:
        {
            debugLog(@"拍照");
            [myTextView resignFirstResponder];
            if ([dataArray count] >= 9) {
                [self.view makeToast:@"最多只能选择9张图片"];
                return;
            }
            if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
            {
                [photoPicker showWithCameraByDefined];
            }
            else
            {
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"您的设备暂无照相功能！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"从相册选择", nil];
                [alert show];
                return;
            }
        }
            break;
        case 1:
        {
            debugLog(@"相册");
            [myTextView resignFirstResponder];
            if ([dataArray count] >= 9) {
                [self.view makeToast:@"最多只能选择9张图片"];
                return;
            }
            
            if (kDeviceVersion < 7.0) {
                [photoPicker showWithAllPictureLibrary];
                return;
            }
            CTAssetsPickerController *picker = [[CTAssetsPickerController alloc] init];
            picker.maximumNumberOfSelection = 9 - [dataArray count];
            picker.assetsFilter = [ALAssetsFilter allPhotos];
//        picker.showsCancelButton = NO;
            picker.delegate = self;
            
            [self presentViewController:picker animated:YES completion:NULL];
        }
            break;
            
        default:
            break;
    }
}
- (void)showBigImage:(NSInteger)index{
    
}

#pragma mark AssetsPickerDelegate
- (void)assetsPickerController:(CTAssetsPickerController *)picker didFinishPickingAssets:(NSArray *)assets
{
    for (int i = 0; i < [assets count]; i++) {
        ALAsset *asset = [assets objectAtIndex:i];
        if ([asset isKindOfClass:[ALAsset class]]) {
            [dataArray addObject:[UIImage imageWithCGImage:asset.defaultRepresentation.fullScreenImage]];
        }
    }
    //刷新
    [createTableView reloadSections:[[NSIndexSet alloc] initWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
}

- (void)assetsPickerControllerDidCancel:(CTAssetsPickerController *)picker {
    
}

#pragma mark - UIImagePickerControllerDelegate -
- (void)photoPickerController:(PhotoPickerController *)controller didFinishPickingWithImage:(UIImage *)image isFromCamera:(BOOL)isFromCamera{
    
    [dataArray addObject:[Tools scaleImage:image length:1000]];
    [createTableView reloadSections:[[NSIndexSet alloc] initWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
}

- (void)photoPickerControllerCancel:(PhotoPickerController *)controller {
}
#pragma mark - ----------------------
#pragma mark - 删除位置或语音
- (void)deleteLocationOrAudio:(UIButton *)sender{
    if (sender.tag==20) {
        locationLabelDetial.text = @"";
        deleteLocationBtn.hidden = YES;
    }else if (sender.tag==21){
        
    }
}
#pragma mark - 地图定位代理回调
- (void)getMylocation:(NSString *)myLocation{
    locationLabelDetial.text = myLocation;
    deleteLocationBtn.hidden = NO;
}
#pragma mark - 播放语音
- (void)playAudio:(UIButton*)sender{
    debugLog(@"播放语音");
    if (self.avPlay.playing) {
        [self.avPlay stop];
        return;
    }
    NSURL *audioUrl=[[NSURL alloc] initFileURLWithPath:playAudioPath];
    AVAudioPlayer *player = [[AVAudioPlayer alloc]initWithContentsOfURL:audioUrl error:nil];
    self.avPlay = player;
    [self.avPlay play];
    
}
#pragma mark - 录音回调
- (void)getAudio:(NSString *)audioPath andAudioTime:(CGFloat)audiotime{
    debugLog(@"语音路径是：%@/n语音时长%f",audioPath,audiotime);
    if ([audioPath length]!=0) {
        playAudioPath = [[NSString alloc] initWithString:audioPath];
        playAudioBtn.hidden = NO;
        deleteAudioBtn.hidden = NO;
    }
    
}
@end
