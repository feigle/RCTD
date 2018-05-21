//
//  UIDevice+DDTools.h
//  DoorDuOEM
//
//  Created by 刘和东 on 2018/4/10.
//  Copyright © 2018年 深圳市多度科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIDevice (DDTools)

@property (nullable, nonatomic, readonly) NSString *machineModel;

@property (nullable, nonatomic, readonly) NSString *machineModelName;

@end
