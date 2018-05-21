//
//  DoorDuHud.h
//  ProjectAssistant
//
//  Created by 刘和东 on 2017/9/26.
//  Copyright © 2017年 深圳市多度科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

/** 提示框 */
@interface DoorDuHud : NSObject

/** 短暂 提示信息 会自动隐藏 */
+ (void)showMessage:(NSString *)message toView:(UIView *)toView animationTime:(NSTimeInterval)animationTime;
+ (void)showMessage:(NSString *)message toView:(UIView *)toView;
+ (void)showMessage:(NSString *)message;

/** 提示成功 */
+ (void)showSuccess:(NSString *)text toView:(UIView *)toView;
/** 提示成功 */
+ (void)showSuccess:(NSString *)text;

/** 不会自动隐藏 ，带有菊花转动*/
+ (void)showStatus:(NSString *)status isNeedMask:(BOOL)isNeedMask toView:(UIView *)toView;
+ (void)showStatus:(NSString *)status isNeedMask:(BOOL)isNeedMask;

/** 隐藏 */
+ (void)hideAnimated:(BOOL)hideAnimated;
/** 隐藏 默认没有动画*/
+ (void)hide;

@end
