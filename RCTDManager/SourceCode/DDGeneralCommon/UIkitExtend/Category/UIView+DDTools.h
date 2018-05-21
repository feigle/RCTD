//
//  UIView+DDTools.h
//  DoorDu
//
//  Created by 刘和东 on 2017/11/16.
//  Copyright © 2017年 深圳市多度科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^DDToolsViewClickedHandleBlock)(id sender);

@interface UIView (DDTools)

/** 给view增加点击事件，返回点击的当前view */
- (void)addClickedHandle:(DDToolsViewClickedHandleBlock)clickedBlock;


@end
