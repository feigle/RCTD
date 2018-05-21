//
//  NSLayoutConstraint+DDAutoLayout.h
//  DoorDuOEM
//
//  Created by 刘和东 on 2018/3/23.
//  Copyright © 2018年 深圳市多度科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+DDAutoLayout.h"

@interface NSLayoutConstraint (DDAutoLayout)

/** 获取 可以使用 addConstraint 的 view */
- (UIView *)getAddConstraintView:(id)toItem;

@property (nonatomic, weak) UIView * layout_constraintView;

/** 移除当前 NSLayoutConstraint*/
- (void)autoLayoutRemove;

@end
