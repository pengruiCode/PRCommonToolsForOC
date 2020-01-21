//
//  HUDIndicatorTools.h
//  CommunityPeople
//
//  Created by 彭睿 on 2019/7/23.
//  Copyright © 2019 彭睿. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#define DEFHUDIndicator = [HUDIndicatorTools sharedInstance]

@interface HUDIndicatorTools : NSObject

/**
 *  单例
 */
+ (HUDIndicatorTools *)sharedInstance;

/**
 弹出状态栏网络小菊花
 */
+ (void)ShowNetworkActivityIndicator;

+ (void)HideNetworkActivityIndicator;


/**
 弹出小菊花加载动画
 @param text 描述
 */
+ (void)ShowHUDText:(NSString *)text;

+ (void)HideHUD;


/**
 弹出底部提示文字
 @param text 内容
 */
+ (void)ShowToastText:(NSString *)text;

/**
 弹出系统自带提示窗，无操作
 @param title 标题
 @param message 描述
 */
+ (void)ShowAlertTitle:(NSString *)title message:(NSString *)message;

@end

NS_ASSUME_NONNULL_END
