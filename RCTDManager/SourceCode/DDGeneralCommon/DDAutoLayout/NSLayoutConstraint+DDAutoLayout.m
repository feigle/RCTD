//
//  NSLayoutConstraint+DDAutoLayout.m
//  DoorDuOEM
//
//  Created by 刘和东 on 2018/3/23.
//  Copyright © 2018年 深圳市多度科技有限公司. All rights reserved.
//

#import "NSLayoutConstraint+DDAutoLayout.h"
#import <objc/runtime.h>

@implementation NSLayoutConstraint (DDAutoLayout)

/** 移除当前 NSLayoutConstraint*/
- (void)autoLayoutRemove
{
    UIView * getView = self.layout_constraintView;
    while (getView && ![getView.constraints containsObject:self]) {
        getView = getView.superview;
    }
    if (getView && [getView.constraints containsObject:self]) {
        [getView removeConstraint:self];
    }
}

- (void)setLayout_constraintView:(UIView *)layout_constraintView
{
    objc_setAssociatedObject(self, @selector(layout_constraintView), layout_constraintView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)layout_constraintView
{
    UIView * view = objc_getAssociatedObject(self, @selector(layout_constraintView));
    return view;
}

#define CLASS_LGUIDE UILayoutGuide

/** 获取 可以使用 addConstraint 的 view */
- (UIView *)getAddConstraintView:(id)toItem
{
    NSAssert(self.firstItem, @"item 为空了....");
    UIView * topView = nil;
    
    if (toItem && [self _ddAutoLayout_firstView] && [toItem isKindOfClass:[DDAutoLayoutAttribute class]]) {
        DDAutoLayoutAttribute * toItemLayout = (DDAutoLayoutAttribute *)toItem;
        topView = [self _getCommonSuperViewWithItemView1:[self _ddAutoLayout_firstView] toItemView2:toItemLayout.view];
    } else if ([self _ddAutoLayout_firstView] && [self _ddAutoLayout_secondView]) {
        topView = [self _getCommonSuperViewWithItemView1:[self _ddAutoLayout_firstView] toItemView2:[self _ddAutoLayout_secondView]];
    } else {
        if (self.firstAttribute == NSLayoutAttributeWidth || self.firstAttribute == NSLayoutAttributeHeight) {
            topView = [self _ddAutoLayout_firstView];
        } else {
            topView = [self _ddAutoLayout_firstView].superview;
        }
    }
    self.layout_constraintView = topView;
    NSAssert(topView, @"不能把 NSLayoutConstraint 添加到(addConstraint) 空的view上面。");
    return topView;
}

#pragma mark - 私有方法
/** 获取self.firstItem 如果不是view 返回nil  */
- (UIView *)_ddAutoLayout_firstView {
    return [self.firstItem isKindOfClass:UIView.class] ? self.firstItem : nil;
}

/** 获取self.secondItem 如果不是view 返回nil */
- (UIView *)_ddAutoLayout_secondView {
    return [self.secondItem isKindOfClass:UIView.class] ? self.secondItem : nil;
}

/** 获取公共的 父视图 */
- (UIView *)_getCommonSuperViewWithItemView1:(UIView *)itemView1 toItemView2:(UIView *)toItemView2 {
    if (itemView1.superview == toItemView2) {
        return toItemView2;
    }
    if (toItemView2.superview == itemView1) {
        return itemView1;
    }
    UIView *commonSuperview = nil;
    UIView *startView = itemView1;
    while (startView) {
        if ([toItemView2 isDescendantOfView:startView]) {
            commonSuperview = startView;
            break;
        }
        startView = startView.superview;
    }
    if (!commonSuperview) {//为空再判断
        startView = toItemView2;
        while (startView) {
            if ([itemView1 isDescendantOfView:startView]) {
                commonSuperview = startView;
                break;
            }
            startView = startView.superview;
        }
    }
    return commonSuperview;
}


@end
