//
//  DDEmptyPlaceholderView.h
//  DoorDuOEM
//
//  Created by 刘和东 on 2018/4/14.
//  Copyright © 2018年 深圳市多度科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

/** 空白占位符 */
@interface DDEmptyPlaceholderView : UIView

/** 占位符文字 */
@property (nonatomic, strong) NSString * placeholder;

/** 占位符图片 ,默认 DDEmptyPlaceholderBigEmptyImage*/
@property (nonatomic, strong) NSString * imageName;

/** 图片和文字之间的距离，默认 15 */
@property (nonatomic, assign) CGFloat imageTextSpace;

/** 占位符文字颜色,默认颜色 BFBFBF */
@property (nonatomic, strong) UIColor * placeholderColor;

/** 占位符文字 字体 ,默认大小  36/2.0 */
@property (nonatomic, strong) UIFont * placeholderFont;

/** 返回点击事件 */
@property (nonatomic, copy) void (^clickedBlock)(void);


+ (DDEmptyPlaceholderView *)placeholder:(NSString *)placeholder
          imageName:(NSString *)imageName
     imageTextSpace:(CGFloat)imageTextSpace
   placeholderColor:(UIColor *)placeholderColor
    placeholderFont:(UIFont *)placeholderFont
          superView:(UIView *)superView
       clickedBlock:(void (^)(void))clickedBlock;

+ (DDEmptyPlaceholderView *)placeholder:(NSString *)placeholder
          imageName:(NSString *)imageName
          superView:(UIView *)superView
       clickedBlock:(void (^)(void))clickedBlock;

/** 默认展示大页面的空白页面 */
+ (DDEmptyPlaceholderView *)showBigPlaceholder:(NSString*)placeholder
                 superView:(UIView *)superView
              clickedBlock:(void (^)(void))clickedBlock;

/** 默认展示小页面的空白页面 */
+ (DDEmptyPlaceholderView *)showSmallPlaceholder:(NSString*)placeholder
                 superView:(UIView *)superView
              clickedBlock:(void (^)(void))clickedBlock;

/** 移除self view */
+ (void)removeSelfSuperView:(UIView *)superView;

@end
