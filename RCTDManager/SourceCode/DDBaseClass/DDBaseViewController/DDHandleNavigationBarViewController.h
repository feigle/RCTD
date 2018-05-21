//
//  DDHandleNavigationBarViewController.h
//  DoorDu
//
//  Created by matt on 2018/3/21.
//  Copyright © 2018年 广州人创天地有限公司 All rights reserved.
//

#import "DDBaseViewController.h"

/** 导航的背景 */
typedef NS_ENUM(NSInteger,DDNavigationBarBackgroundColorStyle) {
    DDNavigationBarBackgroundColorWhiteStyle = 0,//白色
    DDNavigationBarBackgroundColorLucencyStyle = 2,//透明
};

/** 导航的 标题title颜色 */
typedef NS_ENUM(NSInteger,DDNavigationBarTitleColorStyle) {
    DDNavigationBarTitleColorBlackStyle = 0,//黑色
};

/**导航的 TintColor(navigationItem 的 barButtonItem) */
typedef NS_ENUM(NSInteger,DDNavigationBarTintColorStyle) {
    DDNavigationBarTintColorStyleBrownStyle = 0,//棕色
};

@interface DDHandleNavigationBarViewController : DDBaseViewController

/**
 *  默认为YES（UIStatusBarStyleDefault）
 *  为NO时 为 UIStatusBarStyleLightContent
 */
@property (nonatomic,assign) BOOL isStatusBarStyleDefault;


#pragma mark  - 设置导航栏
/** 当前导航栏侧滑 返回的时候 当前导航颜色和前个界面颜色渐变，不需要就没有渐变，默认YES，为NO时默认导航背景图片为空（为透明） */
@property (nonatomic, assign) BOOL isNeedNavigationBarColorGradient;

/** 是否需要隐藏导航栏 , 默认为NO*/
@property (nonatomic, assign) BOOL navigationBarHidden;

/** 设置右滑距离左边屏幕的距离，默认是全屏可以滑动，默认-99（全屏可以滑动） */
@property (nonatomic, assign) CGFloat interactivePopMaxAllowedLeftEdge;

/** 设置导航栏的背景颜色 */
@property (nonatomic, strong) UIColor * navigationBarBackgroundColor;

/** 导航条背景style , 默认白色,DDNavigationBarBackgroundColorWhiteStyle时navigationBarBackgroundAlpha为0 */
@property (nonatomic, assign) DDNavigationBarBackgroundColorStyle navigationBarBackgroundColorStyle;

/**  设置导航栏的透明度，默认是 -99(不需要) */
@property (nonatomic, assign) CGFloat navigationBarBackgroundAlpha;

/** 导航的 标题title颜色 style,默认 DDNavigationBarTitleColorBlackStyle */
@property (nonatomic, assign) DDNavigationBarTitleColorStyle navigationBarTitleColorStyle;

/** 设置导航栏的标题title颜色 */
@property (nonatomic, strong) UIColor * navigationBarTitleColor;

/** 设置导航栏的TintColor Style */
@property (nonatomic, assign) DDNavigationBarTintColorStyle navigationBarTintColorStyle;

/** 设置导航栏的TintColor ，控制(navigationItem 的 barButtonItem),默认DDNavigationBarTintColorStyleBrownStyle*/
@property (nonatomic, strong) UIColor * navigationBarTintColor;


#pragma mark - 设置导航栏右侧item
/** 设置导航栏右侧文字 */
@property (nonatomic, strong) NSString * rightItemTitle;
/** 设置导航栏右侧文字数组 */
@property (nonatomic, strong) NSArray  * rightItemTitles;
/** 设置导航栏右侧图片名字 */
@property (nonatomic, strong) NSString * rightItemImageName;
/** 设置导航栏右侧图片名字数组 */
@property (nonatomic, strong) NSArray  * rightItemImageNames;

/** 设置导航栏右侧自定义view */
@property (nonatomic, strong) UIView * rightItemCusstomView;


#pragma mark - 设置导航栏左侧item
/** 设置导航栏左侧文字 */
@property (nonatomic, strong) NSString * leftItemTitle;
/** 设置导航栏左侧文字数组 */
@property (nonatomic, strong) NSArray  * leftItemTitles;
/** 设置导航栏左侧图片名字 */
@property (nonatomic, strong) NSString * leftItemImageName;
/** 设置导航栏左侧图片名字数组 */
@property (nonatomic, strong) NSArray  * leftItemImageNames;

/** 设置导航栏左侧自定义view */
@property (nonatomic, strong) UIView * leftItemCusstomView;



/** 设置带有返回按钮(<)的文字（系统自带） */
@property (nonatomic, strong) NSString * backBarButtonItemTitle;

/** 设置带有返回按钮图片 */
@property (nonatomic, strong) UIImage * backIndicatorImage;



/**  导航 Item点击事件 */
- (void)navLeftItemClick:(NSInteger)index;
- (void)navRightItemClick:(NSInteger)index;

- (void)pushVC:(UIViewController *)vc;

- (void)pushVC:(UIViewController *)vc animated:(BOOL)animated;

/** 推出带有 navigationController 的VC */
- (void)presentNavVC:(UIViewController *)VC animated:(BOOL)animated completion:(void (^)(void))completion;
/** 推出带有 navigationController 的VC */
- (void)presentNavVC:(UIViewController *)VC completion:(void (^)(void))completion;


@end
