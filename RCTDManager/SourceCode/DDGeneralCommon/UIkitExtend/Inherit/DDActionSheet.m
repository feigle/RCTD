//
//  DDActionSheet.m
//  DoorDu
//
//  Created by 刘和东 on 2018/1/24.
//  Copyright © 2018年 DoorDu. All rights reserved.
//

#import "DDActionSheet.h"

@interface DDUISheetAction : UIAlertAction

/**增加一个标记*/
@property (nonatomic,assign) NSUInteger tag;

@end
@implementation DDUISheetAction

@end


@implementation DDActionSheet

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
      clickedBlock:(void (^)(NSInteger index))clickedBlock
{
    /** 初始化UIAlertController */
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title
                                                                   message:message
                                                            preferredStyle:UIAlertControllerStyleActionSheet];
    if (cancel) {
        if (cancel.length) {
            
            DDUISheetAction * aaction = [DDUISheetAction actionWithTitle:cancel style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            }];
            [alert addAction:aaction];
        }
    }
    if (otherButtons.count) {
        for (NSInteger i = 0; i < otherButtons.count ; i++) {
            NSString * alertTitle = otherButtons[i];
            DDUISheetAction * aaction = [DDUISheetAction actionWithTitle:alertTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                DDUISheetAction * dAction = (DDUISheetAction *)action;
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
