//
//  DDPopArrowView.h
//  DoorDuSDKDemo
//
//  Created by 刘和东 on 2018/1/31.
//  Copyright © 2018年 DoorDu. All rights reserved.
//

#import <UIKit/UIKit.h>


#pragma mark - 背景
typedef NS_ENUM(NSUInteger, DDPopArrowViewBackgroundStyle) {
    DDPopArrowViewBackgroundStyleDefault = 0, // 默认风格, 透明
    DDPopArrowViewBackgroundStyleDark, // 黑色风格
};


@interface DDPopArrowView : UIView

/** 背景风格 默认 DDPopArrowViewBackgroundStyleDefault */
@property (nonatomic,assign) DDPopArrowViewBackgroundStyle backgroundStyle;

+ (instancetype)popViewWithContentView:(UIView *)contentView withStyle:(DDPopArrowViewBackgroundStyle)style;

+ (instancetype)popViewWithContentView:(UIView *)contentView withStyle:(DDPopArrowViewBackgroundStyle)style showFromPoint:(CGPoint)fromPoint superView:(UIView *)superView;

+ (instancetype)popViewWithContentView:(UIView *)contentView withStyle:(DDPopArrowViewBackgroundStyle)style showFromView:(UIView *)fromView superView:(UIView *)superView;

+ (instancetype)popViewWithContentView:(UIView *)contentView;

+ (instancetype)popViewWithContentView:(UIView *)contentView showFromPoint:(CGPoint)fromPoint superView:(UIView *)superView;

+ (instancetype)popViewWithContentView:(UIView *)contentView showFromView:(UIView *)fromView superView:(UIView *)superView;


- (void)showFromView:(UIView *)fromView superView:(UIView *)superView;

- (void)showFromPoint:(CGPoint)fromPoint superView:(UIView *)superView;

/** 隐藏 */
- (void)dismiss;

/** 隐藏 */
- (void)dismissComplete:(void (^)(void))complete;


@end
