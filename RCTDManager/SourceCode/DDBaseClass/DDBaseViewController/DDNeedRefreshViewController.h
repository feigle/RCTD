//
//  DDNeedRefreshViewController.h
//  DoorDu
//
//  Created by matt on 2018/3/21.
//  Copyright © 2018年 广州人创天地有限公司 All rights reserved.
//

#import "DDHttpRequestViewController.h"
#import "MJRefresh.h"

/** 设置默认起始页码 */
#define DoorDuFirstPageNumber 1

@interface DDNeedRefreshViewController : DDHttpRequestViewController

@property (nonatomic,strong) NSMutableArray *dataArray;

/**用于记录当前刷新的view*/
@property (nonatomic,weak) UIScrollView * superRefreshScrollView;

/**头部刷新控件*/
@property (nonatomic,strong) MJRefreshNormalHeader * headerRefreshControl;

/**尾部刷新控件*/
@property (nonatomic,strong) MJRefreshAutoNormalFooter * footerRefreshControl;

/** 起始页 默认 DoorDuFirstPageNumber */
@property (nonatomic,assign) NSInteger page;

/** 每页 默认20 */
@property (nonatomic,assign) NSInteger pagesize;

/** 数据总数，暂时没有用到 */
@property (nonatomic,assign) NSInteger dataTotal;


/* 是否加载到了最后一页，最后一页为YES，默认为NO,暂时没有用到 */
@property (nonatomic,assign) BOOL isFinish;


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
- (void)headerRefresh;

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
- (void)footerRefresh;

/** 提示没有更多的数据 */
- (void)endFooterRefreshNoMoreData;

/* 重置没有更多的数据（消除没有更多数据的状态） */
- (void)resetFooterRefreshNoMoreData;

/** 停止头部和尾部刷新 */
- (void)endRefresh;


@end
