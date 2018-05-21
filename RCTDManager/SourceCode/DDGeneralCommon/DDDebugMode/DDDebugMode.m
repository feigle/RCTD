//
//  DDDebugMode.m
//  ProjectAssistant
//
//  Created by matt on 2018/4/8.
//  Copyright © 2018年 深圳市多度科技有限公司. All rights reserved.
//

#import "DDDebugMode.h"

@implementation DDDebugMode

+ (void)showDebugModelView;
{
#ifdef DEBUG
    UIView *view = [UIApplication sharedApplication].keyWindow;
    CGFloat Mwidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat Mheight = [UIScreen mainScreen].bounds.size.height;
    
    UIView *subView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Mwidth, Mheight)];
    subView.backgroundColor = [UIColor whiteColor];
    
    UIButton *debugButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, Mwidth-100, 44)];
    [debugButton setBackgroundColor:[UIColor lightGrayColor]];
    [debugButton setTitle:@"测试环境" forState:UIControlStateNormal];
    [debugButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [debugButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    
    UIButton *betaButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, Mwidth-100, 44)];
    [betaButton setTitle:@"预发布环境" forState:UIControlStateNormal];
    [betaButton setBackgroundColor:[UIColor lightGrayColor]];
    [betaButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [betaButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    
    UIButton *productButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, Mwidth-100, 44)];
    [productButton setTitle:@"生产环境" forState:UIControlStateNormal];
    [productButton setBackgroundColor:[UIColor lightGrayColor]];
    [productButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [productButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    
    UIButton *okButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, Mwidth-100, 44)];
    [okButton setBackgroundColor:[UIColor lightGrayColor]];
    [okButton setTitle:@"确  定" forState:UIControlStateNormal];
    [okButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    UIButton *cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, Mwidth-100, 44)];
    [cancelButton setBackgroundColor:[UIColor lightGrayColor]];
    [cancelButton setTitle:@"取  消" forState:UIControlStateNormal];
    [cancelButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    
    betaButton.center = subView.center;
    debugButton.centerY = betaButton.centerY-44-20;
    debugButton.centerX = betaButton.centerX;
    productButton.centerY = betaButton.centerY+44+20;
    productButton.centerX = betaButton.centerX;
    okButton.centerY = productButton.centerY+44+20;
    okButton.centerX = productButton.centerX;
    cancelButton.centerY = okButton.centerY+44+20;
    cancelButton.centerX = okButton.centerX;
    
    __block NSInteger index = -1;
    __weak typeof(UIButton *) wDebug = debugButton;
    [debugButton addClickedHandle:^(UIButton *sender) {
        productButton.selected = NO;
        betaButton.selected = NO;
        wDebug.selected = YES;
        index = 0;
    }];
    __weak typeof(UIButton *) wBeta = betaButton;
    [betaButton addClickedHandle:^(UIButton *sender) {
        productButton.selected = NO;
        debugButton.selected = NO;
        wBeta.selected = YES;
        index = 1;
    }];
    __weak typeof(UIButton *) wProduct = productButton;
    [productButton addClickedHandle:^(UIButton *sender) {
        debugButton.selected = NO;
        betaButton.selected = NO;
        wProduct.selected = YES;
        index = 2;
    }];
    
    [okButton addClickedHandle:^(UIButton *sender) {
        if (index == -1) {
            [subView removeFromSuperview];
            return;
        }
        [[self class] saveDebugModel:index];
        exit(0);
    }];
    
    [cancelButton addClickedHandle:^(UIButton *sender) {
        [subView removeFromSuperview];
    }];
    
    [subView addSubview:debugButton];
    [subView addSubview:betaButton];
    [subView addSubview:productButton];
    [subView addSubview:okButton];
    [subView addSubview:cancelButton];
    
    [view addSubview:subView];
#else
#endif
}

+ (void)saveDebugModel:(NSInteger)mode
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:[NSNumber numberWithInteger:mode] forKey:@"debugMode"];
    [userDefaults synchronize];
}

@end
