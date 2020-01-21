//
//  HUDIndicatorTools.m
//  CommunityPeople
//
//  Created by 彭睿 on 2019/7/23.
//  Copyright © 2019 彭睿. All rights reserved.
//

#import "HUDIndicatorTools.h"
#import <RMUniversalAlert/RMUniversalAlert.h>
#import <MBProgressHUD/MBProgressHUD.h>
#import <Toast/UIView+Toast.h>

@interface HUDIndicatorTools ()

@end

@implementation HUDIndicatorTools


static MBProgressHUD *_HUD = nil;
static CSToastStyle *_toastStyle = nil;


+ (HUDIndicatorTools *)sharedInstance {
    static HUDIndicatorTools *indicator = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        indicator = [[self alloc] init];
    });
    return indicator;
}

+ (MBProgressHUD *)getHUD {
    if (!_HUD) {
        _HUD = [[MBProgressHUD alloc]initWithView:[UIApplication sharedApplication].keyWindow];
        _HUD.animationType = MBProgressHUDAnimationZoomIn;
        _HUD.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
        _HUD.backgroundColor = UIColor.clearColor;
        [UIActivityIndicatorView appearanceWhenContainedInInstancesOfClasses:@[[MBProgressHUD class]]].color = UIColor.grayColor;
        _HUD.label.textColor = [UIColor colorWithR:64 g:64 b:64 a:1];
        _HUD.label.font = [UIFont systemFontOfSize:13];
        _HUD.detailsLabel.textColor = [UIColor colorWithR:64 g:64 b:64 a:1];
    }
//    _HUD.bezelView.color = UIColor.clearColor;
    return _HUD;
}

+ (CSToastStyle *)getToastStyle {
    if (!_toastStyle) {
        _toastStyle = [[CSToastStyle alloc] initWithDefaultStyle];
        _toastStyle.backgroundColor = [UIColor gray666Color];
    }
    return _toastStyle;
}

+ (void)ShowNetworkActivityIndicator {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}

+ (void)HideNetworkActivityIndicator {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

+ (void)ShowHUDText:(NSString *)text {
    if (text.length > 0) {
        [HUDIndicatorTools getHUD].label.text = text;
        [HUDIndicatorTools getHUD].bezelView.color = UIColor.whiteColor;
    }
    if (!text) {
        [HUDIndicatorTools getHUD].label.text = @"  加载中...  ";
        [HUDIndicatorTools getHUD].bezelView.color = UIColor.whiteColor;
    }
    if ([text isEqualToString:@""]) {
        [HUDIndicatorTools getHUD].label.text = @"";
        [HUDIndicatorTools getHUD].bezelView.color = UIColor.clearColor;
    }
    
    [[UIApplication sharedApplication].keyWindow addSubview:[HUDIndicatorTools getHUD]];
    [[HUDIndicatorTools getHUD] showAnimated:true];
}

+ (void)HideHUD {
    [[HUDIndicatorTools getHUD] hideAnimated:true];
}

+ (void)ShowToastText:(NSString *)text {
    if (!text || text.length == 0) {
        return;
    }
    [[UIApplication sharedApplication].keyWindow makeToast:text duration:1.5 position:CSToastPositionBottom style:[HUDIndicatorTools getToastStyle]];
}

+ (void)ShowAlertTitle:(NSString *)title message:(NSString *)message {
    [RMUniversalAlert showAlertInViewController:[CommonTools topViewController] withTitle:title message:message cancelButtonTitle:@"知道了" destructiveButtonTitle:nil otherButtonTitles:nil tapBlock:^(RMUniversalAlert * _Nonnull alert, NSInteger buttonIndex) {
        
    }];
}

@end
