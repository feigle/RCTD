//
//  DDPhotoBrowserCollectionViewCell.h
//  DDPhotoBrowser
//
//  Created by 刘和东 on 2015/5/21.
//  Copyright © 2015年 刘和东. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DDPhotoImageView.h"

@interface DDPhotoBrowserCollectionViewCell : UICollectionViewCell

@property (nonatomic,strong) DDPhotoImageView * imageView;
@property (nonatomic,strong) DDPhotoItem * item;
@property (nonatomic,weak) id<DDPhotoImageDownloadEngine> imageDownloadEngine;
/**选择显示图片的控件*/
@property (nonatomic,assign) DDImageViewEngineType imageViewEngineType;

@end
