//
//  DDBaseViewController.h
//  DoorDu
//
//  Created by matt on 2018/3/21.
//  Copyright © 2018年 广州人创天地有限公司 All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DDBaseViewController : UIViewController

@property (nonatomic,weak) UIViewController * superViewController;

/**
 数据回调
 */
@property (nonatomic,copy) DDCallBackReturnObjectDataBlock retrunObjectBlock;
- (void)returnObjectCallBlock:(__autoreleasing DDCallBackReturnObjectDataBlock)block;

/** UI布局 */
- (void)setupConfigUI;

/** 刷新UI */
- (void)refreshUI;

/** 处理数据 */
- (void)handleData;

@end
