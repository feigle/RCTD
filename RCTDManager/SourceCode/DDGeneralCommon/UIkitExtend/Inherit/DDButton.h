//
//  DDButton.h
//  DoorDuOEM
//
//  Created by 刘和东 on 2018/3/28.
//  Copyright © 2018年 刘和东. All rights reserved.
//

#import <UIKit/UIKit.h>

/** DDButton 样式 类型 */
typedef NS_ENUM(NSInteger, DDButtonStyleType) {
    DDButtonStyleImageViewTopType       = 1,    // 图片在上面
    DDButtonStyleImageViewBottomType    = 2,    // 图片在下面
    DDButtonStyleImageViewLeftType      = 3,    // 图片在左边
    DDButtonStyleImageViewRightType     = 4,    // 图片在右边
};


@interface DDButton : UIButton

/** 空隙距离(图片 和 文字) */
@property (nonatomic, assign) CGFloat space;

/** 样式类型 */
@property (nonatomic, assign) DDButtonStyleType styleType;


@end
