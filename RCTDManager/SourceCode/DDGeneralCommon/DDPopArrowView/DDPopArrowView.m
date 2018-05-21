//
//  DDPopArrowView.m
//  DoorDuSDKDemo
//
//  Created by 刘和东 on 2018/1/31.
//  Copyright © 2018年 DoorDu. All rights reserved.
//


@interface UIView (DDPopArrowViewFrame)

@property (nonatomic,assign) CGPoint ddorigin;
@property (nonatomic,assign) CGSize ddsize;
@property (nonatomic,readonly) CGPoint ddbottomLeft;
@property (nonatomic,readonly) CGPoint ddbottomRight;
@property (nonatomic,readonly) CGPoint ddtopRight;
@property (nonatomic,assign) CGFloat ddheight;
@property (nonatomic,assign) CGFloat ddwidth;
@property (nonatomic,assign) CGFloat ddtop;
@property (nonatomic,assign) CGFloat ddleft;
@property (nonatomic,assign) CGFloat ddbottom;
@property (nonatomic,assign) CGFloat ddright;
@property (nonatomic,assign) CGFloat ddx;
@property (nonatomic,assign) CGFloat ddy;
@property (nonatomic,assign) CGFloat ddcenterX;
@property (nonatomic,assign) CGFloat ddcenterY;

@end


#import "DDPopArrowView.h"

// 把 degrees 转成 radians
float DDPopArrowViewDegreesToRadians(float angle) {
    return angle*M_PI/180;
}


@interface DDPopArrowView ()

/** 展示内容的view*/
@property (nonatomic, weak) UIView * contentView;

/** 遮罩层*/
@property (nonatomic, strong) UIView * maskView;

/** 边距*/
@property (nonatomic, assign) CGFloat popViewMargin;

/** 箭头的高度*/
@property (nonatomic, assign) CGFloat popViewArrowHeight;

/** 箭头的宽度*/
@property (nonatomic, assign) CGFloat popViewArrowWidth;

/** 箭头的圆角Radius（顶尖处）*/
@property (nonatomic, assign) CGFloat arrowCornerRadius;

/** 箭头与正方体连接处圆角Radius（顶尖处）*/
@property (nonatomic, assign) CGFloat arrowJoinCornerRadius;

/** 整个内容的圆角Radius*/
@property (nonatomic, assign) CGFloat contentCornerRadius;

@end

@implementation DDPopArrowView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self __setupBaseSet];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self __setupBaseSet];
    }
    return self;
}

+ (instancetype)popViewWithContentView:(UIView *)contentView withStyle:(DDPopArrowViewBackgroundStyle)style
{
    if (!contentView) {
        return nil;
    }
    DDPopArrowView * popView = [[DDPopArrowView alloc] init];
    popView.contentView = contentView;
    popView.backgroundStyle = style;
    return popView;
}

+ (instancetype)popViewWithContentView:(UIView *)contentView withStyle:(DDPopArrowViewBackgroundStyle)style showFromPoint:(CGPoint)fromPoint superView:(UIView *)superView
{
    if (!contentView) {
        return nil;
    }
    if (!superView) {
        return nil;
    }
    DDPopArrowView * popView = [[DDPopArrowView alloc] init];
    popView.contentView = contentView;
    popView.backgroundStyle = style;
    [popView showFromPoint:fromPoint superView:superView];
    return popView;
}

+ (instancetype)popViewWithContentView:(UIView *)contentView withStyle:(DDPopArrowViewBackgroundStyle)style showFromView:(UIView *)fromView superView:(UIView *)superView
{
    if (!contentView) {
        return nil;
    }
    if (!fromView) {
        return nil;
    }
    if (!superView) {
        return nil;
    }
    CGRect fromViewRect = [superView convertRect:fromView.frame fromView:fromView.superview];
    CGPoint fromViewCenterPoint = CGPointMake(CGRectGetMidX(fromViewRect), CGRectGetMaxY(fromViewRect));
    return [self popViewWithContentView:contentView withStyle:style showFromPoint:fromViewCenterPoint superView:superView];
}

+ (instancetype)popViewWithContentView:(UIView *)contentView
{
    DDPopArrowView * popView = [[DDPopArrowView alloc] init];
    popView.contentView = contentView;
    return popView;
}

+ (instancetype)popViewWithContentView:(UIView *)contentView showFromPoint:(CGPoint)fromPoint superView:(UIView *)superView
{
    DDPopArrowView * popView = [[DDPopArrowView alloc] init];
    popView.contentView = contentView;
    [popView showFromPoint:fromPoint superView:superView];
    return popView;
}

+ (instancetype)popViewWithContentView:(UIView *)contentView showFromView:(UIView *)fromView superView:(UIView *)superView
{
    if (!contentView) {
        return nil;
    }
    if (!fromView) {
        return nil;
    }
    if (!superView) {
        return nil;
    }
    CGRect fromViewRect = [superView convertRect:fromView.frame fromView:fromView.superview];
    CGPoint fromViewCenterPoint = CGPointMake(CGRectGetMidX(fromViewRect), CGRectGetMaxY(fromViewRect));
    return [self popViewWithContentView:contentView showFromPoint:fromViewCenterPoint superView:superView];
}

- (void)__setupBaseSet
{
    self.backgroundStyle = DDPopArrowViewBackgroundStyleDefault;
    /** 箭头的高度*/
    self.popViewArrowHeight = 11.f;
    self.popViewArrowWidth = 26.f;
    self.contentCornerRadius = 4.f;
    /** 箭头的圆角Radius（顶尖处）*/
    self.arrowCornerRadius = 1.5f;
    self.arrowJoinCornerRadius = 3.f;
    self.popViewMargin = 10.0;
    self.backgroundColor = [UIColor whiteColor];
}

- (void)showFromView:(UIView *)fromView superView:(UIView *)superView
{
    if (!superView) {
        return;
    }
    CGRect fromViewRect = [superView convertRect:fromView.frame fromView:fromView.superview];
    CGPoint fromViewCenterPoint = CGPointMake(CGRectGetMidX(fromViewRect), CGRectGetMaxY(fromViewRect));
    [self showFromPoint:fromViewCenterPoint superView:superView];
}

- (void)showFromPoint:(CGPoint)fromPoint superView:(UIView *)superView
{
    if (!superView) {
        return;
    }
    self.maskView.frame = superView.frame;
    /** 判断箭头是否向上 */
    BOOL arrowDirectionUp = (superView.ddheight - (fromPoint.y + self.contentView.ddheight + self.popViewArrowHeight+self.popViewMargin)) > 0;
    
    // 如果箭头指向的点过于偏左或者过于偏右则需要重新调整箭头 x 轴的坐标
    CGFloat minHorizontalEdge = self.popViewMargin + self.contentCornerRadius + self.popViewArrowWidth/2;
    if (fromPoint.x < minHorizontalEdge) {
        fromPoint.x = minHorizontalEdge;
    }
    if (superView.ddwidth - fromPoint.x < minHorizontalEdge) {
        fromPoint.x = superView.ddwidth - minHorizontalEdge;
    }
    self.contentView.layer.masksToBounds = YES;
    self.contentView.layer.cornerRadius = self.contentCornerRadius;
    self.contentView.ddx = 1;
    self.contentView.ddtop = arrowDirectionUp?(self.popViewArrowHeight+1):1;
    
#pragma mark - 宽度
    CGFloat currentWidth = (self.contentView.ddwidth>(superView.ddwidth-self.popViewMargin*2)?(superView.ddwidth-self.popViewMargin*2):self.contentView.ddwidth)+2;
#pragma mark - 高度
    CGFloat currentHeight = self.contentView.ddheight+self.popViewArrowHeight+2;
    CGFloat maxHeight = arrowDirectionUp?(superView.ddheight-self.popViewMargin):(fromPoint.y);
    if (currentHeight > maxHeight) {
        currentHeight = maxHeight;
        self.contentView.ddheight = currentHeight;
    }
    CGFloat currentX = fromPoint.x-currentWidth/2.0;
    CGFloat currentY = arrowDirectionUp?fromPoint.y:(fromPoint.y-currentHeight-_popViewArrowHeight);
    
    // x: 窗口靠左
    if (fromPoint.x <= currentWidth/2 + self.popViewMargin) {
        currentX = self.popViewMargin;
    }
    // x: 窗口靠右
    if (superView.ddwidth - fromPoint.x <= currentWidth/2 + self.popViewMargin) {
        currentX = superView.ddwidth - self.popViewMargin - currentWidth;
    }
    
    self.frame = CGRectMake(currentX, currentY, currentWidth, currentHeight);

    // 截取箭头
    CGPoint arrowPoint = CGPointMake(fromPoint.x - CGRectGetMinX(self.frame), arrowDirectionUp ? 0 : currentHeight); // 箭头顶点在当前视图的坐标
    
    CGFloat maskTop = arrowDirectionUp ? self.popViewArrowHeight : 0; // 顶部Y值
    CGFloat maskBottom = arrowDirectionUp ? currentHeight : currentHeight - self.popViewArrowHeight; // 底部Y值
    
#pragma mark - UIBezierPath 路线
    UIBezierPath *maskPath = [UIBezierPath bezierPath];
    // 左上圆角
    [maskPath moveToPoint:CGPointMake(0, self.contentCornerRadius + maskTop)];
    [maskPath addArcWithCenter:CGPointMake(self.contentCornerRadius, self.contentCornerRadius + maskTop)
                        radius:self.contentCornerRadius
                    startAngle:DDPopArrowViewDegreesToRadians(180)
                      endAngle:DDPopArrowViewDegreesToRadians(270)
                     clockwise:YES];
    if (arrowDirectionUp) {
        // 箭头向上时的箭头位置
        [maskPath addLineToPoint:CGPointMake(arrowPoint.x - self.popViewArrowWidth/2, self.popViewArrowHeight)];
        [maskPath addQuadCurveToPoint:CGPointMake(arrowPoint.x - self.arrowCornerRadius, self.arrowCornerRadius)
                         controlPoint:CGPointMake(arrowPoint.x - self.popViewArrowWidth/2 + self.arrowJoinCornerRadius, self.popViewArrowHeight)];
        [maskPath addQuadCurveToPoint:CGPointMake(arrowPoint.x + self.arrowCornerRadius, self.arrowCornerRadius)
                         controlPoint:arrowPoint];
        [maskPath addQuadCurveToPoint:CGPointMake(arrowPoint.x + self.popViewArrowWidth/2, self.popViewArrowHeight)
                         controlPoint:CGPointMake(arrowPoint.x + self.popViewArrowWidth/2 - self.arrowJoinCornerRadius, self.popViewArrowHeight)];
    }
    // 右上圆角
    [maskPath addLineToPoint:CGPointMake(currentWidth - self.contentCornerRadius, maskTop)];
    [maskPath addArcWithCenter:CGPointMake(currentWidth - self.contentCornerRadius, maskTop + self.contentCornerRadius)
                        radius:self.contentCornerRadius
                    startAngle:DDPopArrowViewDegreesToRadians(270)
                      endAngle:DDPopArrowViewDegreesToRadians(0)
                     clockwise:YES];
    // 右下圆角
    [maskPath addLineToPoint:CGPointMake(currentWidth, maskBottom - self.contentCornerRadius)];
    [maskPath addArcWithCenter:CGPointMake(currentWidth - self.contentCornerRadius, maskBottom - self.contentCornerRadius)
                        radius:self.contentCornerRadius
                    startAngle:DDPopArrowViewDegreesToRadians(0)
                      endAngle:DDPopArrowViewDegreesToRadians(90)
                     clockwise:YES];
    
    if (!arrowDirectionUp) {
        [maskPath addLineToPoint:CGPointMake(arrowPoint.x + self.popViewArrowWidth/2, currentHeight - self.popViewArrowHeight)];
        [maskPath addQuadCurveToPoint:CGPointMake(arrowPoint.x + self.arrowCornerRadius, currentHeight - self.arrowCornerRadius)
                         controlPoint:CGPointMake(arrowPoint.x + self.popViewArrowWidth/2 - self.arrowJoinCornerRadius, currentHeight - self.popViewArrowHeight)];
        [maskPath addQuadCurveToPoint:CGPointMake(arrowPoint.x - self.arrowCornerRadius, currentHeight - self.arrowCornerRadius)
                         controlPoint:arrowPoint];
        [maskPath addQuadCurveToPoint:CGPointMake(arrowPoint.x - self.popViewArrowWidth/2, currentHeight - self.popViewArrowHeight)
                         controlPoint:CGPointMake(arrowPoint.x - self.popViewArrowWidth/2 + self.arrowJoinCornerRadius, currentHeight - self.popViewArrowHeight)];
    }
    // 左下圆角
    [maskPath addLineToPoint:CGPointMake(self.contentCornerRadius, maskBottom)];
    [maskPath addArcWithCenter:CGPointMake(self.contentCornerRadius, maskBottom - self.contentCornerRadius)
                        radius:self.contentCornerRadius
                    startAngle:DDPopArrowViewDegreesToRadians(90)
                      endAngle:DDPopArrowViewDegreesToRadians(180)
                     clockwise:YES];
    [maskPath addLineToPoint:CGPointMake(0, self.contentCornerRadius + maskTop)];

#pragma mark -  设置 截取圆角和箭头
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
    
#pragma mark - 添加边框
    CAShapeLayer * borderLayer = [CAShapeLayer layer];
    borderLayer.lineWidth = 2;
    borderLayer.frame = self.bounds;
    borderLayer.path = maskPath.CGPath;
    borderLayer.strokeColor = [UIColor colorWithRed:0.91 green:0.91 blue:0.91 alpha:1.00].CGColor;
    borderLayer.fillColor = [UIColor whiteColor].CGColor;
    [self.layer addSublayer:borderLayer];

#pragma mark - 添加view
    [superView addSubview:self.maskView];
    [superView addSubview:self];
    [self addSubview:self.contentView];
    [self bringSubviewToFront:self.contentView];
    // 弹出动画
    CGRect oldFrame = self.frame;
    self.layer.anchorPoint = CGPointMake(arrowPoint.x/currentWidth, arrowDirectionUp ? 0.f : 1.f);
    self.frame = oldFrame;
    self.transform = CGAffineTransformMakeScale(0.01f, 0.01f);
    [UIView animateWithDuration:0.25f animations:^{
        self.transform = CGAffineTransformIdentity;
        self.maskView.alpha = 1.f;
    }];

}

#pragma mark - 隐藏消失
/** 隐藏 */
- (void)dismiss
{
    [self dismissComplete:nil];
}

/** 隐藏 */
- (void)dismissComplete:(void (^)(void))complete
{
    [UIView animateWithDuration:0.25f animations:^{
        self.alpha = 0.f;
        self.maskView.alpha = 0.f;
        self.transform = CGAffineTransformMakeScale(0.01f, 0.01f);
    } completion:^(BOOL finished) {
        if (finished) {
            [self.maskView removeFromSuperview];
            [self.contentView removeFromSuperview];
            [self removeFromSuperview];
            if (complete) {
                complete();
            }
        }
    }];
}

- (void)setBackgroundStyle:(DDPopArrowViewBackgroundStyle)backgroundStyle
{
    _backgroundStyle = backgroundStyle;
    self.maskView.backgroundColor = backgroundStyle == DDPopArrowViewBackgroundStyleDark?[UIColor colorWithWhite:0.f alpha:0.2f]:[UIColor clearColor];
}
#pragma mark - 懒加载
- (UIView *)maskView
{
    if (!_maskView) {
        _maskView = [[UIView alloc] init];
        _maskView.alpha = 0;
        _maskView.userInteractionEnabled = YES;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
        [_maskView addGestureRecognizer:tap];
    }
    return _maskView;
}


- (void)dealloc
{
    NSLog(@"dealloc:%@",NSStringFromClass([self class]));
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end


@implementation UIView (DDPopArrowViewFrame)

- (CGPoint)ddorigin
{
    return self.frame.origin;
}

- (void)setDdorigin:(CGPoint)aPoint
{
    CGRect newframe = self.frame;
    newframe.origin = aPoint;
    self.frame = newframe;
}

- (CGSize)ddsize
{
    return self.frame.size;
}

- (void)setDdsize:(CGSize)aSize
{
    CGRect newframe = self.frame;
    newframe.size = aSize;
    self.frame = newframe;
}

- (CGPoint)ddbottomRight
{
    CGFloat x = self.frame.origin.x + self.frame.size.width;
    CGFloat y = self.frame.origin.y + self.frame.size.height;
    return CGPointMake(x, y);
}

- (CGPoint)ddbottomLeft
{
    CGFloat x = self.frame.origin.x;
    CGFloat y = self.frame.origin.y + self.frame.size.height;
    return CGPointMake(x, y);
}

- (CGPoint)ddtopRight
{
    CGFloat x = self.frame.origin.x + self.frame.size.width;
    CGFloat y = self.frame.origin.y;
    return CGPointMake(x, y);
}

- (CGFloat)ddheight
{
    return self.frame.size.height;
}

- (void)setDdheight:(CGFloat)newheight
{
    CGRect newframe = self.frame;
    newframe.size.height = newheight;
    self.frame = newframe;
}

- (CGFloat)ddwidth
{
    return self.frame.size.width;
}

- (void)setDdwidth:(CGFloat)newwidth
{
    CGRect newframe = self.frame;
    newframe.size.width = newwidth;
    self.frame = newframe;
}

- (CGFloat)ddtop
{
    return self.frame.origin.y;
}

- (void)setDdtop:(CGFloat)newtop
{
    CGRect newframe = self.frame;
    newframe.origin.y = newtop;
    self.frame = newframe;
}

- (CGFloat)ddleft
{
    return self.frame.origin.x;
}

- (void)setDdleft:(CGFloat)newleft
{
    CGRect newframe = self.frame;
    newframe.origin.x = newleft;
    self.frame = newframe;
}

- (CGFloat)ddbottom
{
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setDdbottom:(CGFloat)newbottom
{
    CGRect newframe = self.frame;
    newframe.origin.y = newbottom - self.frame.size.height;
    self.frame = newframe;
}

- (CGFloat)ddright
{
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setDdright:(CGFloat)newright
{
    CGFloat delta = newright - (self.frame.origin.x + self.frame.size.width);
    CGRect newframe = self.frame;
    newframe.origin.x += delta ;
    self.frame = newframe;
}


- (void)setDdcenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}
- (CGFloat)ddcenterX
{
    return self.center.x;
}
- (void)setDdcenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}
- (CGFloat)ddcenterY
{
    return self.center.y;
}
- (CGFloat)ddx
{
    return self.frame.origin.x;
}
- (void)setDdx:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}
- (CGFloat)ddy
{
    return self.frame.origin.y;
}
- (void)setDdy:(CGFloat)y{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

@end

