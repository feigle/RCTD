//
//  DDScreenFitter.m
//  刘和东
//
//  Created by 刘和东 on 2014/12/21.
//  Copyright © 2014年 刘和东. All rights reserved.
//

#import "DDScreenFitter.h"

@implementation DDScreenFitter

/**创建一个单例*/
+ (instancetype)sharedDDScreenFitter
{
    static dispatch_once_t onceToken;
    static DDScreenFitter * _sharedDDScreenFitter;
    dispatch_once(&onceToken, ^{
        _sharedDDScreenFitter = [[DDScreenFitter alloc] init];
    });
    return _sharedDDScreenFitter;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupData];
    }
    return self;
}

- (void)setupData
{
    //    568  320  iphone5
    //iphone6  375  667
    //iphone6P 414  736
    //iphone8  375  667
    //iphoneX  375  812  34 44
    
    CGFloat screenBoundsWidth = [[UIScreen mainScreen ] bounds].size.width;
    CGFloat screenBoundsHeight = [[UIScreen mainScreen ] bounds].size.height;
    
    _autoSize6PScaleX = screenBoundsWidth/414.0;
    
    _autoSize6PScaleY = screenBoundsHeight/736.0;
    
    _autoSize6ScaleX = screenBoundsWidth/375.0;
    
    _autoSize6ScaleY = screenBoundsHeight/667.0;
    
    _font6pScale = 1;
    _font6Scale = 1;
    
    if (screenBoundsWidth <= 320.0 && screenBoundsHeight <= 568.0) {
        _font6Scale = 0.9;
        _font6pScale = 2/3.0-0.1;
    } else if (screenBoundsWidth < 414.0 && screenBoundsHeight < 736.0 ) {//小于6p的屏幕
        _font6pScale = 2/3.0;
    } else {//大于等于6p的屏幕
        _font6Scale = 1.1;
    }
    NSLog(@"font6pScale :%lf",_font6Scale);
}

@end


