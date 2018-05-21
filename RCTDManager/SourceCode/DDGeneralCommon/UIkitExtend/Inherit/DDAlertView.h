//
//  DDAlertView.h
//  DoorDu
//
//  Created by 刘和东 on 2017/11/15.
//  Copyright © 2017年 深圳市多度科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DDAlertView : NSObject

/**
 * vc：弹出的控制器
 * title：标题
 * message：内容
 * otherButtons：点击按钮数组，按照数组顺序，按钮从上向下拍
 * clickedBlock：返回点击了第几个，按照数组顺序,从 0 开始
 */
+ (void)showWithVC:(UIViewController *)vc
             title:(NSString *)title
           message:(NSString *)message
  otherButtonTitle:(NSArray *)otherButtons
      clickedBlock:(void (^)(NSInteger index))clickedBlock;


@end
