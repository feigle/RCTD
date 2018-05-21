//
//  UIViewController+DDGetBackBarButtonItemClicked.m
//  DoorDu
//
//  Created by 刘和东 on 2018/3/21.
//  Copyright © 2018年 深圳市多度科技有限公司. All rights reserved.
//

#import "UIViewController+DDGetBackBarButtonItemClicked.h"

@implementation UIViewController (DDGetBackBarButtonItemClicked)
@end

@implementation UINavigationController (DDGetBackBarButtonItemClicked)

- (BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPopItem:(UINavigationItem *)item {
    if([self.viewControllers count] < [navigationBar.items count]) {
        return YES;
    }
    BOOL shouldPop = YES;
    UIViewController* vc = [self topViewController];
    if([vc respondsToSelector:@selector(dd_navigationShouldPopOnBackButton)]) {
        shouldPop = [vc dd_navigationShouldPopOnBackButton];
    }
    if(shouldPop) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self popViewControllerAnimated:YES];
        });
    } else {
        for(UIView *subview in [navigationBar subviews]) {
            if(0. < subview.alpha && subview.alpha < 1.) {
                [UIView animateWithDuration:.25 animations:^{
                    subview.alpha = 1.;
                }];
            }
        }
    }
    return NO;
}

@end

