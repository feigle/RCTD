//
//  DDPhotoProgressView.m
//  DDPhotoBrowser
//
//  Created by 刘和东 on 2015/5/21.
//  Copyright © 2015年 刘和东. All rights reserved.
//

#import "DDPhotoProgressView.h"

@interface DDPhotoProgressView ()

@property CALayer *sLayer;

@end


@implementation DDPhotoProgressView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
        self.tintColor = [UIColor whiteColor];
        self.layer.cornerRadius = 5;
        self.layer.masksToBounds = YES;
    }
    return self;
}
- (void)startAnimating
{
    if (self.isAnimating) {
        return;
    }
    self.layer.sublayers = nil;
    self.layer.speed = 1.0f;
    self.layer.opacity = 1.0;
    self.isAnimating = YES;
    [self configAnimatin];
}
- (void)stopAnimating
{
    if (self.isAnimating) {
        self.isAnimating = NO;
        [self removeAnimation];
    }
}


- (void)setTintColor:(UIColor *)tintColor
{
    if (_tintColor == tintColor) {
        return;
    }
    _tintColor = tintColor;
    if (self.isAnimating) {
        [self stopAnimating];
        [self startAnimating];
    }
}

- (void)configAnimatin
{
    CAReplicatorLayer *replicatorLayer = [CAReplicatorLayer layer];
    replicatorLayer.frame = CGRectMake(self.frame.size.width/4.0, self.frame.size.width/4.0, self.frame.size.width/2.0, self.frame.size.height/2.0);
    
    replicatorLayer.backgroundColor = [UIColor clearColor].CGColor;
    [self.layer addSublayer:replicatorLayer];

    ///
    self.sLayer = [CALayer layer];
    self.sLayer.bounds = CGRectMake(0, 0, self.frame.size.width/6, self.frame.size.width/6);
    self.sLayer.cornerRadius = self.sLayer.bounds.size.width/2;
    self.sLayer.backgroundColor = self.tintColor.CGColor;
    self.sLayer.transform = CATransform3DMakeScale(0.1, 0.1, 0.1);
    
    [replicatorLayer addSublayer:self.sLayer];
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation.fromValue = @1;
    animation.toValue = @0.1;
    animation.duration = 1.5;
    animation.repeatCount = CGFLOAT_MAX;
    
    [self.sLayer addAnimation:animation forKey:@"animation"];
////
    NSInteger numOfDot = 10;
    replicatorLayer.instanceCount = numOfDot;
    CGFloat angle = (M_PI * 2)/numOfDot;
    replicatorLayer.instanceTransform = CATransform3DMakeRotation(angle, 0, 0, 1);
    replicatorLayer.instanceDelay = 1.5/numOfDot;
}

- (void)removeAnimation{
    [self.sLayer removeAnimationForKey:@"animation"];
    [self.layer removeAllAnimations];
    [self.layer.sublayers makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
}
- (void)dealloc
{
    NSLog(@"dealloc：%@",NSStringFromClass([self class]));
}

@end
