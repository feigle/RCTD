//
//  CALayer+DDTools.h
//  DoorDu
//
//  Created by 刘和东 on 2017/12/6.
//  Copyright © 2017年 深圳市多度科技有限公司. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface CALayer (DDTools)

/** 移除所有的layer */
- (void)removeAllSublayers;

@property (nonatomic,assign) CGFloat left;
@property (nonatomic,assign) CGFloat top;
@property (nonatomic,assign) CGFloat right;
@property (nonatomic,assign) CGFloat bottom;
@property (nonatomic,assign) CGFloat width;
@property (nonatomic,assign) CGFloat height;
@property (nonatomic,assign) CGPoint center;
@property (nonatomic,assign) CGFloat centerX;
@property (nonatomic,assign) CGFloat centerY;
@property (nonatomic,assign) CGPoint origin;
@property (nonatomic,assign) CGSize  size;


@end
