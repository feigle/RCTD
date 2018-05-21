//
//  DDAlertView.m
//  DoorDu
//
//  Created by 刘和东 on 2017/11/15.
//  Copyright © 2017年 深圳市多度科技有限公司. All rights reserved.
//

#import "DDAlertView.h"

@interface BSHUIAlertAction : UIAlertAction

/**增加一个标记*/
@property (nonatomic,assign) NSUInteger tag;

@end

@implementation BSHUIAlertAction
@end


@implementation DDAlertView

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
      clickedBlock:(void (^)(NSInteger index))clickedBlock
{
    /** 初始化UIAlertController */
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title
                                                                   message:message
                                                            preferredStyle:UIAlertControllerStyleAlert];
    if (otherButtons.count) {
        for (NSInteger i = 0; i < otherButtons.count ; i++) {
            NSString * alertTitle = otherButtons[i];
            BSHUIAlertAction * aaction = [BSHUIAlertAction actionWithTitle:alertTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                BSHUIAlertAction * dAction = (BSHUIAlertAction *)action;
                if (clickedBlock) {
                    clickedBlock(dAction.tag);
                }
            }];
            aaction.tag = i;
            [alert addAction:aaction];
        }
    }
    /**弹出*/
    [vc presentViewController:alert animated:YES completion:^ {
    }];
    
}


@end
