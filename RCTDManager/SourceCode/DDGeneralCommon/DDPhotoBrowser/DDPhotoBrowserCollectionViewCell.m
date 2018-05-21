//
//  DDPhotoBrowserCollectionViewCell.m
//  DDPhotoBrowser
//
//  Created by 刘和东 on 2015/5/21.
//  Copyright © 2015年 刘和东. All rights reserved.
//

#import "DDPhotoBrowserCollectionViewCell.h"

@interface DDPhotoBrowserCollectionViewCell ()



@end

@implementation DDPhotoBrowserCollectionViewCell

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self configUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}

- (void)configUI
{

}

- (void)setImageDownloadEngine:(id<DDPhotoImageDownloadEngine>)imageDownloadEngine
{
    _imageDownloadEngine = imageDownloadEngine;
    self.imageView.imageDownloadEngine = imageDownloadEngine;
}

- (void)setItem:(DDPhotoItem *)item
{
    _item = item;
    self.imageView.item = item;
}
- (void)setImageViewEngineType:(DDImageViewEngineType)imageViewEngineType
{
    if (_imageViewEngineType == imageViewEngineType) {
        return;
    }
    _imageViewEngineType = imageViewEngineType;
    [_imageView removeFromSuperview];
    _imageView = nil;
    _imageView = [[DDPhotoImageView alloc] initWithFrame:[UIScreen mainScreen].bounds imageViewEngineType:imageViewEngineType];
    [self.contentView addSubview:self.imageView];
}

- (void)dealloc
{
    NSLog(@"dealloc：%@",NSStringFromClass([self class]));
}

@end
