//
//  DDBaseTableViewCell.m
//  DoorDuOEM
//
//  Created by matt on 2018/3/28.
//  Copyright © 2018年 广州人创天地有限公司 All rights reserved.
//

#import "DDBaseTableViewCell.h"

@implementation DDBaseTableViewCell

/**
 数据回调
 */
- (void)returnObjectCallBlock:(__autoreleasing DDCallBackReturnObjectDataBlock)block
{
    self.retrunObjectBlock = block;
}

/** UI布局,子类需要自己调用 */
- (void)setupConfigUI
{
    
}

#pragma mark - 懒加载
/** 底部线 */
- (UIView *)bottomLineView
{
    if (!_bottomLineView) {
        _bottomLineView = [[UIView alloc] init];
        _bottomLineView.backgroundColor = DDColorDDDDDD;
        _bottomLineView.height = 0.5;
        _bottomLineView.layout_height(0.6);
    }
    return _bottomLineView;
}
/** 左边的箭头 */
- (UIImageView *)rightArrowImageView
{
    if (!_rightArrowImageView) {
        _rightArrowImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"箭头右"]];
        _rightArrowImageView.width = _rightArrowImageView.image.width;
        _rightArrowImageView.height = _rightArrowImageView.image.height;
        
        _rightArrowImageView
        .layout_width(_rightArrowImageView.image.width)
        .layout_height(_rightArrowImageView.image.height);
    }
    return _rightArrowImageView;
}

/** 用于记录子类是否释放 */
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    NSLog(@"\n释放_dealloc : %@ \n",NSStringFromClass([self class]));
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
