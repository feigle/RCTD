//
//  DDSystemImageView.m
//  DDPhotoBrowser
//
//  Created by 刘和东 on 2015/5/21.
//  Copyright © 2015年 刘和东. All rights reserved.
//

#import "DDSystemImageView.h"

@interface DDSystemImageView ()

@property (nonatomic,strong) UIImageView * imageView;

@end

@implementation DDSystemImageView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super init];
    if (self) {
        _imageView = [[UIImageView alloc] initWithFrame:frame];
    }
    return self;
}
- (UIImageView *)getImageView
{
    return _imageView;
}



@end
