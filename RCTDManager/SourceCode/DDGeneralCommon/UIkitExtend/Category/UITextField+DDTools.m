//
//  UITextField+DDTools.m
//  DoorDu
//
//  Created by 刘和东 on 2017/11/16.
//  Copyright © 2017年 深圳市多度科技有限公司. All rights reserved.
//

#import "UITextField+DDTools.h"

#import <objc/runtime.h>

static void * DDToolsUITextFieldPlaceholderColorKey = &DDToolsUITextFieldPlaceholderColorKey;


@implementation UITextField (DDTools)

- (void)setplaceholderColor:(UIColor *)placeholderColor
{
    objc_setAssociatedObject(self, &DDToolsUITextFieldPlaceholderColorKey, placeholderColor, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self setValue:placeholderColor forKeyPath:@"_placeholderLabel.textColor"];
}

- (UIColor *)placeholderColor
{
    return objc_getAssociatedObject(self, &DDToolsUITextFieldPlaceholderColorKey);
}

@end
