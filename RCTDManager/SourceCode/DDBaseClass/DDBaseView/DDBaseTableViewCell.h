//
//  DDBaseTableViewCell.h
//  DoorDuOEM
//
//  Created by matt on 2018/3/28.
//  Copyright © 2018年 广州人创天地有限公司 All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DDBaseTableViewCell : UITableViewCell

@property (nonatomic,weak) UIViewController * superViewController;

@property (nonatomic, weak) NSIndexPath * nowIndexPath;

/** 底部线 */
@property (nonatomic, strong) UIView * bottomLineView;

/** 左边的箭头 */
@property (nonatomic, strong) UIImageView * rightArrowImageView;

/**
 数据回调
 */
@property (nonatomic,copy) DDCallBackReturnObjectDataBlock retrunObjectBlock;
- (void)returnObjectCallBlock:(__autoreleasing DDCallBackReturnObjectDataBlock)block;




/** UI布局,子类需要自己调用 */
- (void)setupConfigUI;


@end
