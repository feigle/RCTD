//
//  DDPhotoItem.m
//  DDPhotoBrowser
//
//  Created by 刘和东 on 2015/5/21.
//  Copyright © 2015年 刘和东. All rights reserved.
//

#import "DDPhotoItem.h"
#if __has_include("DDPhotoSDImageDownloadEngine.h")
#import "DDPhotoSDImageDownloadEngine.h"
#else
#endif

@implementation DDPhotoItem

- (instancetype)initWithSourceView:(UIImageView *)sourceView
                          imageUrl:(NSURL *)imageUrl
                        thumbImage:(UIImage *)thumbImage
                     thumbImageUrl:(NSURL *)thumbImageUrl
                  placeholderImage:(UIImage *)placeholderImage
               imageDownloadEngine:(id<DDPhotoImageDownloadEngine>)imageDownloadEngine
{
    self = [super init];
    if (self) {
        self.sourceView = sourceView;
        self.imageUrl = imageUrl;
        self.thumbImage = thumbImage;
        self.thumbImageUrl = thumbImageUrl;
        if (!self.image && self.thumbImage) {
            self.placeholderImage = nil;
            self.placeholderImage = self.thumbImage;
        }
        if (self.image) {
            self.placeholderImage = nil;
            self.thumbImage = nil;
            self.thumbImage = self.image;
            self.placeholderImage = self.image;
        }
        self.firstShowAnimation = NO;
        if (imageDownloadEngine && !self.image) {//是否为空
            self.image = [imageDownloadEngine imageFromCacheForURL:self.imageUrl];
            if (!self.image) {/**没有原图了*/
                if (!self.thumbImage) {//缩略图为空
                    if (self.thumbImageUrl) {//缩略图url不为空
                        self.thumbImage = [imageDownloadEngine imageFromCacheForURL:self.thumbImageUrl];
                        if (self.thumbImage) {
                            self.placeholderImage = self.thumbImage;
                        }
                    }
                }
            } else {//原图已经存在了
                self.thumbImage = self.image;
                self.placeholderImage = self.image;
            }
        }
    }
    return self;
}
+ (instancetype)itemWithSourceView:(UIImageView *)sourceView
                          imageUrl:(NSURL *)imageUrl
                        thumbImage:(UIImage *)thumbImage
                     thumbImageUrl:(NSURL *)thumbImageUrl
                  placeholderImage:(UIImage *)placeholderImage
               imageDownloadEngine:(id<DDPhotoImageDownloadEngine>)imageDownloadEngine
{
    return [[DDPhotoItem alloc] initWithSourceView:sourceView imageUrl:imageUrl thumbImage:thumbImage thumbImageUrl:thumbImageUrl placeholderImage:placeholderImage imageDownloadEngine:imageDownloadEngine];
}

+ (instancetype)itemWithSourceView:(UIImageView *)sourceView
                          imageUrl:(NSURL *)imageUrl
                        thumbImage:(UIImage *)thumbImage
                     thumbImageUrl:(NSURL *)thumbImageUrl
                      imageDownloadEngine:(id<DDPhotoImageDownloadEngine>)imageDownloadEngine
{
    return [self itemWithSourceView:sourceView imageUrl:imageUrl thumbImage:thumbImage thumbImageUrl:thumbImageUrl placeholderImage:nil imageDownloadEngine:imageDownloadEngine];
}

- (CGRect)sourceViewInWindowRect
{
    UIWindow* window = [UIApplication sharedApplication].keyWindow;
    CGRect rect = [self.sourceView.superview convertRect:self.sourceView.frame toView:window];
    return rect;
}

- (void)dealloc
{
    NSLog(@"dealloc：%@",NSStringFromClass([self class]));
}

@end
