//
//  UIViewController+DDAutoLayout.m
//  DoorDuOEM
//
//  Created by 刘和东 on 2018/4/11.
//  Copyright © 2018年 深圳市多度科技有限公司. All rights reserved.
//

#import "UIViewController+DDAutoLayout.h"

@implementation DDAutoLayoutAttribute

- (instancetype)initWithView:(UIView *)view item:(id)item
{
    self = [super init];
    if (self) {
        _view = view;
        _item = item;
    }
    return self;
}

@end

@implementation UIViewController (DDAutoLayout)

- (DDAutoLayoutAttribute *)layout_topLayoutGuide
{
    return [[DDAutoLayoutAttribute alloc] initWithView:self.view item:self.topLayoutGuide];
}

- (DDAutoLayoutAttribute *)layout_bottomLayoutGuide
{
    return [[DDAutoLayoutAttribute alloc] initWithView:self.view item:self.bottomLayoutGuide];
}

@end
