//
//  UIView+DDAutoLayout.h
//  DoorDu
//
//  Created by 刘和东 on 2017/12/20.
//  Copyright © 2017年 深圳市多度科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSLayoutConstraint+DDAutoLayout.h"

@interface UIView (DDAutoLayout)

/** 清空所有的布局 */
- (void)layout_clearAllConstraints;

#pragma mark - 获取对应的 layoutConstraint
/** 获取高度 LayoutConstraint */
- (NSLayoutConstraint *)layout_getHeight;

/** 获取宽度 LayoutConstraint */
- (NSLayoutConstraint *)layout_getWidth;

/** 获取centerX LayoutConstraint */
- (NSLayoutConstraint *)layout_getCenterX;

/** 获取centerY LayoutConstraint */
- (NSLayoutConstraint *)layout_getCenterY;

/** 获取top LayoutConstraint */
- (NSLayoutConstraint *)layout_getTop;

/** 获取left LayoutConstraint */
- (NSLayoutConstraint *)layout_getLeft;

/** 获取bottom LayoutConstraint */
- (NSLayoutConstraint *)layout_getBottom;

/** 获取right LayoutConstraint */
- (NSLayoutConstraint *)layout_getRight;

#pragma mark - 移除对应的 layoutConstraint
/** 移除高度 LayoutConstraint */
- (void)layout_removeHeightConstraint;

/** 移除宽度 LayoutConstraint */
- (void)layout_removeWidthConstraint;

/** 移除centerX LayoutConstraint */
- (void)layout_removeCenterXConstraint;

/** 移除centerY LayoutConstraint */
- (void)layout_removeCenterYConstraint;

/** 移除top LayoutConstraint */
- (void)layout_removeTopConstraint;

/** 移除left LayoutConstraint */
- (void)layout_removeLeftConstraint;

/** 移除bottom LayoutConstraint */
- (void)layout_removeBottomConstraint;

/** 移除right LayoutConstraint */
- (void)layout_removeRightConstraint;


#pragma mark - 设置 高度
/** 设置高度 */
@property (nonatomic, copy, readonly) UIView * (^layout_height)(CGFloat height);
/** 高度等于 toItem高度的比 ratio */
@property (nonatomic, copy, readonly) UIView * (^layout_heightToItemRatio)(id toItem,CGFloat ratio);
/** 高度等于 toItem的高度 */
@property (nonatomic, copy, readonly) UIView * (^layout_heightEqualToItem)(id toItem);
/** 高度等于 superview高度 */
@property (nonatomic, copy, readonly) UIView * (^layout_heightEqualToSuperview)(void);
/** 高度等于 superview高度的比 ratio */
@property (nonatomic, copy, readonly) UIView * (^layout_heightRatio)(CGFloat ratio);
/** 高度等于 toItem高度的比 ratio */
@property (nonatomic, copy, readonly) UIView * (^layout_heightWidthRatio)(CGFloat ratio);


#pragma mark - 设置 宽度
/** 设置宽度 */
@property (nonatomic, copy, readonly) UIView * (^layout_width)(CGFloat width);
/** 宽度等于 toItem宽度的比 ratio */
@property (nonatomic, copy, readonly) UIView * (^layout_widthToItemRatio)(id toItem,CGFloat ratio);
/** 宽度等于 toItem的宽度 */
@property (nonatomic, copy, readonly) UIView * (^layout_widthEqualToItem)(id toItem);
/** 宽度等于 superview宽度 */
@property (nonatomic, copy, readonly) UIView * (^layout_widthEqualToSuperview)(void);
/** 宽度等于 superview宽度的比 ratio */
@property (nonatomic, copy, readonly) UIView * (^layout_widthRatio)(CGFloat ratio);
/** 宽度等于 toItem高度的比 ratio */
@property (nonatomic, copy, readonly) UIView * (^layout_widthHeightRatio)(CGFloat ratio);


#pragma mark - 设置 centerX
/** centerX 相对于 toItem attribute 的 偏移量constant */
@property (nonatomic, copy, readonly) UIView * (^layout_centerXToItemAttribute)(id toItem,CGFloat constant,NSLayoutAttribute attribute);

/*****   superview   *****/
/** centerX 相对于 superview centerX的 偏移量constant */
@property (nonatomic, copy, readonly) UIView * (^layout_centerX)(CGFloat constant);
/** centerX 等于 superview centerX */
@property (nonatomic, copy, readonly) UIView * (^layout_centerXEqualToSuperview)(void);

/*****   centerX   *****/
/** centerX 相对于 toItem centerX的 偏移量constant */
@property (nonatomic, copy, readonly) UIView * (^layout_centerXToItemCenterX)(id toItem,CGFloat constant);
/** centerX 等于 toItem centerX */
@property (nonatomic, copy, readonly) UIView * (^layout_centerXEqualToItemCenterX)(id toItem);

/*****   left   *****/
/** centerX 相对于 toItem left的 偏移量constant */
@property (nonatomic, copy, readonly) UIView * (^layout_centerXToItemLeft)(id toItem,CGFloat constant);
/** centerX 等于 toItem left */
@property (nonatomic, copy, readonly) UIView * (^layout_centerXEqualToItemLeft)(id toItem);

/*****   right   *****/
/** centerX 相对于 toItem right的 偏移量constant */
@property (nonatomic, copy, readonly) UIView * (^layout_centerXToItemRight)(id toItem,CGFloat constant);
/** centerX 等于 toItem right */
@property (nonatomic, copy, readonly) UIView * (^layout_centerXEqualToItemRight)(id toItem);

#pragma mark - 设置 centerY
/** centerY 相对于 toItem attribute 的 偏移量constant */
@property (nonatomic, copy, readonly) UIView * (^layout_centerYToItemAttribute)(id toItem,CGFloat constant,NSLayoutAttribute attribute);

/*****   superview   *****/
/** centerY 相对于 superview centerY的 偏移量constant */
@property (nonatomic, copy, readonly) UIView * (^layout_centerY)(CGFloat constant);
/** centerY 等于 superview centerY */
@property (nonatomic, copy, readonly) UIView * (^layout_centerYEqualToSuperview)(void);

/*****   centerY   *****/
/** centerY 相对于 toItem centerY的 偏移量constant */
@property (nonatomic, copy, readonly) UIView * (^layout_centerYToItemCenterY)(id toItem,CGFloat constant);
/** centerY 等于 toItem centerY */
@property (nonatomic, copy, readonly) UIView * (^layout_centerYEqualToItemCenterY)(id toItem);

/*****   top   *****/
/** centerY 相对于 toItem top的 偏移量constant */
@property (nonatomic, copy, readonly) UIView * (^layout_centerYToItemTop)(id toItem,CGFloat constant);
/** centerY 等于 toItem top */
@property (nonatomic, copy, readonly) UIView * (^layout_centerYEqualToItemTop)(id toItem);

/*****   bottom   *****/
/** centerY 相对于 toItem bottom的 偏移量constant */
@property (nonatomic, copy, readonly) UIView * (^layout_centerYToItemBottom)(id toItem,CGFloat constant);
/** centerY 等于 toItem bottom */
@property (nonatomic, copy, readonly) UIView * (^layout_centerYEqualToItemBottom)(id toItem);


#pragma mark - 设置 center

/** center 相对于 toItem center的 偏移量point */
@property (nonatomic, copy, readonly) UIView * (^layout_centerToItemCenter)(id toItem,CGPoint point);
/** center 等于 toItem center */
@property (nonatomic, copy, readonly) UIView * (^layout_centerEqualToItemCenter)(id toItem);
/** center 相对于 superview center的 偏移量 x y  */
@property (nonatomic, copy, readonly) UIView * (^layout_center)(CGFloat x, CGFloat y);
/** center 等于 superview center */
@property (nonatomic, copy, readonly) UIView * (^layout_centerEqualToSuperview)(void);


#pragma mark - 设置 top

/** top 相对于 toItem attribute 的 偏移量constant */
@property (nonatomic, copy, readonly) UIView * (^layout_topToItemAttribute)(id toItem,CGFloat constant,NSLayoutAttribute attribute);

/*****   superview   *****/
/** top 相对于 superview top的 偏移量constant */
@property (nonatomic, copy, readonly) UIView * (^layout_top)(CGFloat constant);
/** top 等于 superview top */
@property (nonatomic, copy, readonly) UIView * (^layout_topEqualToSuperview)(void);

/*****   top   *****/
/** top 相对于 toItem top的 偏移量constant */
@property (nonatomic, copy, readonly) UIView * (^layout_topToItemTop)(id toItem,CGFloat constant);
/** top 等于 toItem top */
@property (nonatomic, copy, readonly) UIView * (^layout_topEqualToItemTop)(id toItem);

/*****   centerY   *****/
/** top 相对于 toItem centerY的 偏移量constant */
@property (nonatomic, copy, readonly) UIView * (^layout_topToItemCenterY)(id toItem,CGFloat constant);
/** top 等于 toItem centerY */
@property (nonatomic, copy, readonly) UIView * (^layout_topEqualToItemCenterY)(id toItem);

/*****   bottom   *****/
/** top 相对于 toItem bottom的 偏移量constant */
@property (nonatomic, copy, readonly) UIView * (^layout_topToItemBottom)(id toItem,CGFloat constant);
/** top 等于 toItem bottom */
@property (nonatomic, copy, readonly) UIView * (^layout_topEqualToItemBottom)(id toItem);


#pragma mark - 设置 left
/** left 相对于 toItem attribute 的 偏移量constant */
@property (nonatomic, copy, readonly) UIView * (^layout_leftToItemAttribute)(id toItem,CGFloat constant,NSLayoutAttribute attribute);

/*****   superview   *****/
/** left 相对于 superview left的 偏移量constant */
@property (nonatomic, copy, readonly) UIView * (^layout_left)(CGFloat constant);
/** left 等于 superview left */
@property (nonatomic, copy, readonly) UIView * (^layout_leftEqualToSuperview)(void);

/*****   left   *****/
/** left 相对于 toItem left的 偏移量constant */
@property (nonatomic, copy, readonly) UIView * (^layout_leftToItemLeft)(id toItem,CGFloat constant);
/** left 等于 toItem left */
@property (nonatomic, copy, readonly) UIView * (^layout_leftEqualToItemLeft)(id toItem);

/*****   centerX   *****/
/** left 相对于 toItem centerX的 偏移量constant */
@property (nonatomic, copy, readonly) UIView * (^layout_leftToItemCenterX)(id toItem,CGFloat constant);
/** left 等于 toItem centerX */
@property (nonatomic, copy, readonly) UIView * (^layout_leftEqualToItemCenterX)(id toItem);

/*****   right   *****/
/** left 相对于 toItem right的 偏移量constant */
@property (nonatomic, copy, readonly) UIView * (^layout_leftToItemRight)(id toItem,CGFloat constant);
/** left 等于 toItem right */
@property (nonatomic, copy, readonly) UIView * (^layout_leftEqualToItemRight)(id toItem);

#pragma mark - 设置 bottom
/** bottom 相对于 toItem attribute 的 偏移量constant */
@property (nonatomic, copy, readonly) UIView * (^layout_bottomToItemAttribute)(id toItem,CGFloat constant,NSLayoutAttribute attribute);

/*****   superview   *****/
/** bottom 相对于 superview bottom的 偏移量constant */
@property (nonatomic, copy, readonly) UIView * (^layout_bottom)(CGFloat constant);
/** bottom 等于 superview bottom */
@property (nonatomic, copy, readonly) UIView * (^layout_bottomEqualToSuperview)(void);

/*****   bottom   *****/
/** bottom 相对于 toItem bottom的 偏移量constant */
@property (nonatomic, copy, readonly) UIView * (^layout_bottomToItemBottom)(id toItem,CGFloat constant);
/** bottom 等于 toItem bottom */
@property (nonatomic, copy, readonly) UIView * (^layout_bottomEqualToItemBottom)(id toItem);

/*****   top   *****/
/** bottom 相对于 toItem top的 偏移量constant */
@property (nonatomic, copy, readonly) UIView * (^layout_bottomToItemTop)(id toItem,CGFloat constant);
/** bottom 等于 toItem top */
@property (nonatomic, copy, readonly) UIView * (^layout_bottomEqualToItemTop)(id toItem);

/*****   centerY   *****/
/** bottom 相对于 toItem centerY的 偏移量constant */
@property (nonatomic, copy, readonly) UIView * (^layout_bottomToItemCenterY)(id toItem,CGFloat constant);
/** bottom 等于 toItem centerY */
@property (nonatomic, copy, readonly) UIView * (^layout_bottomEqualToItemCenterY)(id toItem);

#pragma mark - 设置 right
/** right 相对于 toItem attribute 的 偏移量constant */
@property (nonatomic, copy, readonly) UIView * (^layout_rightToItemAttribute)(id toItem,CGFloat constant,NSLayoutAttribute attribute);

/*****   superview   *****/
/** right 相对于 superview right的 偏移量constant */
@property (nonatomic, copy, readonly) UIView * (^layout_right)(CGFloat constant);
/** right 等于 superview right */
@property (nonatomic, copy, readonly) UIView * (^layout_rightEqualToSuperview)(void);

/*****   right   *****/
/** right 相对于 toItem right的 偏移量constant */
@property (nonatomic, copy, readonly) UIView * (^layout_rightToItemRight)(id toItem,CGFloat constant);
/** right 等于 toItem right */
@property (nonatomic, copy, readonly) UIView * (^layout_rightEqualToItemRight)(id toItem);

/*****   left   *****/
/** right 相对于 toItem left的 偏移量constant */
@property (nonatomic, copy, readonly) UIView * (^layout_rightToItemLeft)(id toItem,CGFloat constant);
/** right 等于 toItem left */
@property (nonatomic, copy, readonly) UIView * (^layout_rightEqualToItemLeft)(id toItem);

/*****   centerX   *****/
/** right 相对于 toItem centerX的 偏移量constant */
@property (nonatomic, copy, readonly) UIView * (^layout_rightToItemCenterX)(id toItem,CGFloat constant);
/** right 等于 toItem centerX */
@property (nonatomic, copy, readonly) UIView * (^layout_rightEqualToItemCenterX)(id toItem);


/////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark ---------------------  以iPhone 6 设计的UI图
#pragma mark - 适配6 高度
/** 设置高度 */
@property (nonatomic, copy, readonly) UIView * (^layout_height6)(CGFloat height6);

#pragma mark - 适配6 宽度
/** 设置宽度 */
@property (nonatomic, copy, readonly) UIView * (^layout_width6)(CGFloat width6);

#pragma mark - 适配6 centerX
/** centerX 相对于 toItem attribute 的 偏移量constant6 */
@property (nonatomic, copy, readonly) UIView * (^layout_centerX6ToItemAttribute)(id toItem,CGFloat constant6,NSLayoutAttribute attribute);

/*****   superview   *****/
/** centerX 相对于 superview centerX的 偏移量constant6 */
@property (nonatomic, copy, readonly) UIView * (^layout_centerX6)(CGFloat constant6);

/*****   centerX   *****/
/** centerX 相对于 toItem centerX的 偏移量constant6 */
@property (nonatomic, copy, readonly) UIView * (^layout_centerX6ToItemCenterX)(id toItem,CGFloat constant6);

/*****   left   *****/
/** centerX 相对于 toItem left的 偏移量constant6 */
@property (nonatomic, copy, readonly) UIView * (^layout_centerX6ToItemLeft)(id toItem,CGFloat constant6);

/*****   right   *****/
/** centerX 相对于 toItem right的 偏移量constant6 */
@property (nonatomic, copy, readonly) UIView * (^layout_centerX6ToItemRight)(id toItem,CGFloat constant6);

#pragma mark - 适配6 centerY
/** centerY 相对于 toItem attribute 的 偏移量constant6 */
@property (nonatomic, copy, readonly) UIView * (^layout_centerY6ToItemAttribute)(id toItem,CGFloat constant6,NSLayoutAttribute attribute);

/*****   superview   *****/
/** centerY 相对于 superview centerY的 偏移量constant6 */
@property (nonatomic, copy, readonly) UIView * (^layout_centerY6)(CGFloat constant6);

/*****   centerY   *****/
/** centerY 相对于 toItem centerY的 偏移量constant6 */
@property (nonatomic, copy, readonly) UIView * (^layout_centerY6ToItemCenterY)(id toItem,CGFloat constant6);

/*****   top   *****/
/** centerY 相对于 toItem top的 偏移量constant6 */
@property (nonatomic, copy, readonly) UIView * (^layout_centerY6ToItemTop)(id toItem,CGFloat constant6);

/*****   bottom   *****/
/** centerY 相对于 toItem bottom的 偏移量constant6 */
@property (nonatomic, copy, readonly) UIView * (^layout_centerY6ToItemBottom)(id toItem,CGFloat constant6);


#pragma mark - 适配6 center
/** center 相对于 toItem center的 偏移量point6 */
@property (nonatomic, copy, readonly) UIView * (^layout_center6ToItemCenter)(id toItem,CGPoint point6);

/** center 相对于 superview center的 偏移量 x6 y6  */
@property (nonatomic, copy, readonly) UIView * (^layout_center6)(CGFloat x6, CGFloat y6);

#pragma mark - 适配6 top
/** top 相对于 toItem attribute 的 偏移量constant6 */
@property (nonatomic, copy, readonly) UIView * (^layout_top6ToItemAttribute)(id toItem,CGFloat constant6,NSLayoutAttribute attribute);

/*****   superview   *****/
/** top 相对于 superview top的 偏移量constant6 */
@property (nonatomic, copy, readonly) UIView * (^layout_top6)(CGFloat constant6);

/*****   top   *****/
/** top 相对于 toItem top的 偏移量constant6 */
@property (nonatomic, copy, readonly) UIView * (^layout_top6ToItemTop)(id toItem,CGFloat constant6);

/*****   centerY   *****/
/** top 相对于 toItem centerY的 偏移量constant6 */
@property (nonatomic, copy, readonly) UIView * (^layout_top6ToItemCenterY)(id toItem,CGFloat constant6);

/*****   bottom   *****/
/** top 相对于 toItem bottom的 偏移量constant6 */
@property (nonatomic, copy, readonly) UIView * (^layout_top6ToItemBottom)(id toItem,CGFloat constant6);


#pragma mark - 适配6 left
/** left 相对于 toItem attribute 的 偏移量constant6 */
@property (nonatomic, copy, readonly) UIView * (^layout_left6ToItemAttribute)(id toItem,CGFloat constant6,NSLayoutAttribute attribute);

/*****   superview   *****/
/** left 相对于 superview left的 偏移量constant6 */
@property (nonatomic, copy, readonly) UIView * (^layout_left6)(CGFloat constant6);

/*****   left   *****/
/** left 相对于 toItem left的 偏移量constant6 */
@property (nonatomic, copy, readonly) UIView * (^layout_left6ToItemLeft)(id toItem,CGFloat constant6);

/*****   centerX   *****/
/** left 相对于 toItem centerX的 偏移量constant6 */
@property (nonatomic, copy, readonly) UIView * (^layout_left6ToItemCenterX)(id toItem,CGFloat constant6);

/*****   right   *****/
/** left 相对于 toItem right的 偏移量constant6 */
@property (nonatomic, copy, readonly) UIView * (^layout_left6ToItemRight)(id toItem,CGFloat constant6);

#pragma mark - 适配6 bottom
/** bottom 相对于 toItem attribute 的 偏移量constant6 */
@property (nonatomic, copy, readonly) UIView * (^layout_bottom6ToItemAttribute)(id toItem,CGFloat constant6,NSLayoutAttribute attribute);

/*****   superview   *****/
/** bottom 相对于 superview bottom的 偏移量constant6 */
@property (nonatomic, copy, readonly) UIView * (^layout_bottom6)(CGFloat constant6);

/*****   bottom   *****/
/** bottom 相对于 toItem bottom的 偏移量constant6 */
@property (nonatomic, copy, readonly) UIView * (^layout_bottom6ToItemBottom)(id toItem,CGFloat constant6);

/*****   top   *****/
/** bottom 相对于 toItem top的 偏移量constant6 */
@property (nonatomic, copy, readonly) UIView * (^layout_bottom6ToItemTop)(id toItem,CGFloat constant6);

/*****   centerY   *****/
/** bottom 相对于 toItem centerY的 偏移量constant6 */
@property (nonatomic, copy, readonly) UIView * (^layout_bottom6ToItemCenterY)(id toItem,CGFloat constant6);

#pragma mark - 适配6 right
/** right 相对于 toItem attribute 的 偏移量constant6 */
@property (nonatomic, copy, readonly) UIView * (^layout_right6ToItemAttribute)(id toItem,CGFloat constant6,NSLayoutAttribute attribute);

/*****   superview   *****/
/** right 相对于 superview right的 偏移量constant6 */
@property (nonatomic, copy, readonly) UIView * (^layout_right6)(CGFloat constant6);

/*****   right   *****/
/** right 相对于 toItem right的 偏移量constant6 */
@property (nonatomic, copy, readonly) UIView * (^layout_right6ToItemRight)(id toItem,CGFloat constant6);

/*****   left   *****/
/** right 相对于 toItem left的 偏移量constant6 */
@property (nonatomic, copy, readonly) UIView * (^layout_right6ToItemLeft)(id toItem,CGFloat constant6);

/*****   centerX   *****/
/** right 相对于 toItem centerX的 偏移量constant6 */
@property (nonatomic, copy, readonly) UIView * (^layout_right6ToItemCenterX)(id toItem,CGFloat constant6);


/////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark ---------------------  以iPhone 6p 设计的UI图
#pragma mark - 适配6p 高度
/** 设置高度 */
@property (nonatomic, copy, readonly) UIView * (^layout_height6p)(CGFloat height6p);

#pragma mark - 适配6 宽度
/** 设置宽度 */
@property (nonatomic, copy, readonly) UIView * (^layout_width6p)(CGFloat width6p);

#pragma mark - 适配6p centerX
/** centerX 相对于 toItem attribute 的 偏移量constant6p */
@property (nonatomic, copy, readonly) UIView * (^layout_centerX6pToItemAttribute)(id toItem,CGFloat constant6p,NSLayoutAttribute attribute);

/*****   superview   *****/
/** centerX 相对于 superview centerX的 偏移量constant6p */
@property (nonatomic, copy, readonly) UIView * (^layout_centerX6p)(CGFloat constant6p);

/*****   centerX   *****/
/** centerX 相对于 toItem centerX的 偏移量constant6p */
@property (nonatomic, copy, readonly) UIView * (^layout_centerX6pToItemCenterX)(id toItem,CGFloat constant6p);

/*****   left   *****/
/** centerX 相对于 toItem left的 偏移量constant6p */
@property (nonatomic, copy, readonly) UIView * (^layout_centerX6pToItemLeft)(id toItem,CGFloat constant6p);

/*****   right   *****/
/** centerX 相对于 toItem right的 偏移量constant6p */
@property (nonatomic, copy, readonly) UIView * (^layout_centerX6pToItemRight)(id toItem,CGFloat constant6p);

#pragma mark - 适配6p centerY
/** centerY 相对于 toItem attribute 的 偏移量constant6p  */
@property (nonatomic, copy, readonly) UIView * (^layout_centerY6pToItemAttribute)(id toItem,CGFloat constant6p,NSLayoutAttribute attribute);

/*****   superview   *****/
/** centerY 相对于 superview centerY的 偏移量constant6p */
@property (nonatomic, copy, readonly) UIView * (^layout_centerY6p)(CGFloat constant6p);

/*****   centerY   *****/
/** centerY 相对于 toItem centerY的 偏移量constant6p */
@property (nonatomic, copy, readonly) UIView * (^layout_centerY6pToItemCenterY)(id toItem,CGFloat constant6p);

/*****   top   *****/
/** centerY 相对于 toItem top的 偏移量constant6p */
@property (nonatomic, copy, readonly) UIView * (^layout_centerY6pToItemTop)(id toItem,CGFloat constant6p);

/*****   bottom   *****/
/** centerY 相对于 toItem bottom的 偏移量constant6p */
@property (nonatomic, copy, readonly) UIView * (^layout_centerY6pToItemBottom)(id toItem,CGFloat constant6p);

#pragma mark - 适配6p center
/** center 相对于 toItem center的 偏移量point6p */
@property (nonatomic, copy, readonly) UIView * (^layout_center6pToItemCenter)(id toItem,CGPoint point6p);

/** center 相对于 superview center的 偏移量 x6p y6p  */
@property (nonatomic, copy, readonly) UIView * (^layout_center6p)(CGFloat x6p, CGFloat y6p);

#pragma mark - 适配6p top
/** top 相对于 toItem attribute 的 偏移量constant6p */
@property (nonatomic, copy, readonly) UIView * (^layout_top6pToItemAttribute)(id toItem,CGFloat constant6p,NSLayoutAttribute attribute);

/*****   superview   *****/
/** top 相对于 superview top的 偏移量constant6p */
@property (nonatomic, copy, readonly) UIView * (^layout_top6p)(CGFloat constant6p);

/*****   top   *****/
/** top 相对于 toItem top的 偏移量constant6p */
@property (nonatomic, copy, readonly) UIView * (^layout_top6pToItemTop)(id toItem,CGFloat constant6p);

/*****   centerY   *****/
/** top 相对于 toItem centerY的 偏移量constant6p */
@property (nonatomic, copy, readonly) UIView * (^layout_top6pToItemCenterY)(id toItem,CGFloat constant6p);

/*****   bottom   *****/
/** top 相对于 toItem bottom的 偏移量constant6p */
@property (nonatomic, copy, readonly) UIView * (^layout_top6pToItemBottom)(id toItem,CGFloat constant6p);

#pragma mark - 适配6p left
/** left 相对于 toItem attribute 的 偏移量constant6p */
@property (nonatomic, copy, readonly) UIView * (^layout_left6pToItemAttribute)(id toItem,CGFloat constant6p,NSLayoutAttribute attribute);

/*****   superview   *****/
/** left 相对于 superview left的 偏移量constant6p */
@property (nonatomic, copy, readonly) UIView * (^layout_left6p)(CGFloat constant6p);

/*****   left   *****/
/** left 相对于 toItem left的 偏移量constant6p */
@property (nonatomic, copy, readonly) UIView * (^layout_left6pToItemLeft)(id toItem,CGFloat constant6p);

/*****   centerX   *****/
/** left 相对于 toItem centerX的 偏移量constant6p */
@property (nonatomic, copy, readonly) UIView * (^layout_left6pToItemCenterX)(id toItem,CGFloat constant6p);

/*****   right   *****/
/** left 相对于 toItem right的 偏移量constant6p */
@property (nonatomic, copy, readonly) UIView * (^layout_left6pToItemRight)(id toItem,CGFloat constant6p);

#pragma mark - 适配6p bottom
/** bottom 相对于 toItem attribute 的 偏移量constant6p */
@property (nonatomic, copy, readonly) UIView * (^layout_bottom6pToItemAttribute)(id toItem,CGFloat constant6p,NSLayoutAttribute attribute);

/*****   superview   *****/
/** bottom 相对于 superview bottom的 偏移量constant6p */
@property (nonatomic, copy, readonly) UIView * (^layout_bottom6p)(CGFloat constant6p);

/*****   bottom   *****/
/** bottom 相对于 toItem bottom的 偏移量constant6p */
@property (nonatomic, copy, readonly) UIView * (^layout_bottom6pToItemBottom)(id toItem,CGFloat constant6p);

/*****   top   *****/
/** bottom 相对于 toItem top的 偏移量constant6p */
@property (nonatomic, copy, readonly) UIView * (^layout_bottom6pToItemTop)(id toItem,CGFloat constant6p);

/*****   centerY   *****/
/** bottom 相对于 toItem centerY的 偏移量constant6p */
@property (nonatomic, copy, readonly) UIView * (^layout_bottom6pToItemCenterY)(id toItem,CGFloat constant6p);

#pragma mark - 适配6p right
/** right 相对于 toItem attribute 的 偏移量constant6p */
@property (nonatomic, copy, readonly) UIView * (^layout_right6pToItemAttribute)(id toItem,CGFloat constant6p,NSLayoutAttribute attribute);

/*****   superview   *****/
/** right 相对于 superview right的 偏移量constant6p */
@property (nonatomic, copy, readonly) UIView * (^layout_right6p)(CGFloat constant6p);

/*****   right   *****/
/** right 相对于 toItem right的 偏移量constant6p */
@property (nonatomic, copy, readonly) UIView * (^layout_right6pToItemRight)(id toItem,CGFloat constant6p);

/*****   left   *****/
/** right 相对于 toItem left的 偏移量constant6p */
@property (nonatomic, copy, readonly) UIView * (^layout_right6pToItemLeft)(id toItem,CGFloat constant6p);

/*****   centerX   *****/
/** right 相对于 toItem centerX的 偏移量constant6p */
@property (nonatomic, copy, readonly) UIView * (^layout_right6pToItemCenterX)(id toItem,CGFloat constant6p);

@end










