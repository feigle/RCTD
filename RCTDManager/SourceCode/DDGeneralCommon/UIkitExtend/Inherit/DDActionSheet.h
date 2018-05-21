//
//  DDActionSheet.h
//  DoorDu
//
//  Created by 刘和东 on 2018/1/24.
//  Copyright © 2018年 DoorDu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DDActionSheet : NSObject

/**
 * vc：弹出的控制器
 * title：标题
 * cancel：取消按钮
 * message：内容
 * otherButtons：点击按钮数组，按照数组顺序，按钮从上向下拍
 * clickedBlock：返回点击了第几个，按照数组顺序,从 0 开始
 */
+ (void)showWithVC:(UIViewController *)vc
             title:(NSString *)title
            cancel:(NSString *)cancel
           message:(NSString *)message
  otherButtonTitle:(NSArray *)otherButtons
      clickedBlock:(void (^)(NSInteger index))clickedBlock;

@end
