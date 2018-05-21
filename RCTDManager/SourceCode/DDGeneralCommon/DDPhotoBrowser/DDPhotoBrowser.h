//
//  DDPhotoBrowser.h
//  DDPhotoBrowser
//
//  Created by 刘和东 on 2015/5/21.
//  Copyright © 2015年 刘和东. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DDPhotoImageDownloadEngine.h"
#import "DDPhotoSDImageDownloadEngine.h"
#import "DDPhotoDoorDuSDKImageDownloadEngine.h"
#import "DDPhotoItem.h"
#import "DDImageViewEngine.h"

@protocol DDPhotoImageDownloadEngine;

/**背景选择*/
typedef NS_ENUM(NSInteger, DDPhotoBrowserBackgroundStyle) {
    DDPhotoBrowserBackgroundStyleBlurExtraLight,/**毛玻璃效果 1*/
    DDPhotoBrowserBackgroundStyleBlurLight,/**毛玻璃效果 2*/
    DDPhotoBrowserBackgroundStyleBlurDark,/**毛玻璃效果 3*/
    DDPhotoBrowserBackgroundStyleBlack/**黑色*/
};

typedef NS_ENUM(NSUInteger, DDPhotoBrowserPageIndicateStyle) {
    DDPhotoBrowserPageIndicateStylePageLabel = 1,/**pageLabel*/
    DDPhotoBrowserPageIndicateStylePageControl/**pageControl*/
};

typedef void (^DDPhotoBrowserChangeToIndexBlock)(NSInteger index,DDPhotoItem * item);

@interface DDPhotoBrowser : UIViewController

/**默认是 DDPhotoBrowserBackgroundStyleBlurDark */
@property (nonatomic,assign) DDPhotoBrowserBackgroundStyle backgroundStyle;
/**page指示类型,默认是DDPhotoBrowserPageIndicateStylePageLabel*/
@property (nonatomic,assign) DDPhotoBrowserPageIndicateStyle pageIndicateStyle;
/**选择显示图片的控件,默认是UIImageView*/
@property (nonatomic,assign) DDImageViewEngineType imageViewEngineType;

/**
 * 默认使用 DDPhotoSDImageDownloadEngine
 */
+ (instancetype)photoBrowserWithPhotoItems:(NSArray<DDPhotoItem *> *)photoItems
                              currentIndex:(NSUInteger)currentIndex;

+ (instancetype)photoBrowserWithPhotoItems:(NSArray<DDPhotoItem *> *)photoItems
                              currentIndex:(NSUInteger)currentIndex
                              imageDownloadEngine:(id<DDPhotoImageDownloadEngine>)imageDownloadEngine;
/**
 *  返回当前的滑动的那个
 */
- (void)photoBrowserClickedBlock:(DDPhotoBrowserChangeToIndexBlock)block;

/**弹出*/
- (void)showFromVC:(UIViewController *)vc;

@end
