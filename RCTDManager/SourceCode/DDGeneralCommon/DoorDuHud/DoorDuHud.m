//
//  DoorDuHud.m
//  ProjectAssistant
//
//  Created by 刘和东 on 2017/9/26.
//  Copyright © 2017年 深圳市多度科技有限公司. All rights reserved.
//

#import "DoorDuHud.h"
#import "MBProgressHUD.h"

@implementation DoorDuHud

static MBProgressHUD * progressHUD = nil;

+ (void)showMessage:(NSString *)message toView:(UIView *)toView animationTime:(NSTimeInterval)animationTime
{
    if (toView == nil) toView = [UIApplication sharedApplication].keyWindow;
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:toView animated:YES];
    hud.userInteractionEnabled = NO;
    hud.label.text = message;
    hud.label.numberOfLines = 0;
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    hud.mode = MBProgressHUDModeText;
    hud.label.textColor = [UIColor whiteColor];
    hud.bezelView.backgroundColor = [UIColor blackColor];
    hud.animationType = MBProgressHUDAnimationFade;
    // YES代表需要蒙版效果
    //    hud.dimBackground = YES;
    //    一秒消失
    [hud hideAnimated:YES afterDelay:animationTime];
}

+ (void)showMessage:(NSString *)message toView:(UIView *)toView
{
    [self showMessage:message toView:toView animationTime:1.5];
}

+ (void)showMessage:(NSString *)message
{
    [self showMessage:message toView:nil];
}

/** 提示成功 */
+ (void)showSuccess:(NSString *)text toView:(UIView *)toView
{
    if (toView == nil) toView = [UIApplication sharedApplication].keyWindow;
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:toView animated:YES];
    UIImage *image = [UIImage imageNamed:@"BigWhiteCheckImage"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    hud.customView = imageView;
    hud.userInteractionEnabled = NO;
    hud.label.text = text;
    hud.label.numberOfLines = 0;
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    hud.mode = MBProgressHUDModeCustomView;
    hud.label.textColor = [UIColor whiteColor];
    hud.bezelView.backgroundColor = [UIColor blackColor];
//    hud.bezelView.alpha = 0.8;
    hud.animationType = MBProgressHUDAnimationFade;
    // YES代表需要蒙版效果
    //    hud.dimBackground = YES;
    //    一秒消失
    [hud hideAnimated:YES afterDelay:1.5];
}

+ (void)showSuccess:(NSString *)text
{
    [self showSuccess:text toView:nil];
}

+ (void)showStatus:(NSString *)status isNeedMask:(BOOL)isNeedMask toView:(UIView *)toView
{
    if (progressHUD) {
        [self hideAnimated:NO];
    }
    if (toView == nil) toView = [UIApplication sharedApplication].keyWindow;
    // 快速显示一个提示信息
    [UIActivityIndicatorView appearanceWhenContainedIn:[MBProgressHUD class], nil].color = [UIColor whiteColor];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:toView animated:YES];
//    hud.userInteractionEnabled = NO;
    if (isNeedMask) {
        hud.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    }
    hud.graceTime = 0.1;
    hud.label.text = status;
    hud.label.numberOfLines = 0;
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.label.textColor = [UIColor whiteColor];
    hud.bezelView.backgroundColor = [UIColor blackColor];
    hud.animationType = MBProgressHUDAnimationFade;
    [hud showAnimated:YES];
    progressHUD = hud;
}

+ (void)showStatus:(NSString *)status isNeedMask:(BOOL)isNeedMask
{
    [self showStatus:status isNeedMask:isNeedMask toView:nil];
}

+ (void)hideAnimated:(BOOL)hideAnimated
{
    if (progressHUD) {
        [progressHUD hideAnimated:hideAnimated afterDelay:0];
    }
}
+ (void)hide
{
    [self hideAnimated:YES];
}

@end
