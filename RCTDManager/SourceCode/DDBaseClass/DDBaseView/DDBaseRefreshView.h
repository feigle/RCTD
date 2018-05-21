//
//  DDBaseRefreshView.h
//  DoorDuOEM
//
//  Created by matt on 2018/4/19.
//  Copyright © 2018年 广州人创天地有限公司 All rights reserved.
//

#import "DDBaseView.h"
#import "MJRefresh.h"

typedef void (^DDBaseRefreshViewRefreshBlock)(void);

/** 需要刷新继承的 */
@interface DDBaseRefreshView : DDBaseView

/**用于记录当前刷新的view*/
@property (nonatomic, weak) UIScrollView * superRefreshScrollView;

/**头部刷新控件*/
@property (nonatomic, strong) MJRefreshNormalHeader * headerRefreshControl;

/**尾部刷新控件*/
@property (nonatomic, strong) MJRefreshAutoNormalFooter * footerRefreshControl;

@property (nonatomic, copy) DDBaseRefreshViewRefreshBlock headerRefreshBlock;
@property (nonatomic, copy) DDBaseRefreshViewRefreshBlock footerRefreshBlock;

/** 是否加载完成 */
@property (nonatomic, assign) BOOL isFinish;

#pragma mark - 下拉刷新
/** 添加headerRefresh */
- (void)addHeaderRefresh;

/** 开启下拉刷新 */
-(void)beginHeaderRefresh;

/** 结束headerRefresh刷新 */
- (void)endHeaderRefresh;

/** 移除headerRefresh */
- (void)removeHeaderRefresh;

/** 子类下拉刷新-请求数据写在这里，子类复用 */
- (void)headerRefreshDataBlock:(DDBaseRefreshViewRefreshBlock)headerRefreshBlock;

#pragma mark - 上拉加载更多
/** 添加FootRefresh */
- (void)addFooterRefresh;

/** 开启上拉刷新 */
-(void)beginFooterRefresh;

/** 结束FootRefresh刷新 */
- (void)endFooterRefresh;

/** 移除上拉刷新 */
- (void)removeFooterRefresh;

/** 子类下拉刷新-请求数据写在这里，子类复用 */
- (void)footerRefreshDataBlock:(DDBaseRefreshViewRefreshBlock)footerRefreshBlock;

/** 提示没有更多的数据 */
- (void)endFooterRefreshNoMoreData;

/* 重置没有更多的数据（消除没有更多数据的状态） */
- (void)resetFooterRefreshNoMoreData;

/** 停止头部和尾部刷新 */
- (void)endRefresh;

@end
