//
//  DDHttpRequestViewController.h
//  DoorDu
//
//  Created by matt on 2018/3/21.
//  Copyright © 2018年 广州人创天地有限公司 All rights reserved.
//

#import "DDHandleNavigationBarViewController.h"
#import "DDHttpRequest.h"

/** 带有数据请求刷新的逻辑 */
@interface DDHttpRequestViewController : DDHandleNavigationBarViewController

/**
 *  post请求，默认含义状态栏的菊花
 *
 *  @param urlString     网址，不是全部的
 *  @param dict          字典,可以为nil
 *  @param successBlock 请求成功数据
 *  @param failureBlock 请求失败数据
 */
- (void)postWithUrlString:(NSString *)urlString parms:(NSDictionary *)dict success:(DDHttpRequestSuccessBlock)successBlock failure:(DDHttpRequestFailureBlock)failureBlock;

/**
 *  get请求，默认含义状态栏的菊花
 *
 *  @param urlString     网址，不是全部的
 *  @param dict          字典,可以为nil
 *  @param successBlock 请求成功数据
 *  @param failureBlock 请求失败数据
 */
- (void)getWithUrlString:(NSString *)urlString parms:(NSDictionary *)dict success:(DDHttpRequestSuccessBlock)successBlock failure:(DDHttpRequestFailureBlock)failureBlock;

/**
 *  put请求，默认含义状态栏的菊花
 *
 *  @param urlString     网址，不是全部的
 *  @param dict          字典,可以为nil
 *  @param successBlock 请求成功数据
 *  @param failureBlock 请求失败数据
 */
- (void)putWithUrlString:(NSString *)urlString parms:(NSDictionary *)dict success:(DDHttpRequestSuccessBlock)successBlock failure:(DDHttpRequestFailureBlock)failureBlock;


@end
