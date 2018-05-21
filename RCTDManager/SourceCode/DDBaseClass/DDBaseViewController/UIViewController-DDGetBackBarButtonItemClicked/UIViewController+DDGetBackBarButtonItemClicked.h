//
//  UIViewController+DDGetBackBarButtonItemClicked.h
//  DoorDu
//
//  Created by 刘和东 on 2018/3/21.
//  Copyright © 2018年 深圳市多度科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DDGetBackBarButtonItemClickedProtocol <NSObject>
@optional
-(BOOL)dd_navigationShouldPopOnBackButton;
@end

/** 用于拦截系统的返回按钮点击事件 */
@interface UIViewController (DDGetBackBarButtonItemClicked)<DDGetBackBarButtonItemClickedProtocol>

@end
