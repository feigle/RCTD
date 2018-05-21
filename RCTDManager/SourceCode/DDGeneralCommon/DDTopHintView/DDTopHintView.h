//
//  DDTopHintView.h
//  DoorDuOEM
//
//  Created by 刘和东 on 2018/4/6.
//  Copyright © 2018年 深圳市多度科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

/** 顶部提示框view */
@interface DDTopHintView : UIView

/** 提示文字 */
@property (nonatomic, strong) NSString * hintText;

/** 字体大小 36/2.0 */
@property (nonatomic, strong) UIFont * titleFont;

/** 字体颜色,默认颜色  [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1/1.0]; */
@property (nonatomic, strong) UIColor * titleColor;

/** 失败提示 */
- (void)showFailure:(NSString *)hintText fromView:(UIView *)fromView;

/** 普通与成功提示 */
- (void)show:(NSString *)hintText fromView:(UIView *)fromView;

#pragma mark - 类方法
/** 失败提示 */
+ (void)showFailure:(NSString *)hintText fromView:(UIView *)fromView;

/** 普通与成功提示 */
+ (void)show:(NSString *)hintText fromView:(UIView *)fromView;

/** 失败提示 */
+ (void)showFailure:(NSString *)hintText;

/** 普通与成功提示 */
+ (void)show:(NSString *)hintText;


@end
