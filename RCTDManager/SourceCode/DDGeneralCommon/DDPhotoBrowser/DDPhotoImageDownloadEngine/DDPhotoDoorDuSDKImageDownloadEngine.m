//
//  DDPhotoDoorDuSDKImageDownloadEngine.m
//  DoorDuOEM
//
//  Created by 刘和东 on 2018/4/14.
//  Copyright © 2018年 深圳市多度科技有限公司. All rights reserved.
//

#import "DDPhotoDoorDuSDKImageDownloadEngine.h"


@implementation DDPhotoDoorDuSDKImageDownloadEngine

/**请求数据*/
- (void)setImageWithImageView:(nullable UIImageView *)imageView
                     imageURL:(nullable NSURL *)imageURL
                thumbImageUrl:(nullable NSURL *)thumbImageUrl
                  placeholder:(nullable UIImage *)placeholder
                     progress:(nullable DDPhotoImageDownloadEngineProgressBlock)progress
                       finish:(nullable DDPhotoImageDownloadEngineFinishBlock)finish
{
    if (thumbImageUrl) {
        UIImage * image = [self imageFromCacheForURL:thumbImageUrl];
        if (image) {
            placeholder = image;
        }
    }
    [imageView dd_setImageWithURL:imageURL placeholderImage:placeholder options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
        if (progress) {
            progress(receivedSize,expectedSize);
        }
    } completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        if (finish) {
            finish(image, imageURL, !error, error);
        }
    }];
}
- (void)setImageWithImageView:(nullable UIImageView *)imageView
                     imageURL:(nullable NSURL *)imageURL
                  placeholder:(nullable UIImage *)placeholder
                     progress:(nullable DDPhotoImageDownloadEngineProgressBlock)progress
                       finish:(nullable DDPhotoImageDownloadEngineFinishBlock)finish
{
    [imageView dd_setImageWithURL:imageURL placeholderImage:placeholder options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
        if (progress) {
            progress(receivedSize,expectedSize);
        }
    } completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        if (finish) {
            finish(image, imageURL, !error, error);
        }
    }];
}
/**取消请求*/
- (void)cancelImageRequestWithImageView:(nullable UIImageView *)imageView
{
    
}
/**通过url从内存中获取图片*/
- (UIImage *_Nullable)imageFromMemoryCacheForURL:(nullable NSURL *)url
{
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    NSString *key = [manager cacheKeyForURL:url];
    return [manager.imageCache imageFromMemoryCacheForKey:key];
}
/**通过url从磁盘中获取图片*/
- (UIImage *_Nullable)imageFromDiskCacheForURL:(nullable NSURL *)url
{
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    NSString *key = [manager cacheKeyForURL:url];
    return [manager.imageCache imageFromDiskCacheForKey:key];
}
/**通过url获取图片*/
- (nullable UIImage *)imageFromCacheForURL:(nullable NSURL *)url
{
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    NSString *key = [manager cacheKeyForURL:url];
    return [manager.imageCache imageFromCacheForKey:key];
}


@end
