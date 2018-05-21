//
//  DDPhotoProgressView.h
//  DDPhotoBrowser
//
//  Created by 刘和东 on 2015/5/21.
//  Copyright © 2015年 刘和东. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DDPhotoProgressView : UIView

@property (nonatomic,strong) UIColor * tintColor;

@property BOOL isAnimating;

- (void)startAnimating;
- (void)stopAnimating;

@end
