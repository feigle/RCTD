//
//  UIColor+DDTools.h
//  DoorDu
//
//  Created by 刘和东 on 2017/12/5.
//  Copyright © 2017年 深圳市多度科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

#ifndef ColorHex
#define ColorHex(_hex_)   [UIColor colorWithHexString:((__bridge NSString *)CFSTR(#_hex_))]
#endif

@interface UIColor (DDTools)

/**  @"0xF0F", @"66ccff", @"#66CCFF88" */
+ (UIColor *)colorWithHexString:(NSString *)hexStr;

/**  @"0xF0F", @"66ccff", @"#66CCFF88" alpha透明度*/
+ (UIColor *)colorWithHexString:(NSString *)hexStr alpha:(CGFloat)alpha;


/** 用图片生产UIColor */
+ (UIColor *)colorWithImage:(UIImage *)image;

/** 图片名字生成图片 */
+ (UIColor *)colorWithImageName:(NSString *)imageName;


/** 给当前颜色设置 alpha */
- (UIColor *)colorAlpha:(CGFloat)alpha;



@end
