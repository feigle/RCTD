//
//  DDHttpRequestCode.h
//  DoorDu
//
//  Created by 刘和东 on 2017/11/15.
//  Copyright © 2017年 深圳市多度科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark - 返回的  请求状态码
typedef NS_ENUM(NSInteger, DDApiStateCode) {
    
    DDApiStateCodeNotReachable     = -1009,//当前网络不可用，请检查您的网络设置
    
    DDApiStateCode0 = 0,//服务器链接错误
    DDApiStateCode200 = 200,//成功
    DDApiStateCode400 = 400,//请求失败，response body中会包含具体错误码
    DDApiStateCode401 = 401,//认证失败
    DDApiStateCode403 = 403,//无权访问（例如操作其他sdk下的用户）
    DDApiStateCode404 = 404,//未找到资源
    DDApiStateCode426 = 426,//需要用户重新登录
    DDApiStateCode500 = 500,//服务器内部出错
    
};

@interface DDHttpRequestCode : NSObject

@property (nonatomic,copy) NSString * message;

@property (nonatomic,assign) DDApiStateCode code;

@end
