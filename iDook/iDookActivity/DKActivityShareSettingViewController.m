//
//  DKActivityShareSettingViewController.m
//  iDook
//
//  Created by sunshilong on 15/7/27.
//  Copyright (c) 2015年 sunshilong. All rights reserved.
//

#import "DKActivityShareSettingViewController.h"
#import "CTAssetsPickerController.h"
#import "PhotoPickerController.h"
#import "Tools.h"
@interface DKActivityShareSettingViewController ()
{
    UITextField *titleField;//标题
    UITextView *introlducField;//简介
    
    UIImage *faceImage;//封面图片
    UIImageView *cellfaceImageView;//cell图
    
    UIImageView *prefaceImgView;//预览图片
    UILabel     *preTitleL;//预览标题
    UITextView  *preTextV; //预览简介
    
    PhotoPickerController *photoPicker;
}
@end

@implementation DKActivityShareSettingViewController
@synthesize shareSettingTableView;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"分享设置";
    [self loadMyView];
    photoPicker = [[PhotoPickerController alloc] initWithDelegate:self];
    
    faceImage = [UIImage imageNamed:@"noimage_tucao" ];
    //
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}
#pragma mark - 键盘
- (void)keyboardWillShow:(NSNotification *)notif {
    
    CGRect frameSelf = shareSettingTableView.frame;
    frameSelf.origin.y -= 20.0;
    shareSettingTableView.frame = frameSelf;
}

- (void)keyboardWillHide:(NSNotification *)notif {
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.25];
    shareSettingTableView.frame = CGRectMake(0, 0, kWidth, kHeight);
    preTitleL.text = titleField.text;
    preTextV.text = introlducField.text;
    
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)loadMyView{
    shareSettingTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeight) style:UITableViewStyleGrouped];
    shareSettingTableView.dataSource = self;
    shareSettingTableView.delegate = self;
    [self.view addSubview:shareSettingTableView];
    //保存按钮
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 40, 40);
    [rightBtn addTarget:self action:@selector(saveShareSetting) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setTitle:@"保存" forState:UIControlStateNormal];

    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
}
#pragma mark --------
//返回
//- (void)backButtonClick:(UIButton *)btn {
//    
//    [self dismissViewControllerAnimated:YES completion:^{
//    }];
//}
#pragma mark - 保存
- (void)saveShareSetting{
    debugLog(@"保存");
}
#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.5;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 120.0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        return 100.0;
    }else if (indexPath.row==1){
        return 50.0;
    }else{
        return 80.0;
    }
    
}
- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *viewF = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth, 120.0)];
    viewF.backgroundColor = [UIColor clearColor];
    //
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 150, 30)];
    lab.text = @"分享效果预览";
    lab.backgroundColor = [UIColor clearColor];
    lab.font = [UIFont systemFontOfSize:13];
    lab.textColor = colorLightGray;
    [viewF addSubview:lab];
    //
    UIView *preView = [[UIView alloc] initWithFrame:CGRectMake(15, 40, kWidth-30, 100)];
    preView.backgroundColor = colorWhite;
    [viewF addSubview:preView];
    //
    prefaceImgView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, 80, 80)];
    prefaceImgView.image = faceImage;
    [preView addSubview:prefaceImgView];
    //
    preTitleL = [[UILabel alloc] initWithFrame:CGRectMake(105, 15, kWidth-115-20, 30)];
    preTitleL.text = @"";
    [preView addSubview:preTitleL];
    //
    preTextV = [[UITextView alloc] initWithFrame:CGRectMake(100, 40, kWidth-115-15, 40)];
    preTextV.text = @"";
    preTextV.textColor = colorLightGray;
    preTextV.editable = NO;
    preTextV.showsVerticalScrollIndicator = NO;
    
    preTextV.font = [UIFont systemFontOfSize:12];
    [preView addSubview:preTextV];
    
    return viewF;
    
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *Cell = @"shareCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Cell];
    if (cell==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Cell];
        //
        switch (indexPath.row) {
            case 0:
            {
                UILabel *faceL = [[UILabel alloc] initWithFrame:CGRectMake(15, 30, 80, 40)];
                faceL.text = @"封面图";
                faceL.backgroundColor = [UIColor clearColor];
                [cell.contentView addSubview:faceL];
                //
                cellfaceImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kWidth-105, 10, 80, 80)];
                cellfaceImageView.image = faceImage;
                [cell.contentView addSubview:cellfaceImageView];
                //
                UIButton *selectImage = [[UIButton alloc] initWithFrame:CGRectMake(kWidth-105, 10, 80, 80)];
                selectImage.backgroundColor = [UIColor clearColor];
                [selectImage addTarget:self action:@selector(selectImage:) forControlEvents:UIControlEventTouchUpInside];
                [cell.contentView addSubview:selectImage];
            }
                break;
            case 1:
            {
                //
                UILabel *titleL = [[UILabel alloc] initWithFrame:CGRectMake(15, 5, 80, 40)];
                titleL.text = @"标题";
                titleL.backgroundColor = [UIColor clearColor];
                [cell.contentView addSubview:titleL];
                
                titleField = [[UITextField alloc] initWithFrame:CGRectMake(100.0, 5, kWidth-100-15, 40)];
                titleField.font = [UIFont systemFontOfSize:13];
                titleField.delegate = self;
                titleField.returnKeyType = UIReturnKeyDone;
                [cell.contentView addSubview:titleField];
            }
                break;
            case 2:
            {
                //
                UILabel *introlductL = [[UILabel alloc] initWithFrame:CGRectMake(15, 20, 80, 40)];
                introlductL.text = @"简介";
                introlductL.backgroundColor = [UIColor clearColor];
                [cell.contentView addSubview:introlductL];
                //
                introlducField = [[UITextView alloc] initWithFrame:CGRectMake(90.0, 10, kWidth-100-15, 60)];
                introlducField.font = [UIFont systemFontOfSize:12];
                introlducField.delegate = self;
                introlducField.backgroundColor = [UIColor clearColor];
                introlducField.returnKeyType = UIReturnKeyDone;
                [cell.contentView addSubview:introlducField];
                
            }
                break;
                
            default:
                break;
        }
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;

}
#pragma mark - UiTextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [titleField resignFirstResponder];
    return YES;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    [introlducField resignFirstResponder];
    
    return YES;
}
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    [titleField resignFirstResponder];
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
//    NSString *string = [textView.text stringByReplacingCharactersInRange:range withString:text];
    if ([text isEqualToString:@"\n"])
    {
        [introlducField resignFirstResponder];
        return NO;
    }
    return YES;
}
#pragma mark - 选择图片
- (void)selectImage:(UIButton*)sender{
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
            [titleField resignFirstResponder];
            [introlducField resignFirstResponder];
//            if ([dataArray count] >= 1) {
//                [self.view makeToast:@"最多只能选择1张图片"];
//                return;
//            }
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
            [titleField resignFirstResponder];
            [introlducField resignFirstResponder];
//            if ([dataArray count] >= 1) {
//                [self.view makeToast:@"最多只能选择9张图片"];
//                return;
//            }
            
            if (kDeviceVersion < 7.0) {
                [photoPicker showWithAllPictureLibrary];
                return;
            }
            CTAssetsPickerController *picker = [[CTAssetsPickerController alloc] init];
            picker.maximumNumberOfSelection = 1;
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

#pragma mark AssetsPickerDelegate
- (void)assetsPickerController:(CTAssetsPickerController *)picker didFinishPickingAssets:(NSArray *)assets
{
    for (int i = 0; i < [assets count]; i++) {
        ALAsset *asset = [assets objectAtIndex:i];
        if ([asset isKindOfClass:[ALAsset class]]) {
//            [dataArray addObject:[UIImage imageWithCGImage:asset.defaultRepresentation.fullScreenImage]];
            faceImage = [UIImage imageWithCGImage:asset.defaultRepresentation.fullScreenImage];
        }
    }
    //刷新
//    [shareSettingTableView reloadSections:[[NSIndexSet alloc] initWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
    cellfaceImageView.image = faceImage;
    prefaceImgView.image = faceImage;
}

- (void)assetsPickerControllerDidCancel:(CTAssetsPickerController *)picker {
    
}

#pragma mark - UIImagePickerControllerDelegate -
- (void)photoPickerController:(PhotoPickerController *)controller didFinishPickingWithImage:(UIImage *)image isFromCamera:(BOOL)isFromCamera{
    
//    [dataArray addObject:[Tools scaleImage:image length:1000]];
    faceImage = [Tools scaleImage:image length:1000];
//    [shareSettingTableView reloadSections:[[NSIndexSet alloc] initWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
    cellfaceImageView.image = faceImage;
    prefaceImgView.image = faceImage;
}

- (void)photoPickerControllerCancel:(PhotoPickerController *)controller {
}

@end
