//
//  DoorDuContactAddressServer.m
//  DoorDuSDK
//
//  Created by DoorDu on 2018/1/13.
//  Copyright © 2018年 深圳市多度科技有限公司. All rights reserved.
//

#import "DoorDuContactAddressServer.h"
#import <AddressBook/AddressBook.h>

@implementation DoorDuContactAddressServer

- (void)deleteMobileFromAddressBookWithFirstName:(NSString *)firstName
{
    /** 检查通讯录权限 */
    ABAddressBookRequestAccessWithCompletion(ABAddressBookCreateWithOptions(NULL, NULL), ^(bool granted, CFErrorRef error) {
        
        if (granted) {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                [self deleteMobileFromAddressBookWithFirstNameMethod:firstName];
            });
        }
    });
}

- (void)deleteMobileFromAddressBookWithFirstNameMethod:(NSString *)firstName {
    
    if (!firstName || !firstName.length) {
        return;
    }
    
    /** 获取通讯录中所有的联系人 */
    ABAddressBookRef addressBook = ABAddressBookCreate();
    NSArray *array = (NSArray *)CFBridgingRelease(ABAddressBookCopyArrayOfAllPeople(addressBook));
    
    /** 遍历所有的联系人并删除 */
    for (id obj in array) {
        ABRecordRef people = (ABRecordRef)CFBridgingRetain(obj);
        NSString *firstRecordName = (NSString *)CFBridgingRelease(ABRecordCopyValue(people, kABPersonFirstNameProperty));
        if ([firstRecordName isEqualToString:firstName]) {
            ABAddressBookRemoveRecord(addressBook, people, NULL);
        }
    }
    
    /** 保存修改的通讯录对象 */
    ABAddressBookSave(addressBook, NULL);
    
    /** 释放通讯录对象的内存 */
    if (addressBook) {
        CFRelease(addressBook);
    }
}

- (void)addNewContactWithFirstName:(NSString *)firstName
                          lastName:(NSString *)lastName
                        middleName:(NSString *)middleName
                            mobile:(NSString *)mobile
{
    /** 检查通讯录权限 */
    ABAddressBookRequestAccessWithCompletion(ABAddressBookCreateWithOptions(NULL, NULL), ^(bool granted, CFErrorRef error) {
        if (granted) {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                [self addNewContactWithFirstNameMethod:firstName
                                                        lastName:lastName
                                                      middleName:middleName
                                                          mobile:mobile];
            });
        }
    });
}

- (void)addNewContactWithFirstNameMethod:(NSString *)firstName
                                lastName:(NSString *)lastName
                              middleName:(NSString *)middleName
                                  mobile:(NSString *)mobile {
    
    if (!mobile
        || !mobile.length
        || (!firstName && !lastName && !middleName)
        || (!firstName.length && !lastName.length && !middleName.length)) {
        
        return;
    }
    
    ABAddressBookRef iPhoneAddressBook = ABAddressBookCreate();
    CFArrayRef arrRef = ABAddressBookCopyPeopleWithName(iPhoneAddressBook, (__bridge CFStringRef)(firstName));
    
    /**
     * 如果通讯路中已经存在这个联系人  那么数组里面有元素
     * __bridge_transfer -> 使用ARC接管CF类型对象的内存
     */
    NSArray *arr = (__bridge_transfer NSArray *)arrRef;
    NSMutableString *name = [NSMutableString string];
    if (firstName) {
        if ([firstName isKindOfClass:[NSString class]]) {
            [name appendString:firstName];
        }
    }
    
    if (middleName) {
        if ([middleName isKindOfClass:[NSString class]]) {
            [name appendString:middleName];
        }
    }
    
    if (lastName) {
        if ([lastName isKindOfClass:[NSString class]]) {
            [name appendString:lastName];
        }
    }
    
    /** 如果名字为空，返回 */
    if (name.length == 0) {
        return;
    }
    
    for (int i = 0; i < arr.count; i++) {
        
        /** 获取名称 */
        ABRecordRef record = (__bridge ABRecordRef)[arr objectAtIndex:i];
        NSString *firstRecordName   = (__bridge_transfer NSString *)ABRecordCopyValue(record, kABPersonFirstNameProperty);
        NSString *lastRecordName    = (__bridge_transfer NSString *)ABRecordCopyValue(record, kABPersonLastNameProperty);
        NSString *middleRecordName  = (__bridge_transfer NSString *)ABRecordCopyValue(record, kABPersonMiddleNameProperty);
        
        NSMutableString *recordName = [NSMutableString stringWithFormat:@""];
        if (firstRecordName) {
            if ([firstRecordName isKindOfClass:[NSString class]]) {
                [recordName appendString:firstName];
            }
        }
        
        if (middleRecordName) {
            if ([middleRecordName isKindOfClass:[NSString class]]) {
                [recordName appendString:middleRecordName];
            }
        }
        
        if (lastRecordName) {
            if ([lastRecordName isKindOfClass:[NSString class]]) {
                [recordName appendString:lastRecordName];
            }
        }
        
        if (recordName.length == 0) {
            continue;
        }
        
        /** 获取号码 */
        ABMultiValueRef phoneNumbersRef = ABRecordCopyValue(record, kABPersonPhoneProperty);
        long count= ABMultiValueGetCount(phoneNumbersRef);
        NSString *phoneNum;
        for (NSInteger i = 0; i < count; i ++) {
            /** 如果号码和联系人名字一样，就不再存储 */
            phoneNum = (__bridge_transfer NSString *)ABMultiValueCopyValueAtIndex(phoneNumbersRef, i);
            /** 是否为空 */
            if (!phoneNum) {
                continue;
            }
            /** 判断是否是字符串 */
            if (![phoneNum isKindOfClass:[NSString class]]) {
                continue;
            }
            phoneNum = [phoneNum stringByReplacingOccurrencesOfString:@" " withString:@""];
            phoneNum = [phoneNum stringByReplacingOccurrencesOfString:@"-" withString:@""];
            phoneNum = [phoneNum stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            phoneNum = [phoneNum stringByReplacingOccurrencesOfString:@"+" withString:@""];
            phoneNum = [phoneNum stringByReplacingOccurrencesOfString:@"=" withString:@""];
            phoneNum = [phoneNum stringByReplacingOccurrencesOfString:@"*" withString:@""];
            phoneNum = [phoneNum stringByReplacingOccurrencesOfString:@"," withString:@""];
            phoneNum = [phoneNum stringByReplacingOccurrencesOfString:@";" withString:@""];
            phoneNum = [phoneNum stringByReplacingOccurrencesOfString:@" " withString:@""];
            NSCharacterSet *doNotWant = [NSCharacterSet characterSetWithCharactersInString:@",;[]{}（#%-*+=_）\\|~(＜＞$%^&*)_+ "];
            phoneNum = [[phoneNum componentsSeparatedByCharactersInSet: doNotWant]componentsJoinedByString: @""];
            if ([phoneNum isEqualToString:mobile] && [name isEqualToString:recordName]) {
                CFRelease(phoneNumbersRef);
                CFRelease(iPhoneAddressBook);
                return;
            }else if (![phoneNum isEqualToString:mobile] && [name isEqualToString:recordName]) {
                CFErrorRef error = NULL;
                ABMutableMultiValueRef multiPhone = ABMultiValueCreateMutable(kABMultiStringPropertyType);
                ABMultiValueAddValueAndLabel(multiPhone, (__bridge CFTypeRef)mobile, kABPersonPhoneMainLabel, NULL);
                ABMultiValueAddValueAndLabel(multiPhone, (__bridge CFTypeRef)phoneNum, kABPersonPhoneMainLabel, NULL);
                ABRecordSetValue(record, kABPersonPhoneProperty, multiPhone,&error);
                CFRelease(multiPhone);
                
                /** 添加联系人到通讯录 */
                ABAddressBookAddRecord(iPhoneAddressBook, record, &error);
                CFRelease(record);
                ABAddressBookSave(iPhoneAddressBook, &error);
                /** 名字相同，号码不同,名字下面加 */
                return;
            }else {
                [self deleteMobileFromAddressBookWithFirstName:firstName];
            }
        }
        CFRelease(phoneNumbersRef);
    }
    
    /** 创建联系人 */
    ABRecordRef newPerson = ABPersonCreate();
    CFErrorRef error = NULL;
    ABRecordSetValue(newPerson, kABPersonFirstNameProperty, (__bridge CFTypeRef)firstName, &error);
    ABRecordSetValue(newPerson, kABPersonLastNameProperty,  (__bridge CFTypeRef)lastName, &error);
    ABRecordSetValue(newPerson, kABPersonMiddleNameProperty, (__bridge CFTypeRef)middleName, &error);
    
    /** 设置联系人电话号码 */
    ABMutableMultiValueRef multiPhone = ABMultiValueCreateMutable(kABMultiStringPropertyType);
    ABMultiValueAddValueAndLabel(multiPhone, (__bridge CFTypeRef)mobile, kABPersonPhoneMainLabel, NULL);
    ABRecordSetValue(newPerson, kABPersonPhoneProperty, multiPhone,&error);
    CFRelease(multiPhone);
    
    /** 添加联系人到通讯录 */
    ABAddressBookAddRecord(iPhoneAddressBook, newPerson, &error);
    CFRelease(newPerson);
    ABAddressBookSave(iPhoneAddressBook, &error);
    
    /** 释放通讯录 */
    CFRelease(iPhoneAddressBook);
}

- (void)addMobileToContactWithFirstName:(NSString *)firstName
                                isClear:(BOOL)isClear
                                mobiles:(NSArray<NSString *> *)mobiles
{
    /** 检查通讯录权限 */
    ABAddressBookRequestAccessWithCompletion(ABAddressBookCreateWithOptions(NULL, NULL), ^(bool granted, CFErrorRef error) {
        if (granted) {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                [self addMobileToContactWithFirstNameMethod:firstName
                                                              isClear:isClear
                                                              mobiles:mobiles];
            });
        }
    });
}

- (void)addMobileToContactWithFirstNameMethod:(NSString *)firstName
                                      isClear:(BOOL)isClear
                                      mobiles:(NSArray<NSString *> *)mobiles {
    
    if (!mobiles
        || !mobiles.count
        || !firstName
        || !firstName.length) {
        
        return;
    }
    
    /** 获取通讯录对象 */
    ABAddressBookRef addressBook = ABAddressBookCreate();
    
    /** 判断是否需要清空 */
    NSMutableArray *allPersonArray = [[NSMutableArray alloc] init];
    if (isClear) {
        /** 获取通讯录中所有的联系人 */
        allPersonArray = [[NSMutableArray alloc] initWithArray:CFBridgingRelease(ABAddressBookCopyArrayOfAllPeople(addressBook))];
        /** 遍历所有的联系人并删除 */
        for (id obj in allPersonArray) {
            ABRecordRef people = (ABRecordRef)CFBridgingRetain(obj);
            NSString *firstRecordName = (NSString *)CFBridgingRelease(ABRecordCopyValue(people, kABPersonFirstNameProperty));
            if ([firstRecordName isEqualToString:firstName]) {
                ABAddressBookRemoveRecord(addressBook, people, NULL);
            }
        }
    }
    
    /** 获取通讯录中所有的联系人 */
    allPersonArray = [[NSMutableArray alloc] initWithArray:CFBridgingRelease(ABAddressBookCopyArrayOfAllPeople(addressBook))];
    
    /** 遍历所有的联系人 */
    if (allPersonArray && allPersonArray.count) {
        /** 判断是否存在联系人 */
        __block BOOL recordIsExist = NO;
        __block ABRecordRef targetRecord = NULL;
        [allPersonArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            targetRecord = (ABRecordRef)CFBridgingRetain(obj);
            NSString *firstRecordName = (NSString *)CFBridgingRelease(ABRecordCopyValue(targetRecord, kABPersonFirstNameProperty));
            if ([firstRecordName isEqualToString:firstName]) {
                recordIsExist = YES;
                *stop = YES;
            }
        }];
        
        CFErrorRef error = NULL;
        if (!recordIsExist) {
            /** 不存在则创建 */
            ABRecordRef newPerson = ABPersonCreate();
            ABRecordSetValue(newPerson, kABPersonFirstNameProperty, (__bridge CFTypeRef)firstName, &error);
            /** 设置联系人电话号码 */
            ABMutableMultiValueRef multiPhone = ABMultiValueCreateMutable(kABMultiStringPropertyType);
            [mobiles enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                ABMultiValueAddValueAndLabel(multiPhone, (__bridge CFTypeRef)obj, kABPersonPhoneMainLabel, NULL);
            }];
            ABRecordSetValue(newPerson, kABPersonPhoneProperty, multiPhone, &error);
            CFRelease(multiPhone);
            /** 添加联系人到通讯录 */
            ABAddressBookAddRecord(addressBook, newPerson, &error);
            CFRelease(newPerson);
        }else if (targetRecord) {
            /** 获取已存在的号码 */
            ABMultiValueRef oldMobilesRef = (ABMultiValueRef)ABRecordCopyValue(targetRecord, kABPersonPhoneProperty);
            NSArray *oldMobiles = (__bridge NSArray *)ABMultiValueCopyArrayOfAllValues(oldMobilesRef);
            CFRelease(oldMobilesRef);
            
            /** 获取所有电话号码 */
            NSMutableArray *allMobiles = [[NSMutableArray alloc] init];
            [allMobiles addObjectsFromArray:mobiles];
            if (oldMobiles && oldMobiles.count) {
                [allMobiles addObjectsFromArray:oldMobiles];
            }
            
            /** 存在则插入 */
            ABMutableMultiValueRef multiPhone = ABMultiValueCreateMutable(kABMultiStringPropertyType);
            [allMobiles enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                ABMultiValueAddValueAndLabel(multiPhone, (__bridge CFTypeRef)obj, kABPersonPhoneMainLabel, NULL);
            }];
            ABRecordSetValue(targetRecord, kABPersonPhoneProperty, multiPhone, &error);
            CFRelease(multiPhone);
            
            /** 添加联系人到通讯录 */
            ABAddressBookAddRecord(addressBook, targetRecord, &error);
            CFRelease(targetRecord);
        }
    }
    
    /** 保存修改的通讯录对象 */
    ABAddressBookSave(addressBook, NULL);
    /** 释放通讯录对象的内存 */
    if (addressBook) {
        CFRelease(addressBook);
    }
}

@end
