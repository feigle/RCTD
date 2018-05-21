//
//  DDScreenFitter.h
//  刘和东
//
//  Created by 刘和东 on 2014/12/21.
//  Copyright © 2014年 刘和东. All rights reserved.
//

#import <Foundation/Foundation.h>

//单例
#define ddScreenFitter ((DDScreenFitter *)[DDScreenFitter sharedDDScreenFitter])

/**适配字体大小*/

@interface DDScreenFitter : NSObject

/**创建一个单例*/
+ (instancetype)sharedDDScreenFitter;

@property (assign, nonatomic) float autoSize6PScaleX;
@property (assign, nonatomic) float autoSize6PScaleY;
@property (assign, nonatomic) float autoSize6ScaleX;
@property (assign, nonatomic) float autoSize6ScaleY;

//得到字体的比例，以6p为基准
@property (assign, nonatomic) CGFloat font6pScale;
//得到字体的比例，以6为基准 bold
@property (assign, nonatomic) CGFloat font6Scale;

@end


