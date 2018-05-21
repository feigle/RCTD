//
//  DDPhotoImageView.h
//  DDPhotoBrowser
//
//  Created by 刘和东 on 2015/5/21.
//  Copyright © 2015年 刘和东. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DDPhotoItem.h"
#import "DDImageViewEngine.h"

#define kDDPhotoBrowserAnimationTime 0.33


NS_ASSUME_NONNULL_BEGIN


@interface DDPhotoImageView : UIScrollView

@property (nonatomic,strong) UIImageView *imageView;
@property (nonatomic,strong) DDPhotoItem * item;
/**用于解决手势冲突*/
@property (nonatomic,strong) UITapGestureRecognizer *doubleGestureRecognizer;
@property (nonatomic,weak) id<DDPhotoImageDownloadEngine> imageDownloadEngine;
@property (nonatomic,weak) UIPanGestureRecognizer * panGesture;
/**初始化*/
- (instancetype)initWithFrame:(CGRect)frame imageDownloadEngine:(id<DDPhotoImageDownloadEngine>)imageDownloadEngine imageViewEngineType:(DDImageViewEngineType)imageViewEngineType;

- (instancetype)initWithFrame:(CGRect)frame imageViewEngineType:(DDImageViewEngineType)imageViewEngineType;

/**取消图片请求*/
- (void)cancelImageRequest;

@end

NS_ASSUME_NONNULL_END
