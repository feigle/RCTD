//
//  DDBaseView.h
//  DoorDuOEM
//
//  Created by matt on 2018/3/28.
//  Copyright © 2018年 广州人创天地有限公司 All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DDBaseView : UIView

@property (nonatomic, weak) UIViewController * superViewController;

/**
 数据回调
 */
@property (nonatomic,copy) DDCallBackReturnObjectDataBlock retrunObjectBlock;
- (void)returnObjectCallBlock:(__autoreleasing DDCallBackReturnObjectDataBlock)block;

/** UI布局,子类会自动调用,子类会didMoveToSuperview执行时主动调用一次 */
- (void)setupConfigUI;


@end
