//
//  DDTopHintView.m
//  DoorDuOEM
//
//  Created by 刘和东 on 2018/4/6.
//  Copyright © 2018年 深圳市多度科技有限公司. All rights reserved.
//

#import "DDTopHintView.h"

@interface DDTopHintView ()

/** 提示文字文本 */
@property (nonatomic, strong) UILabel * hintTitleLabel;

/** 最上面高出的部分 */
@property (nonatomic, assign) CGFloat topHeight;

/** 提示的图片 */
@property (nonatomic, strong) UIImageView * hintImageView;

//@property (nonatomic, assign) UIStatusBarStyle statusBarStyle;

@end

@implementation DDTopHintView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self _configUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self _configUI];
    }
    return self;
}

/** 如果为空，默认为 [[UIApplication sharedApplication].delegate window] */
- (void)_showFromView:(UIView *)fromView
{
    if (!fromView) {
        fromView = [[UIApplication sharedApplication].delegate window];
    }
    [fromView addSubview:self];
    self.frame = CGRectMake(self.frame.origin.x, -self.frame.size.height, self.frame.size.width, self.frame.size.height);
    [UIView animateWithDuration:0.8f
                          delay:0
         usingSpringWithDamping:0.5f
          initialSpringVelocity:12.0f
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         self.frame = CGRectMake(self.frame.origin.x, -self.topHeight, self.frame.size.width, self.frame.size.height);
                     }
                     completion:^(BOOL finished) {
                         [UIView animateWithDuration:0.2 delay:1.0 options:UIViewAnimationOptionCurveLinear animations:^{
                             self.frame = CGRectMake(self.frame.origin.x, -self.frame.size.height, self.frame.size.width, self.frame.size.height);
                         } completion:^(BOOL finished) {
                             [self removeFromSuperview];
                         }];
                     }];
}

- (void)setTitleFont:(UIFont *)titleFont
{
    _titleFont = titleFont;
    self.hintTitleLabel.font = titleFont;
}

- (void)setTitleColor:(UIColor *)titleColor
{
    _titleColor = titleColor;
    self.hintTitleLabel.textColor = titleColor;
}

- (void)setHintText:(NSString *)hintText
{
    _hintText = hintText;
    self.hintTitleLabel.text = hintText;
}

#pragma mark - 界面布局
- (void)_configUI
{
    self.topHeight = 30;
    self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIApplication sharedApplication].statusBarFrame.size.height + 44 + self.topHeight);
    
    self.backgroundColor = [UIColor whiteColor];
    
    [self addSubview:self.hintTitleLabel];
    [self addSubview:self.hintImageView];
    
    self.hintTitleLabel.frame = CGRectMake(15+ 20 + 10, [UIApplication sharedApplication].statusBarFrame.size.height+self.topHeight, [UIScreen mainScreen].bounds.size.width-(15+ 20 + 10 + 15), 44);
    
    self.hintImageView.frame = CGRectMake(15, [UIApplication sharedApplication].statusBarFrame.size.height+self.topHeight + (44 - 20)/2.0, 20, 20);
    
}

#pragma mark 懒加载
/** 提示文字文本 */
- (UILabel *)hintTitleLabel
{
    if (!_hintTitleLabel) {
        _hintTitleLabel = [[UILabel alloc] init];
        _hintTitleLabel.font = [UIFont systemFontOfSize:36/2.0];
        _hintTitleLabel.numberOfLines = 2;
//        _hintTitleLabel.textAlignment = NSTextAlignmentCenter;
        _hintTitleLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1/1.0];
    }
    return _hintTitleLabel;
}
/** 提示的图片 */
- (UIImageView *)hintImageView
{
    if (!_hintImageView) {
        _hintImageView = [[UIImageView alloc] init];
        _hintImageView.image = [UIImage imageNamed:@"DDTopHintShowSuccessImage"];
        _hintImageView.frame = CGRectMake(0, 0, 20, 20);
    }
    return _hintImageView;
}


/** 失败提示 */
- (void)showFailure:(NSString *)hintText fromView:(UIView *)fromView
{
    self.hintText = hintText;
    self.backgroundColor =  [UIColor colorWithRed:255/255.0 green:227/255.0 blue:224/255.0 alpha:1/1.0];
    self.hintImageView.image = [UIImage imageNamed:@"DDTopHintShowFailureImage"];
    [self _showFromView:fromView];
}

/** 普通与成功提示 */
- (void)show:(NSString *)hintText fromView:(UIView *)fromView
{
    self.backgroundColor = [UIColor whiteColor];
    self.hintText = hintText;
    self.hintImageView.image = [UIImage imageNamed:@"DDTopHintShowSuccessImage"];
    [self _showFromView:fromView];
}


#pragma mark - 类方法
/** 失败提示 */
+ (void)showFailure:(NSString *)hintText fromView:(UIView *)fromView
{
    DDTopHintView * hintView = [[DDTopHintView alloc] init];
    [hintView showFailure:hintText fromView:fromView];
}

/** 普通与成功提示 */
+ (void)show:(NSString *)hintText fromView:(UIView *)fromView
{
    DDTopHintView * hintView = [[DDTopHintView alloc] init];
    [hintView show:hintText fromView:fromView];
}

/** 失败提示 */
+ (void)showFailure:(NSString *)hintText
{
    DDTopHintView * hintView = [[DDTopHintView alloc] init];
    [hintView showFailure:hintText fromView:nil];
}

/** 普通与成功提示 */
+ (void)show:(NSString *)hintText
{
    DDTopHintView * hintView = [[DDTopHintView alloc] init];
    [hintView show:hintText fromView:nil];
}

- (void)dealloc
{
    NSLog(@"dealloc: %@", NSStringFromClass([self class]));
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
