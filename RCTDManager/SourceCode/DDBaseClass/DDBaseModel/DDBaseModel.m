//
//  DDBaseModel.m
//  DoorDuOEM
//
//  Created by matt on 2018/3/21.
//  Copyright © 2018年 广州人创天地有限公司 All rights reserved.
//

#import "DDBaseModel.h"

@implementation DDBaseModel

//返回一个 Dict，将 Model 属性名对映射到 JSON 的 Key。
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"mid" : @"id"
             };
}

// 返回容器类中的所需要存放的数据类型 (以 Class 或 Class Name 的形式)。
//+ (NSDictionary *)modelContainerPropertyGenericClass {
//    return @{@"shadows" : [Shadow class],
//             @"borders" : Border.class,
//             @"attachments" : @"Attachment" };
//}

@end
