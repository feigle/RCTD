//
//  DDScreenFitterHeaderHeader.h
//  刘和东
//
//  Created by 刘和东 on 2014/12/21.
//  Copyright © 2014年 刘和东. All rights reserved.
//

#ifndef DDScreenFitterHeaderHeader_h
#define DDScreenFitterHeaderHeader_h

#import "DDScreenFitter.h"
#import "UIView+DDFrame.h"
#import "UIView+DDAutoLayout.h"


/**
 *  iphone6
 */
#define kScreen6Width 375.0
#define kScreen6Height 667.0

#define kScreen6ScaleW  [ddScreenFitter autoSize6ScaleX]
#define kScreen6ScaleH  [ddScreenFitter autoSize6ScaleY]

/**
 *  iphone6Plus
 */
#define kScreen6PScreenWidth 414.0
#define kScreen6PScreenHeight 736.0

#define kScreen6PScaleW  [ddScreenFitter autoSize6PScaleX]
#define kScreen6PScaleH  [ddScreenFitter autoSize6PScaleY]


static inline CGFloat DDAdapter6Width(CGFloat w)
{
    return ceilf(w*ddScreenFitter.autoSize6ScaleX);
}

static inline CGFloat DDAdapter6Height(CGFloat h)
{
    return ceilf(h*ddScreenFitter.autoSize6ScaleY);
}

static inline CGFloat DDAdapter6PWidth(CGFloat w)
{
    return ceilf(w*ddScreenFitter.autoSize6PScaleX);
}

static inline CGFloat DDAdapter6PHeight(CGFloat h)
{
    return ceilf(h*ddScreenFitter.autoSize6PScaleY);
}

/**UI界面是 iphone6 的时候，选择 font6Size*/
static inline UIFont * font6Size(CGFloat fontSize)
{
    return [UIFont systemFontOfSize:ceilf(fontSize*ddScreenFitter.font6Scale)];
}

/**UI界面是 iphone6 ，需要加粗的时候选择 fontBold6Size*/
static inline UIFont * fontBold6Size(CGFloat fontSize)
{
    return [UIFont boldSystemFontOfSize:ceilf(fontSize*ddScreenFitter.font6Scale)];
}

/**UI界面是 iphone6p 的时候，选择 font6pSize*/
static inline UIFont * font6pSize(CGFloat fontSize)
{
    return [UIFont systemFontOfSize:ceilf(fontSize*ddScreenFitter.font6pScale)];
}

/**UI界面是 iphone6p ，需要加粗的时候选择 fontBold6pSize*/
static inline UIFont * fontBold6pSize(CGFloat fontSize)
{
    return [UIFont boldSystemFontOfSize:ceilf(fontSize*ddScreenFitter.font6pScale)];
}

/**
 *  Frame的屏幕适配 ,根据iphone6的尺寸来的
 *  @return 返回当前的屏幕的rect
 */
static inline CGRect CGRectMake6(CGFloat x, CGFloat y, CGFloat width, CGFloat height)
{
    CGRect rect;
    rect.origin.x    = DDAdapter6Width(x);
    rect.origin.y    = DDAdapter6Height(y);
    rect.size.width  = DDAdapter6Width(width);
    rect.size.height = DDAdapter6Height(height);
    return rect;
}

/**
 *  Frame的屏幕适配 ,根据iphone6p的尺寸来的
 *  @return 返回当前的屏幕的rect
 */
static inline CGRect CGRectMake6p(CGFloat x, CGFloat y, CGFloat width, CGFloat height)
{
    CGRect rect;
    rect.origin.x = DDAdapter6PWidth(x);
    rect.origin.y = DDAdapter6PHeight(y);
    rect.size.width = DDAdapter6PWidth(width);
    rect.size.height = DDAdapter6PHeight(height);
    return rect;
}

#endif

