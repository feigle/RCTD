//
//  DDVersionUpdateView.h
//  DoorDuOEM
//
//  Created by 刘和东 on 2018/4/16.
//  Copyright © 2018年 深圳市多度科技有限公司. All rights reserved.
//

#import "DDBaseView.h"

@interface DDVersionUpdateView : DDBaseView

@property (nonatomic, strong) NSString * version;

/** 描述 */
@property (nonatomic, strong) NSString * remark;

/** 升级类型；0-手动升级 1-自动升级 2-强制升级 */
@property (nonatomic, strong) NSString * level;

/** 下载地址 */
@property (nonatomic, strong) NSString * download_url;


- (void)showFromView:(UIView *)fromView;

@end
