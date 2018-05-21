//
//  DDCountdownButton.m
//  DoorDuOEM
//
//  Created by 刘和东 on 2018/4/9.
//  Copyright © 2018年 深圳市多度科技有限公司. All rights reserved.
//

#import "DDCountdownButton.h"

@interface DDCountdownButton ()
{
    dispatch_source_t _timer;
}

@end

@implementation DDCountdownButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self _setupData];
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self _setupData];
    }
    return self;
}

- (void)_setupData
{
    self.countdownTime = 60;
    self.isStopTimer = NO;
    self.layer.masksToBounds = YES;
    self.layer.borderWidth = 1;
    self.layer.cornerRadius = 3;
//    [self addTarget:self action:@selector(_countDownClicked) forControlEvents:UIControlEventTouchUpInside];
    self.contentEdgeInsets = UIEdgeInsetsMake(5, 0, 5, 0);
}

- (void)_countDownClicked
{
    [self start];
}

/** 正常的文字 */
- (void)setNormalTitle:(NSString *)normalTitle
{
    _normalTitle = normalTitle;
    [self setTitle:normalTitle forState:UIControlStateNormal];
    [self layoutIfNeeded];
}
/** 正常的颜色 */
- (void)setNormalColor:(UIColor *)normalColor
{
    _normalColor = normalColor;
    if (!_normalBorderColor) {//为空的时候设置下
        self.normalBorderColor = normalColor;
    }
    [self setTitleColor:normalColor forState:UIControlStateNormal];
}
/** 选中的颜色 */
- (void)setSelectedColor:(UIColor *)selectedColor
{
    _selectedColor = selectedColor;
    if (!_selectedBorderColor) {//为空的时候设置下
        self.selectedBorderColor = selectedColor;
    }
    [self setTitleColor:selectedColor forState:UIControlStateSelected];
}

- (void)setNormalBorderColor:(UIColor *)normalBorderColor
{
    _normalBorderColor = normalBorderColor;
    self.layer.borderColor = normalBorderColor.CGColor;
}

/** 开始 */
- (void)start
{
    self.isStopTimer = NO;
    [self _start];
}

- (void)_start
{
    __weak typeof(self) weakSelf = self;
    __block NSUInteger timeout= self.countdownTime; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                strongSelf.selected = NO;
                [strongSelf setTitle:strongSelf.normalTitle forState:UIControlStateNormal];
                [strongSelf setTitle:strongSelf.normalTitle forState:UIControlStateSelected];
                strongSelf.userInteractionEnabled = YES;
                [strongSelf layoutIfNeeded];
            });
        }else{
            if (strongSelf.isStopTimer) {
                dispatch_source_cancel(_timer);
                dispatch_async(dispatch_get_main_queue(), ^{
                    strongSelf.selected = NO;
                    [strongSelf setTitle:strongSelf.normalTitle forState:UIControlStateNormal];
                    strongSelf.userInteractionEnabled = YES;
                    [strongSelf layoutIfNeeded];
                });
                return ;
            }
            int seconds = timeout % strongSelf.countdownTime;
            if (seconds == 0) {
                seconds = strongSelf.countdownTime;
            }
            NSString *strTime = [NSString stringWithFormat:@"%d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                strongSelf.selected = YES;
                [strongSelf setTitle:strTime forState:UIControlStateSelected];
                strongSelf.userInteractionEnabled = NO;
                [strongSelf layoutIfNeeded];
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    if (selected) {
        self.layer.borderColor = self.selectedBorderColor.CGColor;
        [self layoutIfNeeded];
    } else {
        self.layer.borderColor = self.normalBorderColor.CGColor;
        [self layoutIfNeeded];
    }
}

/** 结束 */
- (void)stop
{
    self.isStopTimer = YES;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
