//
//  DDHttpRequest.h
//  DoorDu
//
//  Created by 刘和东 on 2017/11/15.
//  Copyright © 2017年 深圳市多度科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "DDHttpRequestCode.h"

/**
 请求数据成功,requestDict返回请求的数据,如果是列表就返回requestArray(DDHttpRequest此类不解析，默认为nil)，isFinish只有需要加载更多的时候需要,默认为YES
 */
typedef void (^DDHttpRequestSuccessBlock)(NSDictionary * requestDict,NSArray * requestArray,BOOL isFinish);

/** 请求数据失败 */
typedef void (^DDHttpRequestFailureBlock)(DDHttpRequestCode * error);

/** 网络请求，为了防止，后期不使用  AF ，便于全局替换 */
@interface DDHttpRequest : NSObject

/**
 *  post请求
 *
 *  @param urlString     网址，不是全部的
 *  @param dict          字典,可以为nil
 *  @param isNeed        是否需要状态栏的菊花
 *  @param successBlock 请求成功数据
 *  @param failureBlock 请求失败数据
 */
+ (void)postWithUrlString:(NSString *)urlString parms:(NSDictionary *)dict isNeedNetworkIndicatorVisible:(BOOL)isNeed success:(DDHttpRequestSuccessBlock)successBlock failure:(DDHttpRequestFailureBlock)failureBlock;

/**
 *  post请求，默认含义状态栏的菊花
 *
 *  @param urlString     网址，不是全部的
 *  @param dict          字典,可以为nil
 *  @param successBlock 请求成功数据
 *  @param failureBlock 请求失败数据
 */
+ (void)postWithUrlString:(NSString *)urlString parms:(NSDictionary *)dict success:(DDHttpRequestSuccessBlock)successBlock failure:(DDHttpRequestFailureBlock)failureBlock;

/**
 *  get请求
 *
 *  @param urlString     网址，不是全部的
 *  @param dict          字典,可以为nil
 *  @param isNeed        是否需要状态栏的菊花
 *  @param successBlock 请求成功数据
 *  @param failureBlock 请求失败数据
 */
+ (void)getWithUrlString:(NSString *)urlString parms:(NSDictionary *)dict isNeedNetworkIndicatorVisible:(BOOL)isNeed success:(DDHttpRequestSuccessBlock)successBlock failure:(DDHttpRequestFailureBlock)failureBlock;

/**
 *  get请求，默认含义状态栏的菊花
 *
 *  @param urlString     网址，不是全部的
 *  @param dict          字典,可以为nil
 *  @param successBlock 请求成功数据
 *  @param failureBlock 请求失败数据
 */
+ (void)getWithUrlString:(NSString *)urlString parms:(NSDictionary *)dict success:(DDHttpRequestSuccessBlock)successBlock failure:(DDHttpRequestFailureBlock)failureBlock;


/**
 *  put请求
 *
 *  @param urlString     网址，不是全部的
 *  @param dict          字典,可以为nil
 *  @param isNeed        是否需要状态栏的菊花
 *  @param successBlock 请求成功数据
 *  @param failureBlock 请求失败数据
 */
+ (void)putWithUrlString:(NSString *)urlString parms:(NSDictionary *)dict isNeedNetworkIndicatorVisible:(BOOL)isNeed success:(DDHttpRequestSuccessBlock)successBlock failure:(DDHttpRequestFailureBlock)failureBlock;

/**
 *  put请求，默认含义状态栏的菊花
 *
 *  @param urlString     网址，不是全部的
 *  @param dict          字典,可以为nil
 *  @param successBlock 请求成功数据
 *  @param failureBlock 请求失败数据
 */
+ (void)putWithUrlString:(NSString *)urlString parms:(NSDictionary *)dict success:(DDHttpRequestSuccessBlock)successBlock failure:(DDHttpRequestFailureBlock)failureBlock;


/**系统统一处理参数，加密*/
+ (NSDictionary *)handleParametersSHA1:(NSDictionary *)parameters;

/**这里统一处理错误编码，与返回的错误信息*/
+ (void)handleErrorCode:(NSInteger)errorCode errorMesage:(NSString *)errorMessage error:(NSError *)error failureBlock:(DDHttpRequestFailureBlock)failureBlock;


@end
