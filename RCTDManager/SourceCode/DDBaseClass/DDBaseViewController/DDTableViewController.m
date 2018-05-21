//
//  DDTableViewController.m
//  DoorDu
//
//  Created by matt on 2018/3/21.
//  Copyright © 2018年 广州人创天地有限公司 All rights reserved.
//

#import "DDTableViewController.h"

@interface DDTableViewController ()

@end

@implementation DDTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)setTableViewStyle:(UITableViewStyle)tableViewStyle
{
    if (tableViewStyle==UITableViewStylePlain) {
        return;
    }else{
        UIView * superView = _tableView.superview;
        CGRect tableRect = CGRectMake(0, kNavigationHeight, kScreenWidth, kScreenHeight-kNavigationHeight);
        if (superView) {
            tableRect = _tableView.frame;
        }
        [_tableView removeFromSuperview];
        _tableView = nil;
        _tableView = [self _createTableViewWithStyle:UITableViewStyleGrouped];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        if (superView) {
            [superView addSubview:_tableView];
        }
        self.superRefreshScrollView = _tableView;
    }
}

- (UITableView*)tableView
{
    if (_tableView==nil) {
        _tableView = [self _createTableViewWithStyle:UITableViewStylePlain];
    }
    return _tableView;
}

- (UITableView *)_createTableViewWithStyle:(UITableViewStyle)style
{
    UITableView * tView=[[UITableView alloc]initWithFrame:CGRectMake(0, kNavigationHeight, kScreenWidth, kScreenHeight-kNavigationHeight) style:style];
    tView.delegate=self;
    tView.dataSource=self;
    tView.estimatedRowHeight = 0;
    tView.estimatedSectionHeaderHeight = 0;
    tView.estimatedSectionFooterHeight = 0;
    if (self.view.backgroundColor) {
        tView.backgroundColor = self.view.backgroundColor;
    } else {
        tView.backgroundColor = [UIColor whiteColor];
    }
    tView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, CGFLOAT_MIN)];
    tView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, CGFLOAT_MIN)];
    self.superRefreshScrollView = tView;
    return tView;
}

#pragma mark- tableview

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TableViewController"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TableViewController"];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_tableView.separatorStyle == UITableViewCellSeparatorStyleNone) {
        return;
    }
    // 下面这几行代码是用来设置cell的上下行线的位置
//    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
//        [cell setSeparatorInset:UIEdgeInsetsZero];
//    }
//    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
//        [cell setLayoutMargins:UIEdgeInsetsZero];
//    }
//    if([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]){
//        [cell setPreservesSuperviewLayoutMargins:NO];
//    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
