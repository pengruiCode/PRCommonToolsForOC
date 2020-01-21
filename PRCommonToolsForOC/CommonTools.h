//
//  CommonTools.h
//  CommunityPeople
//
//  Created by 彭睿 on 2019/7/19.
//  Copyright © 2019 彭睿. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


typedef void(^returnImage)(UIImage *image);

@interface CommonTools : NSObject


@property (nonatomic,copy) returnImage imageBlock;


/**
 *  获取当前最上层显示的vc
 */
+ (UIViewController *)topViewController;


/**
 *  打电话
 */
+ (void)callTel:(NSString *)tel;


/**
 *  返回具体的手机型号(模拟器除外)
 */
+ (NSString*)iphoneType;


/**
 *  返回具体的手机设备识别码
 */
+ (NSString*)iphoneID;


/**
 *  获取某个字符串中子字符串的位置数组 (字符串中所有的 相同的字)
 *  @param totalString 总的字符串
 *  @param subString   子字符串
 *  @return 位置数组
 */
+ (NSMutableArray *)getRangeWithTotalString:(NSString *)totalString SubString:(NSString *)subString;


@end

NS_ASSUME_NONNULL_END
