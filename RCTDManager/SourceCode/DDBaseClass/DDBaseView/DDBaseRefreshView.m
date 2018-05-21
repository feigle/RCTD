//
//  DDBaseRefreshView.m
//  DoorDuOEM
//
//  Created by matt on 2018/4/19.
//  Copyright © 2018年 广州人创天地有限公司 All rights reserved.
//

#import "DDBaseRefreshView.h"

@interface DDBaseRefreshView ()

@property (nonatomic, assign) BOOL isNeedHeaderRefresh;
@property (nonatomic, assign) BOOL isNeedFooterRefresh;

@end

@implementation DDBaseRefreshView

#pragma mark - 下拉刷新
/** 添加headerRefresh */
- (void)addHeaderRefresh
{
    self.isNeedHeaderRefresh = YES;
    self.superRefreshScrollView.mj_header = self.headerRefreshControl;
}

/** 开启下拉刷新 */
-(void)beginHeaderRefresh
{
    if (!self.headerRefreshControl.isRefreshing) {
        [self.headerRefreshControl beginRefreshing];
    }
}

/** 结束headerRefresh刷新 */
- (void)endHeaderRefresh
{
    if (self.headerRefreshControl.isRefreshing) {
        [self.headerRefreshControl endRefreshing];
    }
}

/** 移除headerRefresh */
- (void)removeHeaderRefresh
{
    [self endHeaderRefresh];
    [self.headerRefreshControl removeFromSuperview];
    self.superRefreshScrollView.mj_header = nil;
    self.isNeedHeaderRefresh = NO;
    _headerRefreshControl = nil;
}

/** 子类下拉刷新-请求数据写在这里，子类复用 */
- (void)headerRefreshDataBlock:(DDBaseRefreshViewRefreshBlock)headerRefreshBlock
{
    self.headerRefreshBlock = headerRefreshBlock;
}

#pragma mark - 上拉加载更多
/** 添加FootRefresh */
- (void)addFooterRefresh
{
    self.isNeedFooterRefresh = YES;
}

/** 开启上拉刷新 */
-(void)beginFooterRefresh
{
    if (!self.footerRefreshControl.isRefreshing) {
        [self.footerRefreshControl beginRefreshing];
    }
}

/** 结束FootRefresh刷新 */
- (void)endFooterRefresh
{
    if (self.footerRefreshControl.isRefreshing) {
        [self.footerRefreshControl endRefreshing];
    }
}

/** 移除上拉刷新 */
- (void)removeFooterRefresh
{
    [self endFooterRefresh];
    self.isNeedFooterRefresh = NO;
    [self.footerRefreshControl removeFromSuperview];
    [self.superRefreshScrollView.mj_footer removeFromSuperview];
    self.superRefreshScrollView.mj_footer = nil;
    _footerRefreshControl = nil;
}

/** 子类下拉刷新-请求数据写在这里，子类复用 */
- (void)footerRefreshDataBlock:(DDBaseRefreshViewRefreshBlock)footerRefreshBlock
{
    self.footerRefreshBlock = footerRefreshBlock;
}

/** 提示没有更多的数据 */
- (void)endFooterRefreshNoMoreData
{
    [self __endRequestCheckFooterRefreshShow];
    if (self.isNeedFooterRefresh) {
        [self.footerRefreshControl endRefreshingWithNoMoreData];
    }
}

/* 重置没有更多的数据（消除没有更多数据的状态） */
- (void)resetFooterRefreshNoMoreData
{
    [self __endRequestCheckFooterRefreshShow];
    if (self.isNeedFooterRefresh) {
        [self.footerRefreshControl resetNoMoreData];
    }
}
/** 检测是否需要添加footerRefresh控件，这样写是为了防止一开始显示footerRefresh */
- (void)__endRequestCheckFooterRefreshShow
{
    if (self.isNeedFooterRefresh) {
        if (!self.superRefreshScrollView.mj_footer) {//判断是否已经添加了
            //没有添加
            self.superRefreshScrollView.mj_footer = self.footerRefreshControl;
        }
    }
}

/** 停止头部和尾部刷新 */
- (void)endRefresh
{
    [self endHeaderRefresh];
    [self endFooterRefresh];
}

/** 是否加载完成 */
- (void)setIsFinish:(BOOL)isFinish
{
    _isFinish = isFinish;
    [self endRefresh];
    if (self.isNeedFooterRefresh) {
        if (isFinish) {//没有数据了
            [self endFooterRefreshNoMoreData];
        } else {//有数据
            [self resetFooterRefreshNoMoreData];
        }
    }
}

#pragma mark - 懒加载
/**头部刷新控件*/
- (MJRefreshNormalHeader *)headerRefreshControl
{
    if (!_headerRefreshControl) {
        _headerRefreshControl = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(__headerRefreshData)];
        _headerRefreshControl.lastUpdatedTimeLabel.hidden = YES;
    }
    return _headerRefreshControl;
}

- (void)__headerRefreshData
{
    [self headerRefreshDataBlock:self.headerRefreshBlock];
    if (self.headerRefreshBlock) {
        self.headerRefreshBlock();
    }
}

- (MJRefreshAutoNormalFooter *)footerRefreshControl
{
    if (!_footerRefreshControl) {
        _footerRefreshControl = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(__footRefreshData)];
        _footerRefreshControl.stateLabel.textColor = ColorHex(CFCFCF);
        _footerRefreshControl.stateLabel.font = [UIFont systemFontOfSize:24/2.0];
    }
    return _footerRefreshControl;
}
- (void)__footRefreshData
{
    if (self.footerRefreshBlock) {
        self.footerRefreshBlock();
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
