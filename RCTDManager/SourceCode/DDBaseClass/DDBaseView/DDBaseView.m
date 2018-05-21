//
//  DDBaseView.m
//  DoorDuOEM
//
//  Created by matt on 2018/3/28.
//  Copyright © 2018年 广州人创天地有限公司 All rights reserved.
//

#import "DDBaseView.h"
#import "SDWebImageManager.h"

@interface DDBaseView ()

/** 是否是第一次 */
@property (nonatomic, assign) BOOL didMoveToSuperviewIsFirst;

@end


@implementation DDBaseView

/**
 数据回调
 */
- (void)returnObjectCallBlock:(__autoreleasing DDCallBackReturnObjectDataBlock)block
{
    self.retrunObjectBlock = block;
}

/** UI布局 */
- (void)setupConfigUI
{
    
}

- (void)didMoveToSuperview
{
    [super didMoveToSuperview];
}

/** 用于界面的第一次，主要用于布局 */
- (void)didMoveToWindow
{
    [super didMoveToWindow];
    if (!self.didMoveToSuperviewIsFirst) {
        self.didMoveToSuperviewIsFirst = YES;
        [self setupConfigUI];
    }
}
/** 用于记录子类是否释放 */
- (void)dealloc
{
    [[SDWebImageManager sharedManager].imageCache clearMemory];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    NSLog(@"\n释放_dealloc : %@ \n",NSStringFromClass([self class]));
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
