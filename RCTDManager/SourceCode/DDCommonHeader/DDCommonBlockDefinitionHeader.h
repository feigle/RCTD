//
//  DDCommonBlockDefinitionHeader.h
//  DoorDuOEM
//
//  Created by matt on 2018/3/21.
//  Copyright © 2018年 广州人创天地有限公司 All rights reserved.
//

#ifndef DDCommonBlockDefinitionHeader_h
#define DDCommonBlockDefinitionHeader_h

/** 用于返回数据的Block，objc返回的对象，tag标记不同的对象*/
typedef void (^DDCallBackReturnObjectDataBlock)(id objc,NSInteger tag);

/**
 开启一个定时器
 
 @param target 定时器持有者
 @param timeInterval 执行间隔时间
 @param handler 重复执行事件
 */
static inline void dispatchTimer(id target, double timeInterval,void (^handler)(dispatch_source_t timer))
{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t timer =dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER,0, 0, queue);
    dispatch_source_set_timer(timer, dispatch_walltime(NULL, 0), (uint64_t)(timeInterval *NSEC_PER_SEC), 0);
    // 设置回调
    __weak __typeof(target) weaktarget  = target;
    dispatch_source_set_event_handler(timer, ^{
        if (!weaktarget)  {
            dispatch_source_cancel(timer);
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (handler) handler(timer);
            });
        }
    });
    // 启动定时器
    dispatch_resume(timer);
}

/**
 开启一个延时
 
 @param timeInterval 延时时间
 @param handler 执行事件
 */
static inline void dispatchAfterTimer(double timeInterval,void (^handler)(void))
{
    dispatch_queue_t queue  = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(timeInterval * NSEC_PER_SEC)), queue, ^{
        if (handler) {
            dispatch_async(dispatch_get_main_queue(), ^{
                handler();
            });
        }
    });
}



#endif /* DDCommonBlockDefinitionHeader_h */
