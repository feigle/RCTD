//
//  UIView+DDFrame.m
//  刘和东
//
//  Created by 刘和东 on 2014/12/21.
//  Copyright © 2014年 刘和东. All rights reserved.
//

#import "UIView+DDFrame.h"
#import "DDScreenFitter.h"

@implementation UIView (DDFrame)

#pragma mark - 正常情况的大小
- (CGPoint)origin
{
    return self.frame.origin;
}

- (void)setOrigin:(CGPoint)aPoint
{
    CGRect newframe = self.frame;
    newframe.origin = aPoint;
    self.frame = newframe;
}

// Retrieve and set the size
- (CGSize)size
{
    return self.frame.size;
}

- (void)setSize:(CGSize)aSize
{
    CGRect newframe = self.frame;
    newframe.size = aSize;
    self.frame = newframe;
}

// Query other frame locations
- (CGPoint)bottomRight
{
    CGFloat x = self.frame.origin.x + self.frame.size.width;
    CGFloat y = self.frame.origin.y + self.frame.size.height;
    return CGPointMake(x, y);
}

- (CGPoint)bottomLeft
{
    CGFloat x = self.frame.origin.x;
    CGFloat y = self.frame.origin.y + self.frame.size.height;
    return CGPointMake(x, y);
}

- (CGPoint)topRight
{
    CGFloat x = self.frame.origin.x + self.frame.size.width;
    CGFloat y = self.frame.origin.y;
    return CGPointMake(x, y);
}

// Retrieve and set height, width, top, bottom, left, right
- (CGFloat)height
{
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)newheight
{
    CGRect newframe = self.frame;
    newframe.size.height = newheight;
    self.frame = newframe;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)newwidth
{
    CGRect newframe = self.frame;
    newframe.size.width = newwidth;
    self.frame = newframe;
}

- (CGFloat)top
{
    return self.frame.origin.y;
}

- (void)setTop:(CGFloat)newtop
{
    CGRect newframe = self.frame;
    newframe.origin.y = newtop;
    self.frame = newframe;
}

- (CGFloat)left
{
    return self.frame.origin.x;
}

- (void)setLeft:(CGFloat)newleft
{
    CGRect newframe = self.frame;
    newframe.origin.x = newleft;
    self.frame = newframe;
}

- (CGFloat)bottom
{
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setBottom:(CGFloat)newbottom
{
    CGRect newframe = self.frame;
    newframe.origin.y = newbottom - self.frame.size.height;
    self.frame = newframe;
}

- (CGFloat)right
{
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setRight:(CGFloat)newright
{
    CGFloat delta = newright - (self.frame.origin.x + self.frame.size.width);
    CGRect newframe = self.frame;
    newframe.origin.x += delta ;
    self.frame = newframe;
}


- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}
- (CGFloat)centerX
{
    return self.center.x;
}
- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}
- (CGFloat)centerY
{
    return self.center.y;
}
- (CGFloat)x
{
    return self.frame.origin.x;
}
- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}
- (CGFloat)y
{
    return self.frame.origin.y;
}
- (void)setY:(CGFloat)y{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

#pragma mark - iphone6上面的大小

- (CGSize)size6
{
    CGSize size = self.size;
    
    size.width = ceilf(size.width/ddScreenFitter.autoSize6ScaleX);
    size.height = ceilf(size.height/ddScreenFitter.autoSize6ScaleY);
    return size;
}

- (void)setSize6:(CGSize)size6
{
    CGRect newframe = self.frame;
    size6.width = ceilf(size6.width*ddScreenFitter.autoSize6ScaleX);
    size6.height = ceilf(size6.height*ddScreenFitter.autoSize6ScaleY);
    newframe.size = size6;
    self.frame = newframe;
}

- (CGPoint)bottomRight6
{
    CGFloat x = self.frame.origin.x + self.frame.size.width;
    CGFloat y = self.frame.origin.y + self.frame.size.height;
    return CGPointMake(ceilf(x/ddScreenFitter.autoSize6ScaleX), ceilf(y/ddScreenFitter.autoSize6ScaleY));
}
- (CGPoint)bottomLeft6
{
    CGFloat x = self.frame.origin.x;
    CGFloat y = self.frame.origin.y + self.frame.size.height;
    return CGPointMake(ceilf(x/ddScreenFitter.autoSize6ScaleX), ceilf(y/ddScreenFitter.autoSize6ScaleY));
}
- (CGPoint)topRight6
{
    CGFloat x = self.frame.origin.x + self.frame.size.width;
    CGFloat y = self.frame.origin.y;
    return CGPointMake(ceilf(x/ddScreenFitter.autoSize6ScaleX), ceilf(y/ddScreenFitter.autoSize6ScaleY));
}
- (CGFloat)height6
{
    return ceilf(self.frame.size.height/ddScreenFitter.autoSize6ScaleY);
}

- (void)setHeight6:(CGFloat)height6
{
    CGRect newframe = self.frame;
    newframe.size.height = ceilf(height6*ddScreenFitter.autoSize6ScaleY);
    self.frame = newframe;
}

- (CGFloat)width6
{
    return ceilf(self.frame.size.width/ddScreenFitter.autoSize6ScaleX);
}

- (void)setWidth6:(CGFloat)width6
{
    CGRect newframe = self.frame;
    newframe.size.width = ceilf(width6*ddScreenFitter.autoSize6ScaleX);
    self.frame = newframe;
}

- (CGFloat)top6
{
    return ceilf(self.frame.origin.y/ddScreenFitter.autoSize6ScaleY);
}

- (void)setTop6:(CGFloat)top6
{
    CGRect newframe = self.frame;
    newframe.origin.y = ceilf(top6*ddScreenFitter.autoSize6ScaleY);
    self.frame = newframe;
}

- (CGFloat)left6
{
    return ceilf(self.frame.origin.x/ddScreenFitter.autoSize6ScaleX);
}

- (void)setLeft6:(CGFloat)left6
{
    CGRect newframe = self.frame;
    newframe.origin.x = ceilf(left6*ddScreenFitter.autoSize6ScaleX);
    self.frame = newframe;
}

- (CGFloat)bottom6
{
    return ceilf((self.frame.origin.y + self.frame.size.height)/ddScreenFitter.autoSize6ScaleY);
}

- (void)setBottom6:(CGFloat)bottom6
{
    CGRect newframe = self.frame;
    newframe.origin.y = ceilf(bottom6*ddScreenFitter.autoSize6ScaleY - self.frame.size.height);
    self.frame = newframe;
}

- (CGFloat)right6
{
    return ceilf((self.frame.origin.x + self.frame.size.width)/ddScreenFitter.autoSize6ScaleX);
}

- (void)setRight6:(CGFloat)right6
{
    CGFloat delta = ceilf(right6*ddScreenFitter.autoSize6ScaleX - (self.frame.origin.x + self.frame.size.width));
    CGRect newframe = self.frame;
    newframe.origin.x += delta ;
    self.frame = newframe;
}


- (CGFloat)centerX6
{
    return ceilf(self.center.x/ddScreenFitter.autoSize6ScaleX);
}

- (void)setCenterX6:(CGFloat)centerX6
{
    CGPoint center = self.center;
    center.x = ceilf(centerX6*ddScreenFitter.autoSize6ScaleX);
    self.center = center;
}

- (CGFloat)centerY6
{
    return ceilf(self.center.y/ddScreenFitter.autoSize6ScaleY);
}

- (void)setCenterY6:(CGFloat)centerY6
{
    CGPoint center = self.center;
    center.y = ceilf(centerY6*ddScreenFitter.autoSize6ScaleY);
    self.center = center;
}

- (CGFloat)x6
{
    return ceilf(self.frame.origin.x/ddScreenFitter.autoSize6ScaleX);
}

- (void)setX6:(CGFloat)x6
{
    CGRect newframe = self.frame;
    newframe.origin.x = ceilf(x6*ddScreenFitter.autoSize6ScaleX);
    self.frame = newframe;
}

- (CGFloat)y6
{
    return ceilf(self.frame.origin.y/ddScreenFitter.autoSize6ScaleY);
}

- (void)setY6:(CGFloat)y6
{
    CGRect newframe = self.frame;
    newframe.origin.y = ceilf(y6*ddScreenFitter.autoSize6ScaleY);
    self.frame = newframe;
}

#pragma mark - iphone6p上面的大小

- (CGSize)size6p
{
    CGSize size = self.size;
    size.width = ceilf(size.width/ddScreenFitter.autoSize6PScaleX);
    size.height = ceilf(size.height/ddScreenFitter.autoSize6PScaleY);
    return size;
}


- (void)setSize6p:(CGSize)size6p
{
    CGRect newframe = self.frame;
    size6p.width = ceilf(size6p.width*ddScreenFitter.autoSize6PScaleX);
    size6p.height = ceilf(size6p.height*ddScreenFitter.autoSize6PScaleY);
    newframe.size = size6p;
    self.frame = newframe;
}

// Query other frame locations
- (CGPoint)bottomRight6p
{
    CGFloat x = self.frame.origin.x + self.frame.size.width;
    CGFloat y = self.frame.origin.y + self.frame.size.height;
    return CGPointMake(ceilf(x/ddScreenFitter.autoSize6PScaleX), ceilf(y/ddScreenFitter.autoSize6PScaleY));
}
- (CGPoint)bottomLeft6p
{
    CGFloat x = self.frame.origin.x;
    CGFloat y = self.frame.origin.y + self.frame.size.height;
    return CGPointMake(ceilf(x/ddScreenFitter.autoSize6PScaleX), ceilf(y/ddScreenFitter.autoSize6PScaleY));
}
- (CGPoint)topRight6p
{
    CGFloat x = self.frame.origin.x + self.frame.size.width;
    CGFloat y = self.frame.origin.y;
    return CGPointMake(ceilf(x/ddScreenFitter.autoSize6PScaleX), ceilf(y/ddScreenFitter.autoSize6PScaleY));
}

- (CGFloat)height6p
{
    return ceilf(self.frame.size.height/ddScreenFitter.autoSize6PScaleY);
}

- (void)setHeight6p:(CGFloat)height6p
{
    CGRect newframe = self.frame;
    newframe.size.height = ceilf(height6p*ddScreenFitter.autoSize6ScaleY);
    self.frame = newframe;
}

- (CGFloat)width6p
{
    return ceilf(self.frame.size.width/ddScreenFitter.autoSize6PScaleX);
}
- (void)setWidth6p:(CGFloat)width6p
{
    CGRect newframe = self.frame;
    newframe.size.width = ceilf(width6p*ddScreenFitter.autoSize6PScaleX);
    self.frame = newframe;
}
- (CGFloat)top6p
{
    return ceilf(self.frame.origin.y/ddScreenFitter.autoSize6PScaleY);
}
- (void)setTop6p:(CGFloat)top6p
{
    CGRect newframe = self.frame;
    newframe.origin.y = ceilf(top6p*ddScreenFitter.autoSize6PScaleY);
    self.frame = newframe;
}

- (CGFloat)left6p
{
    return ceilf(self.frame.origin.x/ddScreenFitter.autoSize6PScaleX);
}
- (void)setLeft6p:(CGFloat)left6p
{
    CGRect newframe = self.frame;
    newframe.origin.x = ceilf(left6p*ddScreenFitter.autoSize6ScaleX);
    self.frame = newframe;
}

- (CGFloat)bottom6p
{
    return ceilf((self.frame.origin.y + self.frame.size.height)/ddScreenFitter.autoSize6PScaleY);
}

- (void)setBottom6p:(CGFloat)bottom6p
{
    CGRect newframe = self.frame;
    newframe.origin.y = ceilf(bottom6p*ddScreenFitter.autoSize6ScaleY) - self.frame.size.height;
    self.frame = newframe;
}

- (CGFloat)right6p
{
    return ceilf((self.frame.origin.x + self.frame.size.width)/ddScreenFitter.autoSize6PScaleX);
}

- (void)setRight6p:(CGFloat)right6p
{
    CGFloat delta = ceilf(right6p*ddScreenFitter.autoSize6ScaleX - (self.frame.origin.x + self.frame.size.width));
    CGRect newframe = self.frame;
    newframe.origin.x += delta ;
    self.frame = newframe;
}

- (CGFloat)centerX6p
{
    return ceilf(self.center.x/ddScreenFitter.autoSize6PScaleX);
}

- (void)setCenterX6p:(CGFloat)centerX6p
{
    CGPoint center = self.center;
    center.x = ceilf(centerX6p*ddScreenFitter.autoSize6ScaleX);
    self.center = center;
}

- (CGFloat)centerY6p
{
    return ceilf(self.center.y/ddScreenFitter.autoSize6PScaleY);
}

- (void)setCenterY6p:(CGFloat)centerY6p
{
    CGPoint center = self.center;
    center.x = ceilf(centerY6p*ddScreenFitter.autoSize6PScaleY);
    self.center = center;
}

- (CGFloat)x6p
{
    return ceilf(self.frame.origin.x/ddScreenFitter.autoSize6PScaleX);
}
- (void)setX6p:(CGFloat)x6p
{
    CGRect newframe = self.frame;
    newframe.origin.x = ceilf(x6p*ddScreenFitter.autoSize6ScaleX);
    self.frame = newframe;
}

- (CGFloat)y6p
{
    return ceilf(self.frame.origin.y/ddScreenFitter.autoSize6PScaleY);
}

- (void)setY6p:(CGFloat)y6p
{
    CGRect newframe = self.frame;
    newframe.origin.y = ceilf(y6p*ddScreenFitter.autoSize6PScaleY);
    self.frame = newframe;
}

@end

