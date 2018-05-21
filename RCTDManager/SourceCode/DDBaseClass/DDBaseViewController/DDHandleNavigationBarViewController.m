//
//  DDHandleNavigationBarViewController.m
//  DoorDu
//
//  Created by matt on 2018/3/21.
//  Copyright © 2018年 广州人创天地有限公司 All rights reserved.
//

#import "DDHandleNavigationBarViewController.h"
#import "UINavigationController+FDFullscreenPopGesture.h"
#import "UIViewController+DDGetBackBarButtonItemClicked.h"

@interface DDHandleNavigationBarViewController ()

/** 导航栏下面的背景view， 这个view添加在 self.view 上面，以实现侧滑导航颜色不渐变的情况*/
@property (nonatomic, strong) UIView * navigationBarBackgroundView;

@end

@implementation DDHandleNavigationBarViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self __setupCommonInit];
    }
    return self;
}

- (void)__setupCommonInit
{
    self.isNeedNavigationBarColorGradient = YES;
    self.navigationBarHidden = NO;
    self.navigationBarBackgroundColorStyle = DDNavigationBarBackgroundColorWhiteStyle;
    self.navigationBarBackgroundAlpha = -99;
    self.isStatusBarStyleDefault = YES;
    self.interactivePopMaxAllowedLeftEdge = -99;
    
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    [self.view bringSubviewToFront:self.navigationBarBackgroundView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (self.navigationController) {
        self.navigationBarBackgroundView.hidden = self.navigationBarHidden;
    } else {
        self.navigationBarBackgroundView.hidden = YES;
    }
    if (!self.isNeedNavigationBarColorGradient || self.navigationBarBackgroundColorStyle == DDNavigationBarBackgroundColorLucencyStyle) {//不需要渐变
        [self.navigationController.navigationBar setBackgroundImage:UIImage.new forBarMetrics:UIBarMetricsDefault];
    }
    /** 当设置的背景颜色的alpha大于0的时候 */
    if (self.navigationBarBackgroundAlpha >= 0 ) {
        [self.navigationController.navigationBar setBackgroundImage:UIImage.new forBarMetrics:UIBarMetricsDefault];
    }
    /** 设置导航栏的背景颜色 */
    self.navigationBarBackgroundColor = [self __getNavigationBarBackgroundColor];
    /** 设置导航栏标题颜色 */
    self.navigationBarTitleColor = [self __getNavigationBarTitleColor];
    /** 设置导航栏的TintColor */
    self.navigationBarTintColor = [self __getNavigationBarTintColor];
    if (self.isStatusBarStyleDefault) {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    } else {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (self.navigationBarBackgroundAlpha >= 0|| self.navigationBarBackgroundColorStyle == DDNavigationBarBackgroundColorLucencyStyle) {
        [self.navigationController.navigationBar setBackgroundImage:UIImage.new forBarMetrics:UIBarMetricsDefault];
    } else {
        [self __setNavigationBarBackground];
    }
}
/** 将要消失的时候 */
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if (self.isNeedNavigationBarColorGradient && (self.navigationBarBackgroundAlpha >= 0 || self.navigationBarBackgroundColorStyle == DDNavigationBarBackgroundColorLucencyStyle)) {//需要渐变
        [self.navigationController.navigationBar setBackgroundImage:[UINavigationBar.appearance backgroundImageForBarMetrics:UIBarMetricsDefault] forBarMetrics:UIBarMetricsDefault];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    /** 去掉导航下面的线 */
    [self.navigationController.navigationBar setShadowImage:UIImage.new];
//    self.navigationController.navigationBar.shadowImage = UIImage.new;
//    self.navigationController.navigationBar.subviews[0].backgroundColor = [UIColor whiteColor];
//    self.navigationController.navigationBar.subviews[0].alpha = 1;
    self.navigationController.navigationBar.translucent = YES;
    
    [self.view addSubview:self.navigationBarBackgroundView];
    /** 设置是否隐藏导航条 */
    self.fd_prefersNavigationBarHidden = self.navigationBarHidden;
    self.navigationBarBackgroundView.hidden = self.navigationBarHidden;
    
    /** 设置左边滑动距离，大于0小于屏幕宽度时设置，默认是全屏可以滑动 */
    if (self.interactivePopMaxAllowedLeftEdge >=0 && self.interactivePopMaxAllowedLeftEdge < [UIScreen mainScreen].bounds.size.width) {
        self.fd_interactivePopMaxAllowedInitialDistanceToLeftEdge = self.interactivePopMaxAllowedLeftEdge;
    }
    
//    if (self.navigationBarBackgroundAlpha >= 0) {
//        [self.navigationController.navigationBar setBackgroundImage:UIImage.new forBarMetrics:UIBarMetricsDefault];
//    } else {
//        [self __setNavigationBarBackground];
//    }
    self.backBarButtonItemTitle = @"";
}

- (void)__setNavigationBarBackground
{
    // 当前导航栏侧滑 返回的时候 当前导航颜色和前个界面颜色渐变
    if (self.isNeedNavigationBarColorGradient) {//需要渐变
        [self.navigationController.navigationBar setBackgroundImage:[UINavigationBar.appearance backgroundImageForBarMetrics:UIBarMetricsDefault] forBarMetrics:UIBarMetricsDefault];
    } else {//不需要渐变
        [self.navigationController.navigationBar setBackgroundImage:UIImage.new forBarMetrics:UIBarMetricsDefault];
    }
}

- (void)setNavigationBarHidden:(BOOL)navigationBarHidden
{
    _navigationBarHidden = navigationBarHidden;
    self.fd_prefersNavigationBarHidden = navigationBarHidden;
    self.navigationBarBackgroundView.hidden = navigationBarHidden;
}

- (void)setInteractivePopMaxAllowedLeftEdge:(CGFloat)interactivePopMaxAllowedLeftEdge
{
    _interactivePopMaxAllowedLeftEdge = interactivePopMaxAllowedLeftEdge;
    self.fd_interactivePopMaxAllowedInitialDistanceToLeftEdge = interactivePopMaxAllowedLeftEdge;

}

#pragma mark - 导航栏点击事件
/** 内部右侧点击事件 */
- (void)__rightBarItemClick:(UIBarButtonItem *)item
{
    [self navRightItemClick:item.tag];
}
/** 内部左侧点击事件 */
- (void)__leftBarItemClick:(UIBarButtonItem *)item
{
    [self navLeftItemClick:item.tag];
}

#pragma mark - 拦截系统返回按钮 点击事件
- (BOOL)navigationShouldPopOnBackButton
{
    [self navLeftItemClick:0];
    return NO;
}

#pragma mark - 子类需要继承的
/** 设置带有返回按钮(<)的文字（系统自带） */
- (void)setBackBarButtonItemTitle:(NSString *)backBarButtonItemTitle
{
    _backBarButtonItemTitle = backBarButtonItemTitle;
    [self.navigationItem.backBarButtonItem setTitleTextAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]} forState:UIControlStateNormal];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] init];
    item.title = backBarButtonItemTitle;
    self.navigationItem.backBarButtonItem = item;
}

- (void)setBackIndicatorImage:(UIImage *)backIndicatorImage
{
    backIndicatorImage = [backIndicatorImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.navigationController.navigationBar.backIndicatorImage = backIndicatorImage;
    self.navigationController.navigationBar.backIndicatorTransitionMaskImage = backIndicatorImage;
    _backIndicatorImage = backIndicatorImage;
}

//默认左侧点击事件是返回事件
- (void)navLeftItemClick:(NSInteger)index
{
    if (self.navigationController.viewControllers.count > 1) {
        if (self.childViewControllers.count) {
            [self.childViewControllers makeObjectsPerformSelector:@selector(removeFromParentViewController)];
        }
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        [self dismissViewControllerAnimated:YES completion:^{
        }];
    }
}
- (void)navRightItemClick:(NSInteger)index
{
    
}

#pragma mark - 设置导航栏右侧item
/** 设置导航栏右侧文字 */
- (void)setRightItemTitle:(NSString *)rightItemTitle
{
    _rightItemTitle = rightItemTitle;
    self.rightItemTitles = @[rightItemTitle];
}
/** 设置导航栏右侧文字数组 */
- (void)setRightItemTitles:(NSArray *)rightItemTitles
{
    _rightItemTitles = rightItemTitles;
    NSMutableArray * items = [NSMutableArray array];
    for (NSString * title in rightItemTitles) {
        UIBarButtonItem * itemBtn = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:self action:@selector(__rightBarItemClick:)];
        itemBtn.tag = [rightItemTitles indexOfObject:title];
        [items addObject:itemBtn];
        if (![rightItemTitles.lastObject isEqualToString:title]) {
            UIBarButtonItem * spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
            spaceItem.width = 10;
            [items addObject:spaceItem];
        }
    }
    self.navigationItem.rightBarButtonItems = items;
}
/** 设置导航栏右侧图片名字 */
- (void)setRightItemImageName:(NSString *)rightItemImageName
{
    _rightItemImageName = rightItemImageName;
    self.rightItemImageNames = @[rightItemImageName];
}
/** 设置导航栏右侧图片名字数组 */
- (void)setRightItemImageNames:(NSArray *)rightItemImageNames
{
    _rightItemImageNames = rightItemImageNames;
    NSMutableArray * items = [NSMutableArray array];
    for (NSString * imageName in rightItemImageNames) {
        UIImage *tmpImg = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UIBarButtonItem * itemBtn = [[UIBarButtonItem alloc] initWithImage:tmpImg style:UIBarButtonItemStylePlain target:self action:@selector(__rightBarItemClick:)];
        itemBtn.tag = [rightItemImageNames indexOfObject:imageName];
        [items addObject:itemBtn];
        if (![rightItemImageNames.lastObject isEqualToString:imageName]) {
            UIBarButtonItem * spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
            spaceItem.width = 10;
            [items addObject:spaceItem];
        }
    }
    self.navigationItem.rightBarButtonItems = items;
}
/** 设置导航栏右侧自定义view */
- (void)setRightItemCusstomView:(UIView *)rightItemCusstomView
{
    UIBarButtonItem * item = [[UIBarButtonItem alloc] initWithCustomView:rightItemCusstomView];
    self.navigationItem.rightBarButtonItem = item;
}

#pragma mark - 设置导航栏左侧item
/** 设置导航栏左侧文字 */
- (void)setLeftItemTitle:(NSString *)leftItemTitle
{
    _leftItemTitle = leftItemTitle;
    self.leftItemTitles = @[leftItemTitle];
}
/** 设置导航栏左侧文字数组 */
- (void)setLeftItemTitles:(NSArray *)leftItemTitles
{
    _leftItemTitles = leftItemTitles;
    NSMutableArray * items = [NSMutableArray array];
    for (NSString * title in leftItemTitles) {
        UIBarButtonItem * itemBtn = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:self action:@selector(__leftBarItemClick:)];
        itemBtn.tag = [leftItemTitles indexOfObject:title];
        [items addObject:itemBtn];
        if (![leftItemTitles.lastObject isEqualToString:title]) {
            UIBarButtonItem * spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
            spaceItem.width = 10;
            [items addObject:spaceItem];
        }
    }
    self.navigationItem.leftBarButtonItems = items;
}
/** 设置导航栏左侧图片名字 */
- (void)setLeftItemImageName:(NSString *)leftItemImageName
{
    _leftItemImageName = leftItemImageName;
    self.leftItemImageNames = @[leftItemImageName];
}
/** 设置导航栏左侧图片名字数组 */
- (void)setLeftItemImageNames:(NSArray *)leftItemImageNames
{
    _leftItemImageNames = leftItemImageNames;
    NSMutableArray * items = [NSMutableArray array];
    for (NSString * imageName in leftItemImageNames) {
        UIImage *tmpImg = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UIBarButtonItem * itemBtn = [[UIBarButtonItem alloc] initWithImage:tmpImg style:UIBarButtonItemStylePlain target:self action:@selector(__leftBarItemClick:)];
        itemBtn.tag = [leftItemImageNames indexOfObject:imageName];
        [items addObject:itemBtn];
        if (![leftItemImageNames.lastObject isEqualToString:imageName]) {
            UIBarButtonItem * spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
            spaceItem.width = 10;
            [items addObject:spaceItem];
        }
    }
    self.navigationItem.leftBarButtonItems = items;
}

/** 设置导航栏左侧自定义view */
- (void)setLeftItemCusstomView:(UIView *)leftItemCusstomView
{
    UIBarButtonItem * item = [[UIBarButtonItem alloc] initWithCustomView:leftItemCusstomView];
    self.navigationItem.leftBarButtonItem = item;
}

- (void)pushVC:(UIViewController *)vc
{
    [self pushVC:vc animated:YES];
}

- (void)pushVC:(UIViewController *)vc animated:(BOOL)animated
{
    vc.hidesBottomBarWhenPushed = YES;
    if (!self.superViewController) {
        [self.navigationController pushViewController:vc animated:animated];
    } else {
        [self.superViewController.navigationController pushViewController:vc animated:animated];
    }
}

/** 推出带有 navigationController 的VC */
- (void)presentNavVC:(UIViewController *)VC animated:(BOOL)animated completion:(void (^)(void))completion
{
    UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:VC];
    [self presentViewController:nav animated:animated completion:completion];
}
/** 推出带有 navigationController 的VC */
- (void)presentNavVC:(UIViewController *)VC completion:(void (^)(void))completion
{
    [self presentNavVC:VC animated:YES completion:completion];
}

#pragma mark - 懒加载
/** 导航栏下面的背景view， 这个view添加在 self.view 上面，以实现侧滑导航颜色不渐变的情况*/
- (UIView *)navigationBarBackgroundView
{
    if (!_navigationBarBackgroundView) {
        CGFloat navigationHeight = ([[UIApplication sharedApplication] statusBarFrame].size.height)+ ([UINavigationBar appearance].frame.size.height==0?44:[UINavigationBar appearance].frame.size.height);
        _navigationBarBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, navigationHeight)];
    }
    return _navigationBarBackgroundView;
}

#pragma mark - 导航栏的颜色
/** 获取导航条背景颜色 */
- (UIColor *)__getNavigationBarBackgroundColor
{
    if (_navigationBarBackgroundColor) {
        return _navigationBarBackgroundColor;
    }
    switch (self.navigationBarBackgroundColorStyle) {
        case DDNavigationBarBackgroundColorWhiteStyle:
        {
            return DDColorFFFFFF;
        }
            break;
            
        default:
            break;
    }
    return nil;
}

/** 设置导航条的背景颜色 */
- (void)setNavigationBarBackgroundColor:(UIColor *)navigationBarBackgroundColor
{
    _navigationBarBackgroundColor = navigationBarBackgroundColor;
    UIColor * navBgColor = _navigationBarBackgroundColor;
    if (self.navigationBarBackgroundAlpha >= 0) {
        navBgColor = [_navigationBarBackgroundColor colorAlpha:self.navigationBarBackgroundAlpha];
    }
    self.navigationController.navigationBar.barTintColor = [navBgColor colorAlpha:1];
    self.navigationBarBackgroundView.backgroundColor = navBgColor;

}

/** 设置导航的透明度 */
- (void)setNavigationBarBackgroundAlpha:(CGFloat)navigationBarBackgroundAlpha
{
    if (navigationBarBackgroundAlpha > 1) {
        navigationBarBackgroundAlpha = 1;
    }
    _navigationBarBackgroundAlpha = navigationBarBackgroundAlpha;
    if (navigationBarBackgroundAlpha >= 0) {
        self.navigationBarBackgroundColor = [self __getNavigationBarBackgroundColor];
    }
}

#pragma mark - 导航栏的标题 title 颜色
/** 获取导航栏标题的颜色 */
- (UIColor *)__getNavigationBarTitleColor
{
    if (_navigationBarTitleColor) {
        return _navigationBarTitleColor;
    }
    switch (self.navigationBarTitleColorStyle) {
        case DDNavigationBarTitleColorBlackStyle://棕色
        {
            return DDColor333333;
        }
            break;
            
        default:
            break;
    }
    return nil;
}

/** 设置导航栏的标题颜色 */
- (void)setNavigationBarTitleColor:(UIColor *)navigationBarTitleColor
{
    _navigationBarTitleColor = navigationBarTitleColor;
    UIFont * systemTitleFont = [UIFont systemFontOfSize:34/2.0];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:navigationBarTitleColor,NSForegroundColorAttributeName,systemTitleFont,NSFontAttributeName,nil]];

}

#pragma mark - 设置导航栏的TintColor
/** 获取导航栏的tint颜色 */
- (UIColor *)__getNavigationBarTintColor
{
    if (_navigationBarTintColor) {
        return _navigationBarTintColor;
    }
    switch (self.navigationBarTintColorStyle) {
        case DDNavigationBarTintColorStyleBrownStyle:
        {
            return DDColorB39575;
        }
            break;
            
        default:
            break;
    }
    return nil;
}
/** 设置导航栏的TintColor */
- (void)setNavigationBarTintColor:(UIColor *)navigationBarTintColor
{
    _navigationBarTintColor = navigationBarTintColor;
    self.navigationController.navigationBar.tintColor = navigationBarTintColor;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
