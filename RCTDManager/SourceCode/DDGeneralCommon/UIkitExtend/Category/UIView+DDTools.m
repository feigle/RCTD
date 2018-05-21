//
//  UIView+DDTools.m
//  DoorDu
//
//  Created by 刘和东 on 2017/11/16.
//  Copyright © 2017年 深圳市多度科技有限公司. All rights reserved.
//

#import "UIView+DDTools.h"
#import <objc/runtime.h>

static char const keyDDToolsViewClickedHandle;


@implementation UIView (DDTools)

/** 给view增加点击事件，返回点击的当前view */
- (void)addClickedHandle:(DDToolsViewClickedHandleBlock)clickedBlock
{
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(DDToolsViewClickedHandle:)];
    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:tap];
    if (clickedBlock) {
        objc_setAssociatedObject(self, &keyDDToolsViewClickedHandle, clickedBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    }
}
- (void)DDToolsViewClickedHandle:(UITapGestureRecognizer *)sender
{
    DDToolsViewClickedHandleBlock clickedHandleBlock = objc_getAssociatedObject(self, &keyDDToolsViewClickedHandle);
    if (clickedHandleBlock) {
        clickedHandleBlock(sender.view);
    }
}

@end
