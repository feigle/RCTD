//
//  DoorDuContactAddressServer.h
//  DoorDuSDK
//
//  Created by DoorDu on 2018/1/13.
//  Copyright © 2018年 深圳市多度科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DoorDuContactAddressServer : NSObject


/**
 根据firstname 删除通讯录用户

 @param firstName firstName
 */
- (void)deleteMobileFromAddressBookWithFirstName:(NSString *)firstName;


/**
  创建新的联系人(不会替换已有的联系人)

 @param firstName firstName
 @param lastName lastName
 @param middleName middleName
 @param mobile mobile
 */
- (void)addNewContactWithFirstName:(NSString *)firstName
                          lastName:(NSString *)lastName
                        middleName:(NSString *)middleName
                            mobile:(NSString *)mobile;

/**
 根据名称存入电话号码(不存在则创建，存在则在已有的名称下增加电话号码)

 @param firstName firstName
 @param isClear 是否需要清除firstname为firstName的号码
 @param mobiles mobiles
 */
- (void)addMobileToContactWithFirstName:(NSString *)firstName
                                isClear:(BOOL)isClear
                                mobiles:(NSArray<NSString *> *)mobiles;

@end
