//
//  DDScrollViewController.m
//  DoorDu
//
//  Created by matt on 2018/3/21.
//  Copyright © 2018年 广州人创天地有限公司 All rights reserved.
//

#import "DDScrollViewController.h"

@interface DDScrollViewController ()

@end

@implementation DDScrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, kNavigationHeight, kScreenWidth, kScreenHeight-kNavigationHeight)];
        if (self.view.backgroundColor) {
            _scrollView.backgroundColor = self.view.backgroundColor;
        } else {
            _scrollView.backgroundColor = [UIColor whiteColor];
        }
        self.superRefreshScrollView = _scrollView;
    }
    return _scrollView;
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
