//
//  AppDelegate.m
//  iDook
//
//  Created by sunshilong on 15/7/17.
//  Copyright (c) 2015年 sunshilong. All rights reserved.
//

#import "AppDelegate.h"
#import "DKBaseNavigationViewController.h"
#import "UITabBarItem+Universal.h"
#import "Tools.h"
#import "GuideVC.h"
#import "DKLoginViewController.h"
#import <BaiduMapAPI/BMapKit.h>//引入所有的头文件
#import "User.h"
#import "CoreHttp.h"

@interface AppDelegate ()
{
    BMKMapManager* _mapManager;
    NSString *WX_code;//拉去的code
    NSString *WX_access_token;//获取access_token
    NSString *WX_openid;//openId
}
@end

@implementation AppDelegate
@synthesize DKTabBarController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    //初始化控制器
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    DKTabBarController = [[UITabBarController alloc] init];
    

    NSArray *tabImage = @[@"btnav-act",@"btnav-mclass",@"btnav-my"];
    NSArray *tabImage_select = @[@"btnav-act2",@"btnav-mclass2",@"btnav-my2"];//这里可以不加选中变色的图片
    NSArray *viewControllerArray=@[@"DKAddressListViewController",@"DkActivityViewController",@"DkMineViewController"];
    NSArray *tabTitle=@[@"线索",@"图文",@"我的"];
    NSMutableArray *recordViewControllers=[[NSMutableArray alloc]initWithCapacity:0];
    for (unsigned i=0; i<[viewControllerArray count]; i++) {
        NSString *viewControllersString=[viewControllerArray objectAtIndex:i];
        NSString *title=[tabTitle objectAtIndex:i];
        UIImage *scale_image=[UIImage imageNamed:[tabImage objectAtIndex:i]];
        UIImage *scale_selectimage=[UIImage imageNamed:[tabImage_select objectAtIndex:i]];
        UIViewController *viewControllerClass=[[NSClassFromString(viewControllersString) alloc]initWithNibName:nil bundle:nil];
        DKBaseNavigationViewController *_navigationController=[[DKBaseNavigationViewController alloc]initWithRootViewController:viewControllerClass];
        UITabBarItem *tabBarItem=[UITabBarItem itemWithTitle:title image:scale_image selectedImage:scale_selectimage];
        [_navigationController setTabBarItem:tabBarItem];
        [recordViewControllers addObject:_navigationController];
    }
    //tabbar选中颜色和title颜色
    if ([[[UIDevice currentDevice]systemVersion]floatValue]<7.0) {
        
        [[UITabBar appearance] setBackgroundImage:[Tools createImageWithColor:[UIColor colorWithRed:1.000 green:1.000 blue:1.000 alpha:1]]];
        
        [[UITabBar appearance] setSelectionIndicatorImage:[UIImage new]];
        [[UITabBarItem appearance] setTitleTextAttributes:
         @{ UITextAttributeTextShadowOffset: [NSValue valueWithUIOffset:UIOffsetMake(0, 0)],
            UITextAttributeTextColor: [UIColor colorWithRed:22/255.0 green:170/255.0 blue:254/255.0 alpha:1.0] }
                                                 forState:UIControlStateSelected];
        
    }else{
        [[UITabBarItem appearance] setTitleTextAttributes:
         @{ UITextAttributeTextShadowOffset: [NSValue valueWithUIOffset:UIOffsetMake(0, 0)],
            UITextAttributeTextColor: colorTabBar,UITextAttributeFont:[UIFont systemFontOfSize:13 weight:1.0]} forState:UIControlStateSelected];
        [[UITabBarItem appearance] setTitleTextAttributes:
         @{ UITextAttributeTextShadowOffset: [NSValue valueWithUIOffset:UIOffsetMake(0, 0)],
            UITextAttributeTextColor: [UIColor darkGrayColor],UITextAttributeFont:[UIFont systemFontOfSize:13 weight:1.0]} forState:UIControlStateNormal];

    }
    [DKTabBarController.tabBar setBackgroundColor:[UIColor whiteColor]];
    [DKTabBarController.tabBar setSelectedImageTintColor:colorTabBar];
    [DKTabBarController setViewControllers:recordViewControllers animated:YES];
    [DKTabBarController setSelectedIndex:0];
    [DKTabBarController setDelegate:self];
    
    [self reloadTabBar];
    
    //欢迎页
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"appversion"]floatValue]<[myAPPVersion floatValue])  {
        GuideVC *guideVC=[[GuideVC alloc] init];
        self.window.rootViewController = guideVC;
    }
    else{
        self.window.rootViewController = DKTabBarController;
    }
    //初始化百度地图服务
    _mapManager = [[BMKMapManager alloc] init];
    BOOL ret = [_mapManager start:baiduKey generalDelegate:nil];
    if (!ret) {
        debugLog(@"百度地图初始化失败");
    }
    //微信注册
    [WXApi registerApp:WXAppkey withDescription:@"iDook"];
    
    [self.window makeKeyAndVisible];
    return YES;
}

#pragma mark -  自定义TabBar方法
- (void)reloadTabBar{
    NSLog(@"刷新TabBar,更新消息数量");
}
- (void)gotoMainPage {
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"isLogin"]) {
        DKLoginViewController *loginV = [[DKLoginViewController alloc] init];
        self.window.rootViewController =loginV;
    }else{
        self.window.rootViewController = DKTabBarController;
    }
    
}
#pragma mark - 控制器默认方法
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    [BMKMapView willBackGround];//当应用即将后台时调用，停止一切调用opengl相关的操作
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [BMKMapView didForeGround];//当应用恢复前台状态时调用，回复地图的渲染和opengl相关的操作
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
#pragma mark - 引入微信SDK需重新方法
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return  [WXApi handleOpenURL:url delegate:self];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return  [WXApi handleOpenURL:url delegate:self];
}

#pragma mark - 微信回调方法
-(void) onReq:(BaseReq*)req
{
    if([req isKindOfClass:[GetMessageFromWXReq class]])
    {
        GetMessageFromWXReq *temp = (GetMessageFromWXReq *)req;
        
        // 微信请求App提供内容， 需要app提供内容后使用sendRsp返回
        NSString *strTitle = [NSString stringWithFormat:@"微信请求App提供内容"];
        NSString *strMsg = [NSString stringWithFormat:@"openID: %@", temp.openID];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        alert.tag = 1000;
        [alert show];
        
    }
    else if([req isKindOfClass:[ShowMessageFromWXReq class]])
    {
        ShowMessageFromWXReq* temp = (ShowMessageFromWXReq*)req;
        WXMediaMessage *msg = temp.message;
        
        //显示微信传过来的内容
        WXAppExtendObject *obj = msg.mediaObject;
        
        NSString *strTitle = [NSString stringWithFormat:@"微信请求App显示内容"];
        NSString *strMsg = [NSString stringWithFormat:@"openID: %@, 标题：%@ \n内容：%@ \n附带信息：%@ \n缩略图:%u bytes\n附加消息:%@\n", temp.openID, msg.title, msg.description, obj.extInfo, msg.thumbData.length, msg.messageExt];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
    }
    else if([req isKindOfClass:[LaunchFromWXReq class]])
    {
        LaunchFromWXReq *temp = (LaunchFromWXReq *)req;
        WXMediaMessage *msg = temp.message;
        
        //从微信启动App
        NSString *strTitle = [NSString stringWithFormat:@"从微信启动"];
        NSString *strMsg = [NSString stringWithFormat:@"openID: %@, messageExt:%@", temp.openID, msg.messageExt];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
    }
}

-(void) onResp:(BaseResp*)resp
{
    if([resp isKindOfClass:[SendMessageToWXResp class]])
    {
        NSString *strTitle = [NSString stringWithFormat:@"发送媒体消息结果"];
        NSString *strMsg = [NSString stringWithFormat:@"errcode:%d", resp.errCode];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
    }
    else if([resp isKindOfClass:[SendAuthResp class]])
    {
        SendAuthResp *temp = (SendAuthResp*)resp;
        
        NSString *strTitle = [NSString stringWithFormat:@"Auth结果"];
        NSString *strMsg = [NSString stringWithFormat:@"code:%@,state:%@,errcode:%d", temp.code, temp.state, temp.errCode];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        WX_code = [[NSString alloc] initWithString:temp.code];//保存code
        debugLog(@"WX_code是%@",WX_code);
        [self getWXaccessTokenAndopenId];
    }
    else if ([resp isKindOfClass:[AddCardToWXCardPackageResp class]])
    {
        AddCardToWXCardPackageResp* temp = (AddCardToWXCardPackageResp*)resp;
        NSMutableString* cardStr = [[NSMutableString alloc] init];
        for (WXCardItem* cardItem in temp.cardAry) {
            [cardStr appendString:[NSString stringWithFormat:@"cardid:%@ cardext:%@ cardstate:%lu\n",cardItem.cardId,cardItem.extMsg,cardItem.cardState]];
        }
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"add card resp" message:cardStr delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
    }
}
#pragma mark - 获取用户微信信息
- (void)getWXaccessTokenAndopenId{
    //https://api.weixin.qq.com/sns/oauth2/access_token?appid=APPID&secret=SECRET&code=CODE&grant_type=authorization_code
    //https://api.weixin.qq.com/sns/oauth2/access_token?appid=APPID&secret=SECRET&code=CODE&grant_type=authorization_code
    NSString *url =[NSString stringWithFormat:@"https://api.weixin.qq.com/sns/oauth2/access_token?appid=%@&secret=%@&code=%@&grant_type=authorization_code",WXAppkey,WXSecretKey,WX_code];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL *zoneUrl = [NSURL URLWithString:url];
        NSString *zoneStr = [NSString stringWithContentsOfURL:zoneUrl encoding:NSUTF8StringEncoding error:nil];
        NSData *data = [zoneStr dataUsingEncoding:NSUTF8StringEncoding];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (data) {
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                /*
                 {
                 "access_token" = "OezXcEiiBSKSxW0eoylIeJDUKD6z6dmr42JANLPjNN7Kaf3e4GZ2OncrCfiKnGWiusJMZwzQU8kXcnT1hNs_ykAFDfDEuNp6waj-bDdepEzooL_k1vb7EQzhP8plTbD0AgR8zCRi1It3eNS7yRyd5A";
                 "expires_in" = 7200;
                 openid = oyAaTjsDx7pl4Q42O3sDzDtA7gZs;
                 "refresh_token" = "OezXcEiiBSKSxW0eoylIeJDUKD6z6dmr42JANLPjNN7Kaf3e4GZ2OncrCfiKnGWi2ZzH_XfVVxZbmha9oSFnKAhFsS0iyARkXCa7zPu4MqVRdwyb8J16V8cWw7oNIff0l-5F-4-GJwD8MopmjHXKiA";
                 scope = "snsapi_userinfo,snsapi_base";
                 }
                 */
                
                WX_access_token = [dic objectForKey:@"access_token"];
                WX_openid = [dic objectForKey:@"openid"];
                debugLog(@"微信access_token是%@",WX_access_token);
                debugLog(@"微信openId是%@",WX_openid);
                [self getUserInfo];
            }
        });
    });
}
#pragma mark - 获取用户信息
-(void)getUserInfo
{
    // https://api.weixin.qq.com/sns/userinfo?access_token=ACCESS_TOKEN&openid=OPENID
    
    NSString *url =[NSString stringWithFormat:@"https://api.weixin.qq.com/sns/userinfo?access_token=%@&openid=%@",WX_access_token,WX_openid];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL *zoneUrl = [NSURL URLWithString:url];
        NSString *zoneStr = [NSString stringWithContentsOfURL:zoneUrl encoding:NSUTF8StringEncoding error:nil];
        NSData *data = [zoneStr dataUsingEncoding:NSUTF8StringEncoding];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (data) {
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                /*
                 {
                 city = Haidian;
                 country = CN;
                 headimgurl = "http://wx.qlogo.cn/mmopen/FrdAUicrPIibcpGzxuD0kjfnvc2klwzQ62a1brlWq1sjNfWREia6W8Cf8kNCbErowsSUcGSIltXTqrhQgPEibYakpl5EokGMibMPU/0";
                 language = "zh_CN";
                 nickname = "xxx";
                 openid = oyAaTjsDx7pl4xxxxxxx;
                 privilege =     (
                 );
                 province = Beijing;
                 sex = 1;
                 unionid = oyAaTjsxxxxxxQ42O3xxxxxxs;
                 }
                 */
                
//                self.nickname.text = [dic objectForKey:@"nickname"];
//                self.wxHeadImg.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[dic objectForKey:@"headimgurl"]]]];
                NSLog(@"用户的微信个人信息是%@",dic);
                //上传微信信息
                [self uploadWXinfo:dic];
                
            }
        });
        
    });
}
#pragma mark - //上传微信信息
- (void)uploadWXinfo:(NSDictionary*)dictionary{
//    NSMutableDictionary *entityIn =[NSMutableDictionary dictionary];
//    [entityIn setObject:[dictionary objectForKey:@"city"] forKey:@"city"];
//    [entityIn setObject:[dictionary objectForKey:@"country"] forKey:@"country"];
//    [entityIn setObject:[dictionary objectForKey:@"headimgurl"] forKey:@"headimgurl"];
//    [entityIn setObject:[dictionary objectForKey:@"language"] forKey:@"language"];
//    [entityIn setObject:[dictionary objectForKey:@"nickname"] forKey:@"nickname"];
//    [entityIn setObject:[dictionary objectForKey:@"openid"] forKey:@"openid"];
//    [entityIn setObject:[dictionary objectForKey:@"privilege"] forKey:@"privilege"];
//    [entityIn setObject:[dictionary objectForKey:@"province"] forKey:@"province"];
//    [entityIn setObject:[dictionary objectForKey:@"sex"] forKey:@"sex"];
//    [entityIn setObject:[dictionary objectForKey:@"unionid"] forKey:@"unionid"];
    
    //
    NSMutableDictionary *entity =[[NSMutableDictionary alloc] init];
    [entity setObject:@"wx" forKey:@"type"];
    [entity setObject:dictionary forKey:@"entity"];
    
    NSMutableDictionary *entDict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:entity, @"entity", nil];
    NSString * url = [APP_SERVER stringByAppendingString:HTTP_sourceLogin];
//    [NSURL URLWithString:url]
    
    [CoreHttp postUrl:url params:entDict success:^(id obj) {
        //成功
        debugLog(@"成功%@",obj);
        NSDictionary *dicO = [NSJSONSerialization JSONObjectWithData:obj options:NSJSONReadingMutableContainers error:nil];
        if([dicO objectForKey:@"err"]==0){
            
//            [self saveUserInfo:[obj objectForKey:@"data"]];
            
            //保存个人信息
            BOOL set = [self saveUserInfo:[obj objectForKey:@"data"]];
            if (set) {
                //保存已经登录全局变量
                [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"isLogin"];
                //登录页隐藏，显示tab页
                [self gotoMainPage];
            }else{
                debugLog(@"登录失败");
            }

        }
        
    } errorBlock:^(CoreHttpErrorType errorType) {
        //失败
        debugLog(@"失败%d",errorType);
        
    }];
    
}

- (BOOL)saveUserInfo:(NSDictionary*)dictionary{
    if (dictionary==nil) {
        return NO;
    }
    User *myself = [[User alloc] init];
    myself.hostID = (NSInteger)[dictionary objectForKey:@"uId"];
    myself.user_name = [[dictionary objectForKey:@"entity"] objectForKey:@"name"];
    myself.user_nickname = [[dictionary objectForKey:@"entity"] objectForKey:@"nickname"];
    myself.user_headimgurl = [[dictionary objectForKey:@"entity"] objectForKey:@"headimgurl"];
    myself.user_mobile = [[dictionary objectForKey:@"entity"] objectForKey:@"mobile"];
    myself.user_email = [[dictionary objectForKey:@"entity"] objectForKey:@"email"];
    [User save:myself];
    
    return NO;
}
@end
