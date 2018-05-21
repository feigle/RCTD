//
//  DDPhotoImageView.m
//  DDPhotoBrowser
//
//  Created by 刘和东 on 2015/5/21.
//  Copyright © 2015年 刘和东. All rights reserved.
//

#import "DDPhotoImageView.h"
#import "DDPhotoProgressView.h"

@interface DDPhotoImageView ()<UIScrollViewDelegate,UIGestureRecognizerDelegate>
@property (nonatomic,strong) DDPhotoProgressView *progressView;

/**最多缩放比例*/
@property (nonatomic,assign) CGFloat kMaximumZoomScale;
/**选择显示图片的控件*/
@property (nonatomic,assign) DDImageViewEngineType imageViewEngineType;

@end

@implementation DDPhotoImageView

- (instancetype)initWithFrame:(CGRect)frame imageDownloadEngine:(id<DDPhotoImageDownloadEngine>)imageDownloadEngine imageViewEngineType:(DDImageViewEngineType)imageViewEngineType
{
    self = [super initWithFrame:frame];
    if (self) {
        _imageDownloadEngine = imageDownloadEngine;
        _imageViewEngineType = imageViewEngineType;
        [self __setupPhotoImageView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame imageViewEngineType:(DDImageViewEngineType)imageViewEngineType
{
    self = [super initWithFrame:frame];
    if (self) {
        _imageViewEngineType = imageViewEngineType;
        [self __setupPhotoImageView];
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self __setupPhotoImageView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self __setupPhotoImageView];
    }
    return self;
}

#pragma mark - 初始化基础数据
- (void)__setupPhotoImageView
{
    self.kMaximumZoomScale = 3.0;
    self.bouncesZoom = YES;
    self.maximumZoomScale = self.kMaximumZoomScale;
    self.minimumZoomScale = 1.0;
    self.multipleTouchEnabled = YES;
    self.showsHorizontalScrollIndicator = YES;
    self.showsVerticalScrollIndicator = YES;
    self.delegate = self;
    id<DDImageView> imageView = [DDImageViewEngine getImageViewWith:_imageViewEngineType frame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    _imageView = [imageView getImageView];
    _imageView.contentMode = UIViewContentModeScaleAspectFill;
    _imageView.clipsToBounds = YES;
    _imageView.hidden = YES;
    [self addSubview:_imageView];
    [self __addGestureRecognizers];
    _progressView = [[DDPhotoProgressView alloc] initWithFrame:CGRectMake(0, 0, 70, 70)];
    _progressView.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    _progressView.hidden = YES;
    [self addSubview:_progressView];
    self.userInteractionEnabled = NO;
}

- (void)setItem:(DDPhotoItem *)item
{
    self.userInteractionEnabled = NO;
    self.progressView.hidden = YES;
    _item = item;
    self.imageView.hidden = YES;
    [_imageDownloadEngine cancelImageRequestWithImageView:self.imageView];
    __weak typeof(self) weakSelf = self;
    /**如果原图还没有下载下来，缩略图存在，为了避免缩略图是动图*/
    if (![_imageDownloadEngine imageFromCacheForURL:_item.imageUrl] && _item.thumbImageUrl && [_imageDownloadEngine imageFromCacheForURL:_item.thumbImageUrl]) {
        [_imageDownloadEngine setImageWithImageView:self.imageView imageURL:_item.thumbImageUrl placeholder:nil progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        } finish:^(UIImage * _Nullable image, NSURL * _Nullable url, BOOL success, NSError * _Nullable error) {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            [strongSelf resizeImageView];
        }];
    }
    [_imageDownloadEngine setImageWithImageView:self.imageView imageURL:_item.imageUrl thumbImageUrl:_item.thumbImageUrl placeholder:_item.placeholderImage progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        dispatch_async(dispatch_get_main_queue(), ^{
            if (strongSelf.progressView.hidden) {
                strongSelf.progressView.hidden = NO;
                [strongSelf.progressView startAnimating];
            }
        });
        if (expectedSize > 0 && receivedSize > 0) {
            //            CGFloat progress = (CGFloat)receivedSize / expectedSize;
            //            progress = progress < 0 ? 0 : progress > 1 ? 1 : progress;
            //            NSLog(@"progress: %lf",progress);
        }
    } finish:^(UIImage * _Nullable image, NSURL * _Nullable url, BOOL success, NSError * _Nullable error) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        dispatch_async(dispatch_get_main_queue(), ^{
            if (success) {
                strongSelf.progressView.hidden = YES;
                [strongSelf.progressView stopAnimating];
                strongSelf.item.image = image;
                strongSelf.userInteractionEnabled = YES;
            }
            [strongSelf resizeImageView];
        });
    }];
}
- (void)cancelImageRequest
{
    [_imageDownloadEngine cancelImageRequestWithImageView:self.imageView];
    self.progressView.hidden = YES;
}
#pragma mark - 添加手势
- (void)__addGestureRecognizers
{
    self.delaysContentTouches = NO;
    _doubleGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleHandler:)];
    _doubleGestureRecognizer.numberOfTapsRequired = 2;
    [self addGestureRecognizer:_doubleGestureRecognizer];
}
#pragma mark - 双击的时候
- (void)doubleHandler:(UITapGestureRecognizer *)recognizer
{
    if (_imageView.isAnimating) {
        return;
    }
    if (self.zoomScale == self.minimumZoomScale)
    {
        CGPoint touchPoint = [recognizer locationInView:self.imageView];
        CGFloat newZoomScale = self.maximumZoomScale;
        CGFloat xsize = self.bounds.size.width / newZoomScale;
        CGFloat ysize = self.bounds.size.height / newZoomScale;
        [self zoomToRect:CGRectMake(touchPoint.x - xsize/2, touchPoint.y - ysize/2, xsize, ysize) animated:YES];
    }
    else
    {
        [self setZoomScale:1.0f animated:YES];
    }
}
#pragma mark - 改变图片大小
- (void)resizeImageView {
    _imageView.hidden = YES;
    if (_imageView.image) {
        CGSize imageSize = _imageView.image.size;
        CGFloat width = _imageView.frame.size.width;
        CGFloat height = width * (imageSize.height / imageSize.width);
        CGRect rect = CGRectMake(0, 0, width, height);
        _imageView.frame = rect;
        // If image is very high, show top content.
        if (height <= self.bounds.size.height) {
            _imageView.center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
        } else {
            _imageView.center = CGPointMake(self.bounds.size.width/2, height/2);
        }
    } else {
        CGFloat width = self.frame.size.width;
        _imageView.frame = CGRectMake(0, 0, width, width * 2.0 / 3);
        _imageView.center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
    }
    _imageView.hidden = NO;
    self.contentSize = _imageView.frame.size;
    [self setZoomScale:self.minimumZoomScale animated:NO];
    self.maximumZoomScale = self.kMaximumZoomScale;
    [self setNeedsLayout];
    if (_item.firstShowAnimation) {
        _item.firstShowAnimation = NO;
        CGRect  dsImageRect = _imageView.frame;
        _imageView.frame = _item.sourceViewInWindowRect;
        __weak typeof(self) weakSelf = self;
        _item.sourceView.hidden = YES;
        [UIView animateWithDuration:kDDPhotoBrowserAnimationTime animations:^{
            __strong typeof(weakSelf) strongSelf = weakSelf;
            strongSelf.imageView.frame = dsImageRect;
        } completion:^(BOOL finished) {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            if (finished) {
                strongSelf.item.sourceView.hidden = NO;
            }
        }];
    }
}
- (void)setMinimumZoomScale:(CGFloat)minimumZoomScale
{
    [self setZoomScale:self.minimumZoomScale animated:NO];
}
#pragma mark - ScrollViewDelegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return _imageView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    CGFloat offsetX = (scrollView.bounds.size.width > scrollView.contentSize.width)?
    (scrollView.bounds.size.width - scrollView.contentSize.width) * 0.5 : 0.0;
    CGFloat offsetY = (scrollView.bounds.size.height > scrollView.contentSize.height)?
    (scrollView.bounds.size.height - scrollView.contentSize.height) * 0.5 : 0.0;
    _imageView.center = CGPointMake(scrollView.contentSize.width * 0.5 + offsetX,
                                    scrollView.contentSize.height * 0.5 + offsetY);
}

- (void)dealloc
{
    NSLog(@"dealloc：%@",NSStringFromClass([self class]));
    //删除通知
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
