//
//  DDCountdownButton.h
//  DoorDuOEM
//
//  Created by 刘和东 on 2018/4/9.
//  Copyright © 2018年 深圳市多度科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

/** 倒计时button */
@interface DDCountdownButton : UIButton

/** 正常的文字 */
@property (nonatomic, strong) NSString * normalTitle;

/** 正常的颜色 */
@property (nonatomic, strong) UIColor * normalColor;

/** 选中的颜色 */
@property (nonatomic, strong) UIColor * selectedColor;

/** 正常 边框的 颜色，默认和 当前状态字体颜色一样 */
@property (nonatomic, strong) UIColor * normalBorderColor;

/** 选中 边框的 颜色 默认和 当前状态字体颜色一样 */
@property (nonatomic, strong) UIColor * selectedBorderColor;

/** 倒计时时间，默认 60 */
@property (nonatomic, assign) int countdownTime;

/** 判断时间 是否 停止了 */
@property (nonatomic,assign) BOOL isStopTimer;

/** 开始 */
- (void)start;

/** 结束 */
- (void)stop;

@end
