//
//  DDBaseViewController.m
//  DoorDu
//
//  Created by matt on 2018/3/21.
//  Copyright © 2018年 广州人创天地有限公司 All rights reserved.
//

#import "DDBaseViewController.h"
#import "SDWebImageManager.h"

@interface DDBaseViewController ()

@end

@implementation DDBaseViewController

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self.view endEditing:YES];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = DDColorFBFAF8;
//    self.edgesForExtendedLayout = UIRectEdgeAll;
//    self.extendedLayoutIncludesOpaqueBars = YES;
    if (@available(iOS 11.0, *)){
        [UIScrollView appearance].contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        [UITableView appearance].contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        [UICollectionView appearance].contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }

}

/**
 数据回调
 */
- (void)returnObjectCallBlock:(__autoreleasing DDCallBackReturnObjectDataBlock)block
{
    self.retrunObjectBlock = block;
}

/** UI布局 */
- (void)setupConfigUI
{
    
}

/** 刷新UI */
- (void)refreshUI
{
    
}

/** 处理数据 */
- (void)handleData
{
    
}

/** 用于记录子类是否释放 */
- (void)dealloc
{
    [self _removeSubView:self.view];
    [[SDWebImageManager sharedManager].imageCache clearMemory];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    NSLog(@"\n释放_dealloc : %@ \n",NSStringFromClass([self class]));
}

- (void)_removeSubView:(UIView *)subView
{
    for (UIView * view in subView.subviews) {
        if (view.subviews) {
            [self _removeSubView:view];
        }
        [view removeFromSuperview];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    [[SDWebImageManager sharedManager].imageCache clearMemory];
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
