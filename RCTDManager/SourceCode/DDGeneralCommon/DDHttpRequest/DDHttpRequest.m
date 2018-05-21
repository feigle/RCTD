//
//  DDHttpRequest.m
//  DoorDu
//
//  Created by 刘和东 on 2017/11/15.
//  Copyright © 2017年 深圳市多度科技有限公司. All rights reserved.
//

#import "DDHttpRequest.h"
#import "AFNetworking.h"

@implementation DDHttpRequest

/*!
 *  获得全局唯一的网络请求实例单例方法
 */
+ (instancetype)shareBSHDHttpRequest
{
    static DDHttpRequest *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });
    return manager;
}

/*配置http请求序列化*/
+ (AFHTTPRequestSerializer *)requestSerializer
{
    AFHTTPRequestSerializer *requestSerializer = [AFHTTPRequestSerializer serializer];
    
    NSMutableDictionary *headerDic = [NSMutableDictionary dictionary];
    NSString *systemInfoString = nil;
    NSString *systemVersion = [[UIDevice currentDevice] systemVersion];
    NSString *deviceUUID = [iPhoneUUID getUUIDString];
    
    NSMutableDictionary *systemInfo = [NSMutableDictionary dictionary];
    [systemInfo setValue:DDDoorDuOEMVersion forKey:@"app_version"];
    [systemInfo setValue:systemVersion forKey:@"system_version"];
    [systemInfo setValue:[[UIDevice currentDevice] machineModelName] forKey:@"system_models"];
    [systemInfo setValue:@"1" forKey:@"system_type"];
    [systemInfo setValue:deviceUUID forKey:@"device_guid"];
    [systemInfo setValue:@"3" forKey:@"device_type"];
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:systemInfo options:0 error:nil];
    systemInfoString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    [headerDic setValue:systemInfoString forKey:@"Doordu-System"];
    
    [headerDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [requestSerializer setValue:obj forHTTPHeaderField:key];
    }];
    
    return requestSerializer;
}

+ (AFHTTPSessionManager *)sharedAFManager
{
    static AFHTTPSessionManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [AFHTTPSessionManager manager];
        
        manager.requestSerializer = [[self class] requestSerializer];
        
        /*! 设置请求超时时间 */
        manager.requestSerializer.timeoutInterval = 40;
        
        /*! 设置相应的缓存策略：此处选择不用加载也可以使用自动缓存【注：只有get方法才能用此缓存策略，NSURLRequestReturnCacheDataDontLoad】 */
        AFJSONResponseSerializer * response = [AFJSONResponseSerializer serializer];
        response.removesKeysWithNullValues = YES;
        manager.responseSerializer = response;
        manager.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
        /*! 设置返回数据为json, 分别设置请求以及相应的序列化器 */
        /*! 设置apikey ------类似于自己应用中的tokken---此处仅仅作为测试使用*/
        //        [manager.requestSerializer setValue:apikey forHTTPHeaderField:@"apikey"];
        
        /*! 复杂的参数类型 需要使用json传值-设置请求内容的类型*/
        //        [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        /*! 设置响应数据的基本了类型 */
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/css",@"text/xml",@"text/plain", @"application/javascript", nil];
        manager.responseSerializer.acceptableStatusCodes = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(100, 501)];
        
        // https  配置
        manager.securityPolicy = [self securityPolicy];
    });
    return manager;
}

/**
 *  post请求
 *
 *  @param urlString     网址，不是全部的
 *  @param dict          字典,可以为nil
 *  @param isNeed        是否需要状态栏的菊花
 *  @param successBlock 请求成功数据
 *  @param failureBlock 请求失败数据
 */
+ (void)postWithUrlString:(NSString *)urlString parms:(NSDictionary *)dict isNeedNetworkIndicatorVisible:(BOOL)isNeed success:(DDHttpRequestSuccessBlock)successBlock failure:(DDHttpRequestFailureBlock)failureBlock
{
    /**断网了，可以直接返回了*/
    if (![DDMonitorNetworkStatus isReachable]) {
        DDHttpRequestCode * errror = [[DDHttpRequestCode alloc] init];
        errror.code = DDApiStateCodeNotReachable;
        errror.message = @"暂时无网络，请确认是否连接网络";
        failureBlock(errror);
        return;
    }
    
    if (isNeed) {
        UIApplication *application = [UIApplication sharedApplication];
        application.networkActivityIndicatorVisible = YES;
    }
    urlString = [urlString utf8EncodingString];
    AFHTTPSessionManager * manager = [[self class] sharedAFManager];
    double beginTimeDate = [[NSDate date] timeIntervalSince1970] * 1000;
    
    [manager POST:urlString parameters:dict progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"uploadProgress： %f",uploadProgress.fractionCompleted);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [self __handleRequestTimePrint:urlString parms:dict beginTimeDate:beginTimeDate success:YES];
        [self __handleRequestData:responseObject task:task success:successBlock failure:failureBlock];
        if (isNeed) {
            UIApplication *application = [UIApplication sharedApplication];
            application.networkActivityIndicatorVisible = NO;
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [self __handleRequestTimePrint:urlString parms:dict beginTimeDate:beginTimeDate success:YES];
        NSHTTPURLResponse * response = (NSHTTPURLResponse *)task.response;
        NSInteger statusCode = response.statusCode;
        [self  handleErrorCode:statusCode errorMesage:@"网络连接超时" error:error failureBlock:failureBlock];
        if (isNeed) {
            UIApplication *application = [UIApplication sharedApplication];
            application.networkActivityIndicatorVisible = NO;
        }
    }];
}

/**
 *  post请求，默认含义状态栏的菊花
 *
 *  @param urlString     网址，不是全部的
 *  @param dict          字典,可以为nil
 *  @param successBlock 请求成功数据
 *  @param failureBlock 请求失败数据
 */
+ (void)postWithUrlString:(NSString *)urlString parms:(NSDictionary *)dict success:(DDHttpRequestSuccessBlock)successBlock failure:(DDHttpRequestFailureBlock)failureBlock
{
    [self postWithUrlString:urlString parms:dict isNeedNetworkIndicatorVisible:YES success:successBlock failure:failureBlock];
}

/**
 *  get请求
 *
 *  @param urlString     网址，不是全部的
 *  @param dict          字典,可以为nil
 *  @param isNeed        是否需要状态栏的菊花
 *  @param successBlock 请求成功数据
 *  @param failureBlock 请求失败数据
 */
+ (void)getWithUrlString:(NSString *)urlString parms:(NSDictionary *)dict isNeedNetworkIndicatorVisible:(BOOL)isNeed success:(DDHttpRequestSuccessBlock)successBlock failure:(DDHttpRequestFailureBlock)failureBlock
{
    
    /**断网了，可以直接返回了*/
    if (![DDMonitorNetworkStatus isReachable]) {
        DDHttpRequestCode * errror = [[DDHttpRequestCode alloc] init];
        errror.code = DDApiStateCodeNotReachable;
        errror.message = @"暂时无网络，请确认是否连接网络";
        failureBlock(errror);
        return;
    }
    
    if (isNeed) {
        UIApplication *application = [UIApplication sharedApplication];
        application.networkActivityIndicatorVisible = YES;
    }
    urlString = [urlString utf8EncodingString];
    AFHTTPSessionManager * manager = [[self class] sharedAFManager];
    double beginTimeDate = [[NSDate date] timeIntervalSince1970] * 1000;
    
    [manager GET:urlString parameters:dict progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"uploadProgress： %f",uploadProgress.fractionCompleted);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [self __handleRequestTimePrint:urlString parms:dict beginTimeDate:beginTimeDate success:YES];
        [self __handleRequestData:responseObject task:task success:successBlock failure:failureBlock];
        if (isNeed) {
            UIApplication *application = [UIApplication sharedApplication];
            application.networkActivityIndicatorVisible = NO;
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [self __handleRequestTimePrint:urlString parms:dict beginTimeDate:beginTimeDate success:YES];
        NSHTTPURLResponse * response = (NSHTTPURLResponse *)task.response;
        NSInteger statusCode = response.statusCode;
        [self handleErrorCode:statusCode errorMesage:@"网络连接超时" error:error failureBlock:failureBlock];
        if (isNeed) {
            UIApplication *application = [UIApplication sharedApplication];
            application.networkActivityIndicatorVisible = NO;
        }
    }];
}

/**
 *  get请求，默认含义状态栏的菊花
 *
 *  @param urlString     网址，不是全部的
 *  @param dict          字典,可以为nil
 *  @param successBlock 请求成功数据
 *  @param failureBlock 请求失败数据
 */
+ (void)getWithUrlString:(NSString *)urlString parms:(NSDictionary *)dict success:(DDHttpRequestSuccessBlock)successBlock failure:(DDHttpRequestFailureBlock)failureBlock
{
    [self getWithUrlString:urlString parms:dict isNeedNetworkIndicatorVisible:YES success:successBlock failure:failureBlock];
}


/**
 *  put请求
 *
 *  @param urlString     网址，不是全部的
 *  @param dict          字典,可以为nil
 *  @param isNeed        是否需要状态栏的菊花
 *  @param successBlock 请求成功数据
 *  @param failureBlock 请求失败数据
 */
+ (void)putWithUrlString:(NSString *)urlString parms:(NSDictionary *)dict isNeedNetworkIndicatorVisible:(BOOL)isNeed success:(DDHttpRequestSuccessBlock)successBlock failure:(DDHttpRequestFailureBlock)failureBlock
{
    /**断网了，可以直接返回了*/
    if (![DDMonitorNetworkStatus isReachable]) {
        DDHttpRequestCode * errror = [[DDHttpRequestCode alloc] init];
        errror.code = DDApiStateCodeNotReachable;
        errror.message = @"暂时无网络，请确认是否连接网络";
        failureBlock(errror);
        return;
    }
    
    if (isNeed) {
        UIApplication *application = [UIApplication sharedApplication];
        application.networkActivityIndicatorVisible = YES;
    }
    urlString = [urlString utf8EncodingString];
    AFHTTPSessionManager * manager = [[self class] sharedAFManager];
    double beginTimeDate = [[NSDate date] timeIntervalSince1970] * 1000;
    
    [manager PUT:urlString parameters:dict success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [self __handleRequestTimePrint:urlString parms:dict beginTimeDate:beginTimeDate success:YES];
        [self __handleRequestData:responseObject task:task success:successBlock failure:failureBlock];
        if (isNeed) {
            UIApplication *application = [UIApplication sharedApplication];
            application.networkActivityIndicatorVisible = NO;
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [self __handleRequestTimePrint:urlString parms:dict beginTimeDate:beginTimeDate success:NO];
        NSHTTPURLResponse * response = (NSHTTPURLResponse *)task.response;
        NSInteger statusCode = response.statusCode;
        [self handleErrorCode:statusCode errorMesage:@"网络连接超时" error:error failureBlock:failureBlock];
        if (isNeed) {
            UIApplication *application = [UIApplication sharedApplication];
            application.networkActivityIndicatorVisible = NO;
        }
    }];
}

/**
 *  put请求，默认含义状态栏的菊花
 *
 *  @param urlString     网址，不是全部的
 *  @param dict          字典,可以为nil
 *  @param successBlock 请求成功数据
 *  @param failureBlock 请求失败数据
 */
+ (void)putWithUrlString:(NSString *)urlString parms:(NSDictionary *)dict success:(DDHttpRequestSuccessBlock)successBlock failure:(DDHttpRequestFailureBlock)failureBlock
{
    [self putWithUrlString:urlString parms:dict isNeedNetworkIndicatorVisible:YES success:successBlock failure:failureBlock];
}

#pragma mark - 统一数据处理
+ (void)__handleRequestData:(id)responseObject task:(NSURLSessionDataTask *)task success:(DDHttpRequestSuccessBlock)successBlock failure:(DDHttpRequestFailureBlock)failureBlock
{
    NSHTTPURLResponse * response = (NSHTTPURLResponse *)task.response;
    NSInteger statusCode = response.statusCode;
    NSDictionary * dataDict = responseObject;
    if (![responseObject isKindOfClass:[NSDictionary class]]) {//不是字典
        if ([responseObject isKindOfClass:[NSData class]]) {//判断是不是二进制文件
            //是二进制文件进行序列化
            dataDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        }
    }
    //返回数据
    if (statusCode == 200) {//代表操作成功
        if ([dataDict isKindOfClass:NSDictionary.class]) {//是字典
            NSString * code = [dataDict[@"code"] toString];
            if ([code integerValue] == 200) {//成功
                successBlock(dataDict,nil,YES);
            } else {//错误
                [[self class] handleErrorCode:[[dataDict[@"code"] toString] integerValue] errorMesage:dataDict[@"message"] error:nil failureBlock:failureBlock];
            }
        } else {//参数错误
            [[self class] handleErrorCode:statusCode errorMesage:@"网络连接超时" error:nil failureBlock:failureBlock];
        }
    } else {//失败，统一操作
        if ([dataDict isKindOfClass:[NSDictionary class]]) {
            if ([dataDict.allKeys containsObject:@"code"]) {//失败需要统一处理错误
                [[self class] handleErrorCode:[[dataDict[@"code"] toString] integerValue] errorMesage:dataDict[@"message"] error:nil failureBlock:failureBlock];
            } else {
                [[self class] handleErrorCode:statusCode errorMesage:@"网络连接超时" error:nil failureBlock:failureBlock];
            }
        } else {
            //不是字典，返回其他的数据类型
            [[self class] handleErrorCode:statusCode errorMesage:@"网络连接超时" error:nil failureBlock:failureBlock];
        }
    }
}

/**
 打印   接口地址  和  请求用时
 */
+ (void)__handleRequestTimePrint:(NSString *)urlString parms:(NSDictionary *)dict beginTimeDate:(double)beginTimeDate success:(BOOL)success
{
    /**测试环境*/
#ifdef DEBUG
    double endTimeDate = [[NSDate date] timeIntervalSince1970] * 1000;
    /**requestTime  这里是毫秒*/
    double requestTime = endTimeDate - beginTimeDate;
    /**这里是秒*/
    double secondTime = requestTime/1000;
    NSMutableString * requestStr = [NSMutableString new];
    [requestStr appendFormat:@"%@",urlString];
    int i = 0;
    for (NSString * key in dict.allKeys) {
        id value = dict[key];
        if (i==0)
        [requestStr appendFormat:@"?%@=%@",key,value];
        else
        [requestStr appendFormat:@"&%@=%@",key,value];
        i++;
    }
    if (success) {
        NSLog(@"\n\n\n请求( 成功 )时间 ：\n\n请求网址：\n\n%@\n\n响应时间(秒)：\n\n%lf \n\n\n",requestStr,secondTime);
    } else {
        NSLog(@"\n\n\n请求( 失败 )时间 ：\n\n请求网址：\n\n%@\n\n响应时间(秒)：\n\n%lf \n\n\n",requestStr,secondTime);
    }
#else
#endif
    
}

/**公共参数处理*/
+ (NSMutableDictionary *)_commonParametersHandle:(NSDictionary *)parameters
{
    NSMutableDictionary * dict = [self getCommonParameters];
    if (parameters) {
        if ([parameters isKindOfClass:[NSDictionary class]]) {
            [dict addEntriesFromDictionary:parameters];
        }
    }
    return dict;
}
/**返回统一的编码*/
+ (NSMutableDictionary *)getCommonParameters
{
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval val = [date timeIntervalSince1970];
    NSString *timestamp = [NSString stringWithFormat:@"%0.f", val];
    dict[@"timestamp"] = timestamp;
    DDCurrentUserDataModel * userModel = currentUserModel;
    if (userModel.openId) {
        dict[@"open_id"] = userModel.openId;
    }
    return dict;
}

/**系统统一处理参数，加密*/
+ (NSDictionary *)handleParametersSHA1:(NSDictionary *)parameters;
{
    NSMutableDictionary * dict = [[self class] _commonParametersHandle:parameters];
    NSArray * allKeys = dict.allKeys;
    NSArray * sortArray = [allKeys sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 compare:obj2];
    }];
    NSMutableString * requestStr = [NSMutableString new];
    NSMutableDictionary * newDict = [NSMutableDictionary dictionary];
    for (NSString * key in sortArray) {
        NSString * newKey = [key removeBlank];//除去空格
        id value = dict[key];
        id newValue = value;
        if ([value isKindOfClass:[NSString class]]) {
            newValue = [(NSString *)value removeBlank];//除去空格
        }
        [newDict setObject:newValue forKey:newKey];
        [requestStr appendFormat:@"%@=%@",newKey,newValue];
        if (![key isEqualToString:sortArray.lastObject]) {//最后一个
            [requestStr appendFormat:@"&"];
        }
    }
    NSString * base64SingStr = [requestStr base64EncodedString];
    NSString * base64Str = [NSString stringWithFormat:@"%@%@",base64SingStr,DDHttpRequestSecretKey];
    NSString * shaStrrr = [base64Str SHA1];
    dict[@"sign"] = shaStrrr;
    return dict;
}

/**增加 https 证书验证*/
+ (AFSecurityPolicy *)securityPolicy
{
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
    securityPolicy.allowInvalidCertificates = YES;
    securityPolicy.validatesDomainName = NO;
    return securityPolicy;
    //    NSString * cerPath = [[NSBundle mainBundle] pathForResource:@"" ofType:@""];
    //    NSData * certData = [NSData dataWithContentsOfFile:cerPath];
    //    AFSecurityPolicy * securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    //    securityPolicy.allowInvalidCertificates = YES;
    //    securityPolicy.validatesDomainName = NO;
    //    securityPolicy.pinnedCertificates = [NSSet setWithObject:certData];
    //    return securityPolicy;
}

/**这里统一处理错误编码，与返回的错误信息*/
+ (void)handleErrorCode:(NSInteger)errorCode errorMesage:(NSString *)errorMessage error:(NSError *)error failureBlock:(DDHttpRequestFailureBlock)failureBlock
{
    DDHttpRequestCode * errror = [[DDHttpRequestCode alloc] init];
    errror.code = errorCode;
    switch (errorCode) {
            case DDApiStateCodeNotReachable:
        {////当前网络不可用，请检查您的网络设置
            errror.message = @"当前网络不可用";
        }
            break;
            case DDApiStateCode400:
        {//请求失败，response body中会包含具体错误码
            errror.message = @"请求失败，请重试";
        }
            break;
            case DDApiStateCode401:
        {//认证失败
            errror.message = errorMessage;
        }
            break;
            case DDApiStateCode403:
        {//无权访问（例如操作其他sdk下的用户）
            errror.message = errorMessage;
        }
            break;
            case DDApiStateCode404:
        {//未找到资源
            errror.message = @"服务器异常，请重试";
        }
            break;
            case DDApiStateCode426:
        {//需要用户重新登录
            errror.message = errorMessage;
            //            BSHProjectAssistantUser * userModel = currentUserModel;
            //            userModel.indentifyType = ProjectAssistantNoLoginType;
            //            [BSHProjectAssistantUser saveMySelf];
            //            [BSHProjectAssistantUser loginStateChange];
        }
            break;
            case DDApiStateCode500:
        {//服务器内部出错
            errror.message = @"服务器异常，请重试";
        }
            break;
        default:
        {
            errror.message = errorMessage;
        }
            break;
    }
    NSLog(@"错误提示：%ld,%@",errror.code,errror.message);
    if (errror.message) {
        
    }
    if (failureBlock) {
        failureBlock(errror);
    }
}


@end
