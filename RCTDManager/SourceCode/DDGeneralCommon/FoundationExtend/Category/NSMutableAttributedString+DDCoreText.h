//
//  NSMutableAttributedString+DDCoreText.h
//  DoorDuOEM
//
//  Created by 刘和东 on 2018/3/29.
//  Copyright © 2018年 深圳市多度科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableAttributedString (DDCoreText)

/**
 范围
 
 @return NSMakeRange(0, self.length)
 */
- (NSRange)rangeOfAll;

/**
 设置文本颜色，范围NSMakeRange(0, self.length)
 
 @param textColor 文本颜色
 */
- (void)setTextColor:(UIColor *)textColor;

/**
 设置文本颜色
 
 @param textColor 文本颜色
 @param range 范围
 */
- (void)setTextColor:(UIColor *)textColor range:(NSRange)range;

/**
 *  设置文本字体，范围NSMakeRange(0, self.length)
 *
 *  @param font  字体
 */
- (void)setFont:(UIFont *)font;

/**
 *  设置文本字体
 *
 *  @param font  字体
 *  @param range 范围
 */
- (void)setFont:(UIFont *)font range:(NSRange)range;

/**
 *  设置字间距，范围NSMakeRange(0, self.length)
 *
 *  @param characterSpacing 字间距
 */
- (void)setCharacterSpacing:(unichar)characterSpacing;

/**
 *  设置字间距
 *
 *  @param characterSpacing 字间距
 *  @param range            范围
 */
- (void)setCharacterSpacing:(unichar)characterSpacing range:(NSRange)range;

/**
 *  设置下划线样式和颜色，范围NSMakeRange(0, self.length)
 *
 *  @param underlineStyle 下划线样式
 *  @param underlineColor 下划线颜色
 */
- (void)setUnderlineStyle:(NSUnderlineStyle)underlineStyle
              underlineColor:(UIColor *)underlineColor;

/**
 *  设置下划线样式和颜色
 *
 *  @param underlineStyle 下划线样式
 *  @param underlineColor 下划线颜色
 *  @param range          范围
 */
- (void)setUnderlineStyle:(NSUnderlineStyle)underlineStyle
              underlineColor:(UIColor *)underlineColor
                       range:(NSRange)range;

#pragma mark - ParagraphStyle

/**
 *  设置行间距
 *
 *  @param lineSpacing 行间距，范围NSMakeRange(0, self.length)
 */
- (void)setLineSpacing:(CGFloat)lineSpacing;

/**
 *  设置行间距
 *
 *  @param lineSpacing 行间距
 *  @param range       范围
 */
- (void)setLineSpacing:(CGFloat)lineSpacing range:(NSRange)range;

/**
 *  设置文本水平对齐方式，范围NSMakeRange(0, self.length)
 *
 *  @param textAlignment 文本对齐方式
 */
- (void)setTextAlignment:(NSTextAlignment)textAlignment;

/**
 *  设置文本水平对齐方式
 *
 *  @param textAlignment 文本对齐方式
 *  @param range         范围
 */
- (void)setTextAlignment:(NSTextAlignment)textAlignment range:(NSRange)range;

/**
 *  设置文本换行方式，范围NSMakeRange(0, self.length)
 *
 *  @param lineBreakMode 换行方式
 */
- (void)setLineBreakMode:(NSLineBreakMode)lineBreakMode;

/**
 *  设置文本换行方式
 *
 *  @param lineBreakMode 换行方式
 *  @param range         范围
 */
- (void)setLineBreakMode:(NSLineBreakMode)lineBreakMode range:(NSRange)range;

/**
 设置图文混排

 @param image 图片
 @param bound 图片大小、位置
 @param location 图片插入文本位置
 */
- (void)IntegratingTextAndGraphics:(UIImage *)image imageBound:(CGRect)bound location:(NSUInteger)location;

@end
