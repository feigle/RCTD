//
//  DDHttpRequestViewController.m
//  DoorDu
//
//  Created by matt on 2018/3/21.
//  Copyright © 2018年 广州人创天地有限公司 All rights reserved.
//

#import "DDHttpRequestViewController.h"

@interface DDHttpRequestViewController ()

@end

@implementation DDHttpRequestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

/**
 *  post请求，默认含义状态栏的菊花
 *
 *  @param urlString     网址，不是全部的
 *  @param dict          字典,可以为nil
 *  @param successBlock 请求成功数据
 *  @param failureBlock 请求失败数据
 */
- (void)postWithUrlString:(NSString *)urlString parms:(NSDictionary *)dict success:(DDHttpRequestSuccessBlock)successBlock failure:(DDHttpRequestFailureBlock)failureBlock
{
    [DDHttpRequest postWithUrlString:urlString parms:[DDHttpRequest handleParametersSHA1:dict] success:successBlock failure:failureBlock];
}

/**
 *  get请求，默认含义状态栏的菊花
 *
 *  @param urlString     网址，不是全部的
 *  @param dict          字典,可以为nil
 *  @param successBlock 请求成功数据
 *  @param failureBlock 请求失败数据
 */
- (void)getWithUrlString:(NSString *)urlString parms:(NSDictionary *)dict success:(DDHttpRequestSuccessBlock)successBlock failure:(DDHttpRequestFailureBlock)failureBlock
{
    [DDHttpRequest getWithUrlString:urlString parms:[DDHttpRequest handleParametersSHA1:dict] success:successBlock failure:failureBlock];
}


/**
 *  put请求，默认含义状态栏的菊花
 *
 *  @param urlString     网址，不是全部的
 *  @param dict          字典,可以为nil
 *  @param successBlock 请求成功数据
 *  @param failureBlock 请求失败数据
 */
- (void)putWithUrlString:(NSString *)urlString parms:(NSDictionary *)dict success:(DDHttpRequestSuccessBlock)successBlock failure:(DDHttpRequestFailureBlock)failureBlock
{
    [DDHttpRequest putWithUrlString:urlString parms:[DDHttpRequest handleParametersSHA1:dict] success:successBlock failure:failureBlock];
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
