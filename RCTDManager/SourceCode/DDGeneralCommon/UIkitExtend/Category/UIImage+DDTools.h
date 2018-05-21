//
//  UIImage+DDTools.h
//  DoorDu
//
//  Created by 刘和东 on 2017/11/16.
//  Copyright © 2017年 深圳市多度科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (DDTools)

#pragma mark - frame 高度和宽度获取
@property (nonatomic,assign,readonly) CGFloat height;
@property (nonatomic,assign,readonly) CGFloat width;

#pragma mark - image 设置
/**把图片不压缩的转成NSData*/
- (NSData *)image2Data;

/**返回压之后的NSData，这里没有缩放，只是像素压缩*/
- (NSData *)pressImage2DataWithScale:(CGFloat)scale;

/**返回压之后的image，这里没有缩放，只是像素压缩*/
- (UIImage *)pressImageWithScale:(CGFloat)scale;

/**返回压之后的image，这里是对长宽压缩，像素无压缩*/
- (UIImage *)resizeImageWithScale:(CGFloat)scale;

/**返回压之后的NSData，这里是对长宽压缩，像素无压缩*/
- (NSData *)resizeImage2DataWithScale:(CGFloat)scale;

#pragma mark - 一般用这个
/**返回压之后的NSData，这里是对长宽、像素同时压缩*/
- (NSData *)resizePressImage2DataScale:(CGFloat)scale;

/**返回压之后的UIImage，这里是对长宽、像素同时压缩*/
- (UIImage *)resizePressImageScale:(CGFloat)scale;

/**获取启动图片*/
+ (UIImage *)getLaunchImage;

/**获取appIcon图片*/
+ (UIImage *)getAppIconImage;

/**纠正图片*/
- (UIImage *)fixOrientation;

- (CGSize)sizeThatFits:(CGSize)size;

/**检测图片中的人脸数：CIFaceFeature*/
- (NSArray *)detectionFeatures;
/**检测图片中是否有人脸*/
- (BOOL)detectionContainFeature;
/**
 *  压缩图片到指定文件大小
 *
 *  @param size  目标大小（最大值）
 *
 *  @return 返回的图片文件
 */
- (NSData *)compressToMaxDataSizeKBytes:(CGFloat)size;
+ (UIImage*)createImageWithColor:(UIColor*)color size:(CGSize)size;
+ (UIImage*)createImageWithColor:(UIColor*)color size:(CGSize)size radius:(NSInteger)radius;


@end
