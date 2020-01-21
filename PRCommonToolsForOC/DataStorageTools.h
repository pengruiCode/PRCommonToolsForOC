//
//  DataStorageTools.h
//  CommunityPeople
//  自定义存储
//  Created by 彭睿 on 2019/7/22.
//  Copyright © 2019 彭睿. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


static NSString * const kUserName = @"kUserName";                                   //用户昵称
static NSString * const kUserId = @"kUserId";                                       //用户ID
static NSString * const kUserToken = @"kUserToken";                                 //用户唯一标识
static NSString * const kUserRefreshToken = @"kUserRefreshToken";                   //用户刷新唯一标识
static NSString * const kUserPhone = @"kUserPhone";                                 //用户手机号
static NSString * const kUserAccount = @"kUserAccount";                             //用户账号
static NSString * const kUserIcon = @"kUserIcon";                                   //用户头像
static NSString * const kUserNGCCircleId = @"kUserNGCCircleId";                     //用户所属邻里圈ID
static NSString * const kUserRegisterTime = @"kUserRegisterTime";                   //用户注册时间
static NSString * const kAppVersion = @"kAppVersion";                               //app版本号
static NSString * const kJPushRegisterId = @"kJPushRegisterId";                     //极光推送注册ID
static NSString * const kWXNickName = @"kWXNickName";                               //用户微信昵称
static NSString * const kWXIcon = @"kWXIcon";                                       //用户微信头像
static NSString * const kWXOpenId = @"kWXOpenId";                                   //用户openid
static NSString * const kAddressLinkmanName = @"kAddressLinkmanName";               //第一次添加地址保存的默认联系人姓名
static NSString * const kAddressLinkmanMobi = @"kAddressLinkmanPhone";              //第一次添加地址保存的默认联系人手机号
static NSString * const kSearchHistory = @"kSearchHistory";                         //搜索历史关键字数组
static NSString * const kLocationCityHistory = @"kLocationCityHistory";             //历史选择城市
static NSString * const kCityList = @"kCityList";                                   //全国城市列表
static NSString * const kShopingCartSelectShopArr = @"kShopingCartSelectShopArr";   //购物车选中的店铺ID数组
static NSString * const kShopingCartSelectGoodsArr = @"kShopingCartSelectGoodsArr"; //购物车选中的商品ID数组
static NSString * const kWiFiClientMac = @"kWiFiClientMac";                         //智慧Wi-Fi第三方返回的Mac地址
static NSString * const kCardIdForSelect = @"kCardIdForSelect";                     //在出示付款码界面选定展示的卡id

static NSString * const kCityCode = @"kCityCode";                                   //当前定位所在城市code
static NSString * const kCityName = @"kCityName";                                   //当前定位所在城市名
static NSString * const kLongitude = @"kLongitude";                                 //当前定位位置经度
static NSString * const kLatitude = @"kLatitude";                                   //当前定位位置纬度

static NSString * const KCityCodeSelect = @"KCityCodeSelect";                       //首页手动选择的所在城市code
static NSString * const kCityNameSelect = @"kCityNameSelect";                       //首页手动选择的所在城市名
static NSString * const kLongitudeSelect = @"kLongitudeSelect";                     //首页手动选择的位置经度
static NSString * const kLatitudeSelect = @"kLatitudeSelect";                       //首页手动选择的位置纬度


@interface DataStorageTools : NSObject


/**
 存储对象到偏好设置
 
 @param object 值
 @param key 键
 */
+ (void)setObject:(id)object forKey:(NSString *)key;


/**
 从沙盒获取自定义对象
 
 @param key 键
 @return  值
 */
+ (id)objectForKey:(NSString *)key;


/**
 存储自定义对象到沙盒
 
 @param object 值
 @param path 文件路径
 */
+ (void)setObjectToArchiver:(id)object forPath:(NSString *)path;


/**
 从沙盒获取自定义对象

 @param path 文件路径
 @return 自定义对象
 */
+ (id)objectForPath:(NSString *)path;


/**
 退出登录清除本地存储数据
 */
+ (void)loginQuitRemoveData;


/**
 清除缓存
 */
+ (void)clearCache;


/**
 缓存大小（kb）
 */
+ (float)readCacheSize;

@end

NS_ASSUME_NONNULL_END
