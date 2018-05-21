//
//  DDFLAnimatedImageView.m
//  DDPhotoBrowser
//
//  Created by 刘和东 on 2015/5/21.
//  Copyright © 2015年 刘和东. All rights reserved.
//

#import "DDFLAnimatedImageView.h"
#import "FLAnimatedImageView.h"

@interface DDFLAnimatedImageView ()

@property (nonatomic,strong) FLAnimatedImageView * flImageView;

@end

@implementation DDFLAnimatedImageView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super init];
    if (self) {
        _flImageView = [[FLAnimatedImageView alloc] initWithFrame:frame];
        /**滑动的时候暂定动画*/
        _flImageView.runLoopMode = NSDefaultRunLoopMode;
    }
    return self;
}
- (UIImageView *)getImageView
{
    return _flImageView;
}

@end
