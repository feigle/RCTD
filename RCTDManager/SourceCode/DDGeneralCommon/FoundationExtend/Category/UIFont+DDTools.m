//
//  UIFont+DDTools.m
//  刘和东
//
//  Created by 刘和东 on 2017/12/19.
//  Copyright © 2017年 刘和东. All rights reserved.
//

#import "UIFont+DDTools.h"
#import <objc/runtime.h>

@implementation UIFont (DDTools)

//+ (void)load {
//    Method newMethod = class_getClassMethod([self class], @selector(_adjustFont:));
//    Method method = class_getClassMethod([self class], @selector(systemFontOfSize:));
//    method_exchangeImplementations(newMethod, method);
//}
//
//+ (UIFont *)_adjustFont:(CGFloat)fontSize {
//    UIFont *newFont = nil;
//    CGFloat screenBoundsWidth = [UIScreen mainScreen].bounds.size.width;
//
//    /** 以iPhone 6 宽度比 为基准 缩放 */
//    CGFloat screenWidthRatio = screenBoundsWidth/375.0;
//
//#pragma mark - 也可以根据不同的手机 字体的缩放 比例不同
////    /** iPhone 5 */
////    if (([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)) {
////        screenWidthRatio = 0.9;
////    }
////    /** iPhone 6 */
////    if (([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)) {
////        screenWidthRatio = 1;
////    }
////    /** iPhone 6plus */
////    if (([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)) {
////        screenWidthRatio = 1.1;
////    }
////    /** iPhone X */
////    if (([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)) {
////        screenWidthRatio = 1.1;
////    }
//
//    newFont = [UIFont _adjustFont:ceilf(fontSize * screenWidthRatio)];
//    return newFont;
//}

@end
