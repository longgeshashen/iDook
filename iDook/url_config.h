//
//  url_config.h
//  iDook
//
//  Created by sunshilong on 15/7/28.
//  Copyright (c) 2015年 sunshilong. All rights reserved.
//

#ifndef iDook_url_config_h
#define iDook_url_config_h

#pragma mark ----服务器地址----
//#define APP_SERVER @"http://192.168.30.227/"     //晓前
#define APP_SERVER  @"http://wx.crm.idook.cn/"   //生产

#define myHostId  @"myHostId"

#pragma mark ----1、登录----
//第三方登录
#define HTTP_sourceLogin @"v1/outside?eventType=outer.user.third.login"

#pragma mark ----2、动态----

//动态发布和更新
#define HTTP_dynamicMod @"v1/outside?eventType=outer.dynamic.mod"
//获取某个动态
#define HTTP_dynamicGet @"v1/outside?eventType=outer.dynamic.get"
//获取动态详情
#define HTTP_dynamicDetailGet @"v1/outside?eventType=outer.dynamic.view.get"
//获取动态列表
#define HTTP_getDynamicList @"v1/outside?eventType=outer.dynamic.list"


#pragma mark ----3、线索----

//获取线索列表
#define HTTP_getContactList @"v1/outside?eventType=outer.contact.list"
//线索详情
#define HTTP_contactDetail @"v1/outside?eventType=outer.contact.dtl"
//线索编辑
#define HTTP_contactMod @"v1/outside?eventType=outer.contact.mod"
//线索关系列表
#define HTTP_contactRelationList @"v1/outside?eventType=outer.contact.relation.list"

#pragma mark ----4、动态操作记录----

//别人对我的动态操作记录列表
#define HTTP_news_tome_getList @"v1/outside?eventType=outer.news.tome.get.list"
//我的操作记录
#define HTTP_news_meto_getList @"v1/outside?eventType=outer.news.meto.get.list"

#pragma mark ----5、个人信息----
//获取个人资料
#define HTTP_getUserInfo @"v1/outside?eventType=outer.user.info.get"
//修改个人信息
#define HTTP_changeUserInfo @"v1/outside?eventType=outer.user.info.mod"

#endif
