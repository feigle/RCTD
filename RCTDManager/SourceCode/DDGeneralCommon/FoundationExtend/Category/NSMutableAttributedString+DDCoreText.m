//
//  NSMutableAttributedString+DDCoreText.m
//  DoorDuOEM
//
//  Created by 刘和东 on 2018/3/29.
//  Copyright © 2018年 深圳市多度科技有限公司. All rights reserved.
//

#import "NSMutableAttributedString+DDCoreText.h"

@implementation NSMutableAttributedString (DDCoreText)

- (NSRange)rangeOfAll {
    return NSMakeRange(0, self.length);
}

- (void)setTextColor:(UIColor *)textColor range:(NSRange)range
{
    [self _setAttribute:NSForegroundColorAttributeName value:textColor range:range];
}

- (void)setTextColor:(UIColor *)textColor
{
    [self setTextColor:textColor range:[self rangeOfAll]];
}

- (void)setFont:(UIFont *)font range:(NSRange)range
{
    [self _setAttribute:NSFontAttributeName value:font range:range];
}

- (void)setFont:(UIFont *)font
{
    [self setFont:font range:[self rangeOfAll]];
}

- (void)setCharacterSpacing:(unichar)characterSpacing
{
    [self setCharacterSpacing:characterSpacing range:[self rangeOfAll]];
}

- (void)setCharacterSpacing:(unichar)characterSpacing range:(NSRange)range
{
    CFNumberRef charSpacingNum =  CFNumberCreate(kCFAllocatorDefault,kCFNumberSInt8Type,&characterSpacing);
    if (charSpacingNum != nil) {
        [self _setAttribute:NSKernAttributeName value:(__bridge id)charSpacingNum range:range];
        CFRelease(charSpacingNum);
    }
}

- (void)setUnderlineStyle:(NSUnderlineStyle)underlineStyle
              underlineColor:(UIColor *)underlineColor
{
    [self setUnderlineStyle:underlineStyle underlineColor:underlineColor range:[self rangeOfAll]];
}

- (void)setUnderlineStyle:(NSUnderlineStyle)underlineStyle
              underlineColor:(UIColor *)underlineColor
                       range:(NSRange)range
{
    [self _setAttribute:NSUnderlineColorAttributeName value:underlineColor range:range];
    [self _setAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInt:(underlineStyle)] range:range];
}

- (void)setLineSpacing:(CGFloat)lineSpacing
{
    [self setLineSpacing:lineSpacing range:[self rangeOfAll]];
}

- (void)setLineSpacing:(CGFloat)lineSpacing range:(NSRange)range
{
    [self enumerateAttribute:NSParagraphStyleAttributeName
                     inRange:range
                     options:kNilOptions
                  usingBlock: ^(NSParagraphStyle* value, NSRange subRange, BOOL *stop) {
                      if (value) {
                          NSMutableParagraphStyle* style = value.mutableCopy;
                          [style setLineSpacing:lineSpacing];
                          [self _setParagraphStyle:style range:subRange];
                      }
                      else {
                          NSMutableParagraphStyle* style = [[NSMutableParagraphStyle alloc] init];
                          [style setLineSpacing:lineSpacing];
                          [self _setParagraphStyle:style range:subRange];
                      }
                  }];
}

- (void)setTextAlignment:(NSTextAlignment)textAlignment
{
    [self setTextAlignment:textAlignment range:[self rangeOfAll]];
}

- (void)setTextAlignment:(NSTextAlignment)textAlignment range:(NSRange)range
{
    [self enumerateAttribute:NSParagraphStyleAttributeName
                     inRange:range
                     options:kNilOptions
                  usingBlock: ^(NSParagraphStyle* value, NSRange subRange, BOOL *stop) {
                      if (value) {
                          NSMutableParagraphStyle* style = value.mutableCopy;
                          [style setAlignment:textAlignment];
                          [self _setParagraphStyle:style range:subRange];
                      }
                      else {
                          NSMutableParagraphStyle* style = [[NSMutableParagraphStyle alloc] init];
                          [style setAlignment:textAlignment];
                          [self _setParagraphStyle:style range:subRange];
                      }
                  }];
}

- (void)setLineBreakMode:(NSLineBreakMode)lineBreakMode
{
    [self setLineBreakMode:lineBreakMode range:[self rangeOfAll]];
}

- (void)setLineBreakMode:(NSLineBreakMode)lineBreakMode range:(NSRange)range
{
    [self enumerateAttribute:NSParagraphStyleAttributeName
                     inRange:range
                     options:kNilOptions
                  usingBlock: ^(NSParagraphStyle* value, NSRange subRange, BOOL *stop) {
                      if (value) {
                          NSMutableParagraphStyle* style = value.mutableCopy;
                          [style setLineBreakMode:lineBreakMode];
                          [self _setParagraphStyle:style range:subRange];
                      }
                      else {
                          NSMutableParagraphStyle* style = [[NSMutableParagraphStyle alloc] init];
                          [style setLineBreakMode:lineBreakMode];
                          [self _setParagraphStyle:style range:subRange];
                      }
                  }];
}

- (void)IntegratingTextAndGraphics:(UIImage *)image imageBound:(CGRect)bound location:(NSUInteger)location
{
    NSTextAttachment *textAttach = [[NSTextAttachment alloc] init];
    textAttach.image = image;
    textAttach.bounds = bound;
    NSAttributedString *imageString = [NSAttributedString attributedStringWithAttachment:textAttach];
    [self insertAttributedString:imageString atIndex:location];
}

#pragma mark - 私有方法
/** 设置行间距 */
- (void)_setParagraphStyle:(NSParagraphStyle *)paragraphStyle range:(NSRange)range {
    [self _setAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:range];
}

/** 设置 */
- (void)_setAttribute:(NSString *)name value:(id)value range:(NSRange)range {
    if (!name || [NSNull isEqual:name]){
        return;
    }
    if (value && ![NSNull isEqual:value]) {
        [self addAttribute:name value:value range:range];
    }else {
        [self removeAttribute:name range:range];
    }
}
/** 删除属性 */
- (void)_removeAttribute:(NSString *)name range:(NSRange)range
{
    if (!name || [NSNull isEqual:name]){
        return;
    }
    [self removeAttribute:name range:range];
}

@end
