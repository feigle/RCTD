//
//  UIViewController+DDAutoLayout.h
//  DoorDuOEM
//
//  Created by 刘和东 on 2018/4/11.
//  Copyright © 2018年 深圳市多度科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DDAutoLayoutAttribute : NSObject

@property (nonatomic, weak, readonly) UIView * view;

@property (nonatomic, weak, readonly) id item;

- (id)initWithView:(UIView *)view item:(id)item;

@end

@interface UIViewController (DDAutoLayout)

@property (nonatomic, strong, readonly) DDAutoLayoutAttribute * layout_topLayoutGuide;
@property (nonatomic, strong, readonly) DDAutoLayoutAttribute * layout_bottomLayoutGuide;

@end
