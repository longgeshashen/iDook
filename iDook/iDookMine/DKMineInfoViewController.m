//
//  DKMineInfoViewController.m
//  iDook
//
//  Created by sunshilong on 15/7/31.
//  Copyright (c) 2015年 sunshilong. All rights reserved.
//

#import "DKMineInfoViewController.h"
#import "CTAssetsPickerController.h"
#import "PhotoPickerController.h"
#import "Tools.h"
#import "User.h"
#import "UIImageView+WebCache.h"
#import "DKUserServerce.h"

@interface DKMineInfoViewController ()
{
    UIImageView *cellfaceImageView;//
    UIImage *faceImage;//封面图片
    PhotoPickerController *photoPicker;
    User *user;
}
@end

@implementation DKMineInfoViewController
@synthesize mineInfoTableView;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人信息";
    [self loadMyViews];
    [self loadMyDatas];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)loadMyDatas{
    photoPicker = [[PhotoPickerController alloc] initWithDelegate:self];
    faceImage = [UIImage imageNamed:@"noimage_tucao" ];
    //
    user = [[DKUserServerce sharedInstance] getMyself];
    
    [self getUserInfoOnline];
}
#pragma mark - 获取服务器的个人资料
- (void)getUserInfoOnline{
    NSMutableDictionary *entity =[[NSMutableDictionary alloc] init];
    [entity setObject:user.user_serverId forKey:@"uId"];
    
    NSMutableDictionary *entDict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:entity, @"entity", nil];
    NSString * url = [APP_SERVER stringByAppendingString:HTTP_getUserInfo];

    [CoreHttp postUrl:url params:entDict success:^(id obj) {
        //
        debugLog(@"获取的个人信息是%@",obj);
        
    } errorBlock:^(CoreHttpErrorType errorType) {
        //
    }];
}
- (void)loadMyViews{
    mineInfoTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeight) style:UITableViewStyleGrouped];
    mineInfoTableView.dataSource = self;
    mineInfoTableView.delegate = self;
    
    if ([mineInfoTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [mineInfoTableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([mineInfoTableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [mineInfoTableView setLayoutMargins:UIEdgeInsetsZero];
    }
    [self.view addSubview:mineInfoTableView];
}

#pragma mark - UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 2;
    }
    return 5;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0&&indexPath.row==0) {
        return 100.0;
    }
    return 50.0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return 0.5;
    }
    return 5.0;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *Cell = @"mineInfocell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Cell];
    if (cell==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Cell];
        if (indexPath.section==0) {
            if (indexPath.row==0) {
                //
                UILabel *faceL = [[UILabel alloc] initWithFrame:CGRectMake(15, 30, 80, 40)];
                faceL.text = @"头像";
                faceL.backgroundColor = [UIColor clearColor];
                [cell.contentView addSubview:faceL];
                //
                cellfaceImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kWidth-95, 10, 80, 80)];
                
                if ([user.user_headimgurl isKindOfClass:[NSString class]] && [user.user_headimgurl length] > 0) {
                    [cellfaceImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@?imageView2/1/w/200/h/200",user.user_headimgurl]] placeholderImage:[UIImage imageNamed:@"headerimg01"]];
                }
                else {
                    [cellfaceImageView setImage:[UIImage imageNamed:@"headerimg01"]];
                }
                cellfaceImageView.layer.cornerRadius = 6.0;
                cellfaceImageView.layer.borderWidth = 0.2;
                cellfaceImageView.layer.borderColor = [colorLightGray CGColor];
                [cell.contentView addSubview:cellfaceImageView];
                //
                UIButton *selectImage = [[UIButton alloc] initWithFrame:CGRectMake(kWidth-95, 10, 80, 80)];
                [selectImage addTarget:self action:@selector(selectImage:) forControlEvents:UIControlEventTouchUpInside];
                [cell.contentView addSubview:selectImage];
            }else{
                //
                UILabel *faceL = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 80, 30)];
                faceL.text = @"昵称";
                faceL.backgroundColor = [UIColor clearColor];
                [cell.contentView addSubview:faceL];
                //nick
                UILabel *nickLabel = [[UILabel alloc] initWithFrame:CGRectMake(kWidth-155, 10, 140, 30)];
                nickLabel.text = user.user_nickname;
                nickLabel.textColor = [UIColor grayColor];
                nickLabel.textAlignment = NSTextAlignmentRight;
                nickLabel.backgroundColor = [UIColor clearColor];
                [cell.contentView addSubview:nickLabel];
            
            }
            
        }else{
            //
            UILabel *faceL = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 80, 30)];
            
            faceL.backgroundColor = [UIColor clearColor];
            [cell.contentView addSubview:faceL];
            //nick
            UILabel *nickLabel = [[UILabel alloc] initWithFrame:CGRectMake(kWidth-155, 10, 140, 30)];
            
            nickLabel.textColor = [UIColor grayColor];
            nickLabel.textAlignment = NSTextAlignmentRight;
            nickLabel.backgroundColor = [UIColor clearColor];
            [cell.contentView addSubview:nickLabel];
            switch (indexPath.row) {
                case 0:
                {
                    faceL.text = @"姓名";
                    
                    nickLabel.text = user.user_name;
                }
                    break;
                case 1:
                {
                    faceL.text = @"性别";
                    if ([user.user_sex isEqualToString:@"1"]) {
                        nickLabel.text = @"男";
                    }else{
                        nickLabel.text = @"女";
                    }
                    
                }
                    break;
                case 2:
                {
                    faceL.text = @"生日";
                    nickLabel.text = user.user_birthday;
                }
                    break;
                case 3:
                {
                    faceL.text = @"手机号";
                    nickLabel.text = user.user_mobile;
                }
                    break;
                case 4:
                {
                    faceL.text = @"邮箱";
                    nickLabel.text = user.user_email;
                }
                    break;
                    
                default:
                    break;
            }
        
        }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    debugLog(@"个人信息选择的是%d",indexPath.row);
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

            faceImage = [UIImage imageWithCGImage:asset.defaultRepresentation.fullScreenImage];
        }
    }
    //刷新
    cellfaceImageView.image = faceImage;
    
}

- (void)assetsPickerControllerDidCancel:(CTAssetsPickerController *)picker {
    
}

#pragma mark - UIImagePickerControllerDelegate -
- (void)photoPickerController:(PhotoPickerController *)controller didFinishPickingWithImage:(UIImage *)image isFromCamera:(BOOL)isFromCamera{
    
    faceImage = [Tools scaleImage:image length:1000];
    cellfaceImageView.image = faceImage;
    
}

- (void)photoPickerControllerCancel:(PhotoPickerController *)controller {
}
@end