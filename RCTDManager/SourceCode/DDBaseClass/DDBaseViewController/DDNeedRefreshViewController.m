//
//  DDNeedRefreshViewController.m
//  DoorDu
//
//  Created by matt on 2018/3/21.
//  Copyright © 2018年 广州人创天地有限公司 All rights reserved.
//

#import "DDNeedRefreshViewController.h"

@interface DDNeedRefreshViewController ()

@property (nonatomic, assign) BOOL isNeedHeaderRefresh;
@property (nonatomic, assign) BOOL isNeedFooterRefresh;

@end

@implementation DDNeedRefreshViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.page = DoorDuFirstPageNumber;
        self.pagesize = 20;
        self.dataTotal = 99999;
        self.isFinish = NO;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
}

#pragma mark - 完善父类方法

/**
 *  post请求，默认含义状态栏的菊花
 */
- (void)postWithUrlString:(NSString *)urlString parms:(NSDictionary *)dict success:(DDHttpRequestSuccessBlock)successBlock failure:(DDHttpRequestFailureBlock)failureBlock
{
    WeakSelf
    [super postWithUrlString:urlString parms:dict success:^(NSDictionary *requestDict,NSArray * requestArray,BOOL isFinish) {
        StrongSelf
        /** 结束刷新 */
        [strongSelf endRefresh];
        /** 判断是否是列表 */
        if ([requestDict.allKeys containsObject:@"list"]) {
            BOOL isFinish = NO;
            NSArray * dataArray = requestDict[@"list"];
#pragma mark - 没有数据了，这里有问题，万一最后一页也是  strongSelf.pagesize，还需要再请求一次
            if (dataArray.count < strongSelf.pagesize) {//没有数据了，这里有问题，万一最后一页也是  strongSelf.pagesize，还需要再请求一次
                [strongSelf endFooterRefreshNoMoreData];
                isFinish = YES;
            } else if (dataArray.count > strongSelf.pagesize){//这里不带有分页的情况,没有用到self.pagesize的时候
                [strongSelf endFooterRefreshNoMoreData];
                isFinish = YES;
            } else {//说明还有数据，可以继续刷新
                [strongSelf resetFooterRefreshNoMoreData];
            }
            successBlock(requestDict,dataArray,isFinish);
        } else {
            successBlock(requestDict,nil,YES);
        }
    } failure:^(DDHttpRequestCode *error) {
        StrongSelf;
        /** 结束刷新 */
        [strongSelf endRefresh];
        if (strongSelf.page > DoorDuFirstPageNumber ) {
            strongSelf.page--;/**失败之后需要减去  1 */
        }
        failureBlock(error);
    }];
    
}

/**
 *  get请求，默认含义状态栏的菊花
 */
- (void)getWithUrlString:(NSString *)urlString parms:(NSDictionary *)dict success:(DDHttpRequestSuccessBlock)successBlock failure:(DDHttpRequestFailureBlock)failureBlock
{
    WeakSelf
    [super getWithUrlString:urlString parms:dict success:^(NSDictionary *requestDict,NSArray * requestArray,BOOL isFinish) {
        StrongSelf
        /** 结束刷新 */
        [strongSelf endRefresh];
        /** 判断是否是列表 */
        if ([requestDict.allKeys containsObject:@"list"]) {
            BOOL isFinish = NO;
            NSArray * dataArray = requestDict[@"list"];
#pragma mark - 没有数据了，这里有问题，万一最后一页也是  strongSelf.pagesize，还需要再请求一次
            if (dataArray.count < strongSelf.pagesize) {//没有数据了，这里有问题，万一最后一页也是  strongSelf.pagesize，还需要再请求一次
                [strongSelf endFooterRefreshNoMoreData];
                isFinish = YES;
            } else if (dataArray.count > strongSelf.pagesize){//这里不带有分页的情况,没有用到self.pagesize的时候
                [strongSelf endFooterRefreshNoMoreData];
                isFinish = YES;
            } else {//说明还有数据，可以继续刷新
                [strongSelf resetFooterRefreshNoMoreData];
            }
            successBlock(requestDict,dataArray,isFinish);
        } else {
            successBlock(requestDict,nil,YES);
        }
    } failure:^(DDHttpRequestCode *error) {
        StrongSelf;
        /** 结束刷新 */
        [strongSelf endRefresh];
        if (strongSelf.page > DoorDuFirstPageNumber ) {
            strongSelf.page--;/**失败之后需要减去  1 */
        }
        failureBlock(error);
    }];
}


/**
 *  put请求，默认含义状态栏的菊花
 */
- (void)putWithUrlString:(NSString *)urlString parms:(NSDictionary *)dict success:(DDHttpRequestSuccessBlock)successBlock failure:(DDHttpRequestFailureBlock)failureBlock
{
    WeakSelf
    [super putWithUrlString:urlString parms:dict success:^(NSDictionary *requestDict,NSArray * requestArray,BOOL isFinish) {
        StrongSelf
        /** 结束刷新 */
        [strongSelf endRefresh];
        /** 判断是否是列表 */
        if ([requestDict.allKeys containsObject:@"list"]) {
            BOOL isFinish = NO;
            NSArray * dataArray = requestDict[@"list"];
#pragma mark - 没有数据了，这里有问题，万一最后一页也是  strongSelf.pagesize，还需要再请求一次
            if (dataArray.count < strongSelf.pagesize) {//没有数据了，这里有问题，万一最后一页也是  strongSelf.pagesize，还需要再请求一次
                [strongSelf endFooterRefreshNoMoreData];
                isFinish = YES;
            } else if (dataArray.count > strongSelf.pagesize){//这里不带有分页的情况,没有用到self.pagesize的时候
                [strongSelf endFooterRefreshNoMoreData];
                isFinish = YES;
            } else {//说明还有数据，可以继续刷新
                [strongSelf resetFooterRefreshNoMoreData];
            }
            successBlock(requestDict,dataArray,isFinish);
        } else {
            successBlock(requestDict,nil,YES);
        }
    } failure:^(DDHttpRequestCode *error) {
        StrongSelf;
        /** 结束刷新 */
        [strongSelf endRefresh];
        if (strongSelf.page > DoorDuFirstPageNumber ) {
            strongSelf.page--;/**失败之后需要减去  1 */
        }
        failureBlock(error);
    }];
}


#pragma mark - 下拉刷新
/** 添加headerRefresh */
- (void)addHeaderRefresh
{
    self.isNeedHeaderRefresh = YES;
    if (self.superRefreshScrollView) {
        self.superRefreshScrollView.mj_header = self.headerRefreshControl;
    } else {
        NSLog(@"请先添加 可以刷新的 view");
    }
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
- (void)headerRefresh
{
    self.page = DoorDuFirstPageNumber;
    self.isFinish = NO;
    if (self.superRefreshScrollView.mj_footer) {
        [self.superRefreshScrollView.mj_footer removeFromSuperview];
        self.superRefreshScrollView.mj_footer = nil;
    }
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
- (void)footerRefresh
{
    self.page ++;
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
            //没有添加,添加上
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


#pragma mark - 懒加载
/**存储数据源*/
- (NSMutableArray*)dataArray
{
    if (!_dataArray) {
        _dataArray=[NSMutableArray new];
    }
    return _dataArray;
}
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
    [self headerRefresh];
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
    [self footerRefresh];
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
