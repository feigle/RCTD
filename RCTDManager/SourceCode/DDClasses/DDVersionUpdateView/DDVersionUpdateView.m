//
//  DDVersionUpdateView.m
//  DoorDuOEM
//
//  Created by 刘和东 on 2018/4/16.
//  Copyright © 2018年 深圳市多度科技有限公司. All rights reserved.
//

#import "DDVersionUpdateView.h"

@interface DDVersionUpdateView ()

@property (nonatomic, strong) UIView * contentView;

/**背景*/
@property (nonatomic, strong) UIView * maskView;

@end


@implementation DDVersionUpdateView

#pragma mark - 界面布局
- (void)setupConfigUI
{
    self.userInteractionEnabled = YES;
    [self addSubview:self.maskView];
    
    [self addSubview:self.contentView];
    
    /** 布局 maskView */
    self.maskView
    .layout_topEqualToSuperview()
    .layout_leftEqualToSuperview()
    .layout_rightEqualToSuperview()
    .layout_bottomEqualToSuperview();
    
    /** 布局 contentView */
    self.contentView
    .layout_left6(95/2.0)
    .layout_right6(-95/2.0)
    .layout_centerY(5);
    
    //title
    UILabel * titleLabel = [[UILabel alloc] init];
    titleLabel.font = font6Size(36/2.0);
    titleLabel.textColor = DDColor333333;
    titleLabel.text = @"发现新版本";
    
    [self.contentView addSubview:titleLabel];
    titleLabel
    .layout_top6(40/2.0)
    .layout_left6(15)
    .layout_right6(-15)
    .layout_height(titleLabel.font.lineHeight);
    
    //图片
    UIImageView * imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"DDVersionUpdateViewImage"]];
    
    [self.contentView addSubview:imageView];
    imageView
    .layout_width6(202/2.0)
    .layout_height6(202/2.0)
    .layout_centerXEqualToSuperview()
    .layout_top6ToItemBottom(titleLabel, 34/2.0);
    
    //版本
    UILabel * versionLabel = [[UILabel alloc] init];
    versionLabel.font = font6Size(28/2.0);
    versionLabel.textColor = DDColor666666;
    versionLabel.text = [NSString stringWithFormat:@"v.%@", self.version];
    
    [self.contentView addSubview:versionLabel];
    
    versionLabel
    .layout_left6(65/2.0)
    .layout_right6(-65/2.0)
    .layout_top6ToItemBottom(imageView, 17/2.0)
    .layout_height(versionLabel.font.lineHeight);
    
    //描述
    UILabel * remarkLabel = [[UILabel alloc] init];
    remarkLabel.font = font6Size(28/2.0);
    remarkLabel.numberOfLines = 0;
    remarkLabel.textColor = DDColor666666;
    remarkLabel.text = [NSString stringWithFormat:@"%@", self.remark];
    
    [self.contentView addSubview:remarkLabel];
    
    remarkLabel
    .layout_left6(65/2.0)
    .layout_right6(-65/2.0)
    .layout_top6ToItemBottom(versionLabel, 10/2.0);
    
    //版本升级
    UIButton * versionButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [versionButton setTitle:@"升级版本" forState:UIControlStateNormal];
    [versionButton setTitleColor:DDColorFFFFFF forState:UIControlStateNormal];
    versionButton.titleLabel.font = font6Size(32/2.0);
    versionButton.backgroundColor = DDColorB39575;
    versionButton.layer.cornerRadius = DDAdapter6Height(88/2.0)/2;
    versionButton.layer.masksToBounds = YES;
    [versionButton addTarget:self action:@selector(_versinUpdateClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:versionButton];
    
    versionButton
    .layout_left6(65/2.0)
    .layout_right6(-65/2.0)
    .layout_top6ToItemBottom(remarkLabel, 34/2.0)
    .layout_height6(88/2.0)
    .layout_bottom6(-55/2.0);
    
    /** 升级类型；0-手动升级 1-自动升级 2-强制升级 */
    if ([[self.level toString]integerValue] != 2) {
        //白色关闭页面
        UIButton * closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [closeButton setImage:[UIImage imageNamed:@"白色关闭页面"] forState:UIControlStateNormal];
        [closeButton addTarget:self action:@selector(_dismiss) forControlEvents:UIControlEventTouchUpInside];
        [closeButton sizeToFit];
        [self addSubview:closeButton];
        
        closeButton
        .layout_centerXEqualToSuperview()
        .layout_top6ToItemBottom(self.contentView, 80/2.0);
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(_dismiss)];
        [self.maskView addGestureRecognizer:tap];
    }
    
}

- (void)_versinUpdateClicked
{
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:self.download_url]]) {
        if ([UIDevice currentDevice].systemVersion.floatValue< 10.0) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.download_url]];
        }else {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.download_url] options:@{} completionHandler:^(BOOL success) {}];
        }
        /** 升级类型；0-手动升级 1-自动升级 2-强制升级 */
        if ([[self.level toString]integerValue] != 2) {
            [self _dismiss];
        }
    } else {
        [self _dismiss];
    }
}

#pragma mark - 懒加载
- (UIView *)contentView
{
    if (!_contentView) {
        _contentView = [[UIView alloc] init];
        _contentView.backgroundColor = DDColorFFFFFF;
        _contentView.userInteractionEnabled = YES;
        _contentView.layer.cornerRadius = 4;
        _contentView.layer.masksToBounds = YES;
    }
    return _contentView;
}
- (UIView *)maskView
{
    if (!_maskView) {
        _maskView = [[UIView alloc] initWithFrame:CGRectZero];
        _maskView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
        _maskView.userInteractionEnabled = YES;
        //        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(_dismiss)];
        //        [_maskView addGestureRecognizer:tap];
    }
    return _maskView;
}


/** 弹出 */
- (void)showFromView:(UIView *)fromView
{
    if ([self.download_url toString].length == 0) {
        return;
    }
    if (![[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:self.download_url]]) {
        return;
    }
    [fromView addSubview:self];
    CGRect fromViewBounds = fromView.bounds;
    self.frame = fromViewBounds;
    self.userInteractionEnabled = YES;
    self.maskView.userInteractionEnabled = NO;
    self.alpha = 0;
    [UIView animateWithDuration:0.25 animations:^{
        self.alpha = 1;
    } completion:^(BOOL finished) {
        self.maskView.userInteractionEnabled = YES;;
    }];
}

- (void)_dismiss
{
    self.maskView.userInteractionEnabled = NO;
    [UIView animateWithDuration:0.2 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [self removeFromSuperview];
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
