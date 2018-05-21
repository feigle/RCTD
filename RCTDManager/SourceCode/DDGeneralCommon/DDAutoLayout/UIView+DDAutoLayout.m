//
//  UIView+DDAutoLayout.m
//  DoorDu
//
//  Created by 刘和东 on 2017/12/20.
//  Copyright © 2017年 深圳市多度科技有限公司. All rights reserved.
//

#import "UIView+DDAutoLayout.h"
#import "DDScreenFitterHeaderHeader.h"
#import <objc/runtime.h>


#define KDDAutoLayoutKey_height              @"KDDAutoLayoutKey_height"
#define KDDAutoLayoutKey_width               @"KDDAutoLayoutKey_width"
#define KDDAutoLayoutKey_centerX             @"KDDAutoLayoutKey_centerX"
#define KDDAutoLayoutKey_centerY             @"KDDAutoLayoutKey_centerY"
#define KDDAutoLayoutKey_top                 @"KDDAutoLayoutKey_top"
#define KDDAutoLayoutKey_left                @"KDDAutoLayoutKey_left"
#define KDDAutoLayoutKey_bottom              @"KDDAutoLayoutKey_bottom"
#define KDDAutoLayoutKey_right               @"KDDAutoLayoutKey_right"

@implementation UIView (DDAutoLayout)

#pragma mark - 关于 一些 布局 存储

#pragma mark - 私有方法
/** 记录已经添加的 NSLayoutConstraint */
- (NSMapTable *)_autoLayoutAllDictionary
{
    __weak typeof(self) weakSelf = self;
    NSMapTable * mapTable = objc_getAssociatedObject(weakSelf, _cmd);
    if (!mapTable) {
        mapTable = [NSMapTable mapTableWithKeyOptions:NSMapTableWeakMemory valueOptions:NSMapTableWeakMemory];
        objc_setAssociatedObject(weakSelf, _cmd, mapTable, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return mapTable;
}

/** 添加  NSLayoutConstraint */
- (void)_autoLayoutAllDictionarySetObject:(id)object forKey:(id)key
{
    [[self _autoLayoutAllDictionary] setObject:object forKey:key];
}

/** 根据 key 获取 NSLayoutConstraint*/
- (NSLayoutConstraint *)_getLayoutConstraintWithKey:(NSString *)key
{
    NSLayoutConstraint * constraint = nil;
    //是否包含这个 key
    if ([[[[self _autoLayoutAllDictionary] keyEnumerator]allObjects] containsObject:key]) {
        constraint = [[self _autoLayoutAllDictionary] objectForKey:key];
    }
    return constraint;
}

/** 根据 key 移除 NSLayoutConstraint*/
- (void)_removeLayoutConstraintWithKey:(NSString *)key
{
    __weak typeof(self) weakSelf = self;
    NSLayoutConstraint * constraint = [weakSelf _getLayoutConstraintWithKey:key];
    if (constraint) {
        [constraint autoLayoutRemove];
    }
    if ([[[[weakSelf _autoLayoutAllDictionary] keyEnumerator]allObjects] containsObject:key]) {
        [[weakSelf _autoLayoutAllDictionary] removeObjectForKey:key];
    }
}

- (void)layout_clearAllConstraints
{
    __weak typeof(self) weakSelf = self;
    [[[[self _autoLayoutAllDictionary] keyEnumerator]allObjects] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (weakSelf) {
            [weakSelf _removeLayoutConstraintWithKey:obj];
        }
    }];
}

#pragma mark - 获取对应的 layoutConstraint
#pragma mark - 对外方法
// height width centerX centerY top left bottom right
/** 获取高度 LayoutConstraint */
- (NSLayoutConstraint *)layout_getHeight
{
    NSLayoutConstraint * constraint = [self _getLayoutConstraintWithKey:KDDAutoLayoutKey_height];
    return constraint;
}

/** 获取宽度 LayoutConstraint */
- (NSLayoutConstraint *)layout_getWidth
{
    NSLayoutConstraint * constraint = [self _getLayoutConstraintWithKey:KDDAutoLayoutKey_width];
    return constraint;
}

/** 获取centerX LayoutConstraint */
- (NSLayoutConstraint *)layout_getCenterX
{
    NSLayoutConstraint * constraint = [self _getLayoutConstraintWithKey:KDDAutoLayoutKey_centerX];
    return constraint;
}

/** 获取centerY LayoutConstraint */
- (NSLayoutConstraint *)layout_getCenterY
{
    NSLayoutConstraint * constraint = [self _getLayoutConstraintWithKey:KDDAutoLayoutKey_centerY];
    return constraint;
}

/** 获取top LayoutConstraint */
- (NSLayoutConstraint *)layout_getTop
{
    NSLayoutConstraint * constraint = [self _getLayoutConstraintWithKey:KDDAutoLayoutKey_top];
    return constraint;
}

/** 获取left LayoutConstraint */
- (NSLayoutConstraint *)layout_getLeft
{
    NSLayoutConstraint * constraint = [self _getLayoutConstraintWithKey:KDDAutoLayoutKey_left];
    return constraint;
}

/** 获取bottom LayoutConstraint */
- (NSLayoutConstraint *)layout_getBottom
{
    NSLayoutConstraint * constraint = [self _getLayoutConstraintWithKey:KDDAutoLayoutKey_bottom];
    return constraint;
}

/** 获取right LayoutConstraint */
- (NSLayoutConstraint *)layout_getRight
{
    NSLayoutConstraint * constraint = [self _getLayoutConstraintWithKey:KDDAutoLayoutKey_right];
    return constraint;
}

#pragma mark - 移除对应的 layoutConstraint
/** 移除高度 LayoutConstraint */
- (void)layout_removeHeightConstraint
{
    [self _removeLayoutConstraintWithKey:KDDAutoLayoutKey_height];
}

/** 移除宽度 LayoutConstraint */
- (void)layout_removeWidthConstraint
{
    [self _removeLayoutConstraintWithKey:KDDAutoLayoutKey_width];
}

/** 移除centerX LayoutConstraint */
- (void)layout_removeCenterXConstraint
{
    [self _removeLayoutConstraintWithKey:KDDAutoLayoutKey_centerX];
}

/** 移除centerY LayoutConstraint */
- (void)layout_removeCenterYConstraint
{
    [self _removeLayoutConstraintWithKey:KDDAutoLayoutKey_centerY];
}

/** 移除top LayoutConstraint */
- (void)layout_removeTopConstraint
{
    [self _removeLayoutConstraintWithKey:KDDAutoLayoutKey_top];
}

/** 移除left LayoutConstraint */
- (void)layout_removeLeftConstraint
{
    [self _removeLayoutConstraintWithKey:KDDAutoLayoutKey_left];
}

/** 移除bottom LayoutConstraint */
- (void)layout_removeBottomConstraint
{
    [self _removeLayoutConstraintWithKey:KDDAutoLayoutKey_bottom];
}

/** 移除right LayoutConstraint */
- (void)layout_removeRightConstraint
{
    [self _removeLayoutConstraintWithKey:KDDAutoLayoutKey_right];
}

//////////////////////////////////  界面布局  ////////////////////////////////////////

#pragma mark - 获取布局到哪个view上面
- (id)_getToItem:(id)item
{
    if ([item isKindOfClass:[DDAutoLayoutAttribute class]]) {
        DDAutoLayoutAttribute *itemm = (DDAutoLayoutAttribute*)item;
        return itemm.item;
    }
    return item;
}

#pragma mark - 设置高度
/** 设置高度 */
- (UIView *(^)(CGFloat))layout_height
{
    __weak typeof(self) weakSelf = self;
    return ^ (CGFloat height) {
        weakSelf.translatesAutoresizingMaskIntoConstraints = NO;
        [weakSelf _removeLayoutConstraintWithKey:KDDAutoLayoutKey_height];
        
        NSLayoutConstraint * constraint = [NSLayoutConstraint constraintWithItem:weakSelf attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:height];
        
        UIView * addConstraintView = [constraint getAddConstraintView:nil];
        [addConstraintView addConstraint:constraint];
        
        [weakSelf _autoLayoutAllDictionarySetObject:constraint forKey:KDDAutoLayoutKey_height];
        return weakSelf;
    };
}
/** 高度等于 toItem高度的比 ratio */
- (UIView *(^)(id, CGFloat))layout_heightToItemRatio
{
    __weak typeof(self) weakSelf = self;
    return ^ (id toItem,CGFloat ratio) {
        weakSelf.translatesAutoresizingMaskIntoConstraints = NO;
        [weakSelf _removeLayoutConstraintWithKey:KDDAutoLayoutKey_height];

        NSLayoutConstraint * constraint = [NSLayoutConstraint constraintWithItem:weakSelf attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:[weakSelf _getToItem:toItem] attribute:NSLayoutAttributeHeight multiplier:ratio constant:0];
        
        UIView * addConstraintView = [constraint getAddConstraintView:toItem];
        [addConstraintView addConstraint:constraint];
        
        [weakSelf _autoLayoutAllDictionarySetObject:constraint forKey:KDDAutoLayoutKey_height];
        return weakSelf;
    };
}
/** 高度等于 toItem的高度 */
- (UIView *(^)(id))layout_heightEqualToItem
{
    __weak typeof(self) weakSelf = self;
    return ^ (id toItem) {
        return weakSelf.layout_heightToItemRatio(toItem, 1.0);;
    };
}
/** 高度等于 superview高度 */
- (UIView *(^)(void))layout_heightEqualToSuperview
{
    __weak typeof(self) weakSelf = self;
    return ^ (void) {
        return weakSelf.layout_heightToItemRatio(weakSelf.superview, 1.0);;
    };
}
/** 高度等于 superview高度的比 ratio */
- (UIView *(^)(CGFloat))layout_heightRatio
{
    __weak typeof(self) weakSelf = self;
    return ^ (CGFloat ratio) {
        return weakSelf.layout_heightToItemRatio(weakSelf.superview, ratio);;
    };
}

/** 高度等于 toItem高度的比 ratio */
- (UIView *(^)(CGFloat))layout_heightWidthRatio
{
    __weak typeof(self) weakSelf = self;
    return ^ (CGFloat ratio) {
        weakSelf.translatesAutoresizingMaskIntoConstraints = NO;
        [weakSelf _removeLayoutConstraintWithKey:KDDAutoLayoutKey_height];

        NSLayoutConstraint * constraint = [NSLayoutConstraint constraintWithItem:weakSelf attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:weakSelf attribute:NSLayoutAttributeWidth multiplier:ratio constant:0];
        
        UIView * addConstraintView = [constraint getAddConstraintView:nil];
        [addConstraintView addConstraint:constraint];
        
        [weakSelf _autoLayoutAllDictionarySetObject:constraint forKey:KDDAutoLayoutKey_height];
        return weakSelf;
    };
}


#pragma mark - 设置宽度
/** 设置宽度 */
- (UIView *(^)(CGFloat))layout_width
{
    __weak typeof(self) weakSelf = self;
    return ^ (CGFloat width) {
        weakSelf.translatesAutoresizingMaskIntoConstraints = NO;
        [weakSelf _removeLayoutConstraintWithKey:KDDAutoLayoutKey_width];

        NSLayoutConstraint * constraint = [NSLayoutConstraint constraintWithItem:weakSelf attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:width];
        
        UIView * addConstraintView = [constraint getAddConstraintView:nil];
        [addConstraintView addConstraint:constraint];
        
        [weakSelf _autoLayoutAllDictionarySetObject:constraint forKey:KDDAutoLayoutKey_width];

        return weakSelf;
    };
}

/** 宽度等于 toItem宽度的比 ratio */
- (UIView *(^)(id, CGFloat))layout_widthToItemRatio
{
    __weak typeof(self) weakSelf = self;
    return ^ (id toItem,CGFloat ratio) {
        weakSelf.translatesAutoresizingMaskIntoConstraints = NO;
        [weakSelf _removeLayoutConstraintWithKey:KDDAutoLayoutKey_width];

        NSLayoutConstraint * constraint = [NSLayoutConstraint constraintWithItem:weakSelf attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:[weakSelf _getToItem:toItem] attribute:NSLayoutAttributeWidth multiplier:ratio constant:0];
        
        UIView * addConstraintView = [constraint getAddConstraintView:toItem];
        [addConstraintView addConstraint:constraint];
        
        [weakSelf _autoLayoutAllDictionarySetObject:constraint forKey:KDDAutoLayoutKey_width];

        return weakSelf;
    };
}

/** 宽度等于 toItem的宽度 */
- (UIView *(^)(id))layout_widthEqualToItem
{
    __weak typeof(self) weakSelf = self;
    return ^ (id toItem) {
        return weakSelf.layout_widthToItemRatio(toItem, 1.0);;
    };
}
/** 宽度等于 superview宽度 */
- (UIView *(^)(void))layout_widthEqualToSuperview
{
    __weak typeof(self) weakSelf = self;
    return ^ (void) {
        return weakSelf.layout_widthToItemRatio(weakSelf.superview, 1.0);;
    };
}
/** 宽度等于 superview宽度的比 ratio */
- (UIView *(^)(CGFloat))layout_widthRatio
{
    __weak typeof(self) weakSelf = self;
    return ^ (CGFloat ratio) {
        return weakSelf.layout_widthToItemRatio(weakSelf.superview, ratio);;
    };
}
/** 宽度等于 toItem高度的比 ratio */
- (UIView *(^)(CGFloat))layout_widthHeightRatio
{
    __weak typeof(self) weakSelf = self;
    return ^ (CGFloat ratio) {
        weakSelf.translatesAutoresizingMaskIntoConstraints = NO;
        [weakSelf _removeLayoutConstraintWithKey:KDDAutoLayoutKey_width];

        NSLayoutConstraint * constraint = [NSLayoutConstraint constraintWithItem:weakSelf attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:weakSelf attribute:NSLayoutAttributeHeight multiplier:ratio constant:0];
        
        UIView * addConstraintView = [constraint getAddConstraintView:nil];
        [addConstraintView addConstraint:constraint];
        
        [weakSelf _autoLayoutAllDictionarySetObject:constraint forKey:KDDAutoLayoutKey_width];

        return weakSelf;
    };
}

#pragma mark - 设置 centerX

/** centerX 相对于 toItem attribute 的 偏移量constant */
- (UIView *(^)(id, CGFloat, NSLayoutAttribute))layout_centerXToItemAttribute
{
    __weak typeof(self) weakSelf = self;
    return ^ (id toItem,CGFloat constant,NSLayoutAttribute attribute) {
        weakSelf.translatesAutoresizingMaskIntoConstraints = NO;
        [weakSelf _removeLayoutConstraintWithKey:KDDAutoLayoutKey_centerX];

        NSLayoutConstraint * constraint = [NSLayoutConstraint constraintWithItem:weakSelf attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:[weakSelf _getToItem:toItem] attribute:attribute multiplier:1 constant:constant];
        
        UIView * addConstraintView = [constraint getAddConstraintView:toItem];
        [addConstraintView addConstraint:constraint];
        
        [weakSelf _autoLayoutAllDictionarySetObject:constraint forKey:KDDAutoLayoutKey_centerX];

        return weakSelf;
    };
}

/*****   superview   *****/
/** centerX 相对于 superview centerX的 偏移量constant */
- (UIView *(^)(CGFloat))layout_centerX
{
    __weak typeof(self) weakSelf = self;
    return ^ (CGFloat constant) {
        return weakSelf.layout_centerXToItemAttribute(weakSelf.superview, constant, NSLayoutAttributeCenterX);;
    };
}
/** centerX 等于 superview centerX */
- (UIView *(^)(void))layout_centerXEqualToSuperview
{
    __weak typeof(self) weakSelf = self;
    return ^ (void) {
        return weakSelf.layout_centerXToItemAttribute(weakSelf.superview, 0, NSLayoutAttributeCenterX);
    };
}

/*****   centerX   *****/
/** centerX 相对于 toItem centerX的 偏移量constant */
- (UIView *(^)(id, CGFloat))layout_centerXToItemCenterX
{
    __weak typeof(self) weakSelf = self;
    return ^ (id toItem,CGFloat constant) {
        return weakSelf.layout_centerXToItemAttribute(toItem, constant, NSLayoutAttributeCenterX);
    };
}
/** centerX 等于 toItem centerX */
- (UIView *(^)(id))layout_centerXEqualToItemCenterX
{
    __weak typeof(self) weakSelf = self;
    return ^ (id toItem) {
        return weakSelf.layout_centerXToItemAttribute(toItem, 0, NSLayoutAttributeCenterX);
    };
}

/*****   left   *****/
/** centerX 相对于 toItem left的 偏移量constant */
- (UIView *(^)(id, CGFloat))layout_centerXToItemLeft
{
    __weak typeof(self) weakSelf = self;
    return ^ (id toItem,CGFloat constant) {
        return weakSelf.layout_centerXToItemAttribute(toItem, constant, NSLayoutAttributeLeft);
    };
}
/** centerX 等于 toItem left */
- (UIView *(^)(id))layout_centerXEqualToItemLeft
{
    __weak typeof(self) weakSelf = self;
    return ^ (id toItem) {
        return weakSelf.layout_centerXToItemAttribute(toItem, 0, NSLayoutAttributeLeft);
    };
}


/*****   right   *****/
/** centerX 相对于 toItem right的 偏移量constant */
- (UIView *(^)(id, CGFloat))layout_centerXToItemRight
{
    __weak typeof(self) weakSelf = self;
    return ^ (id toItem,CGFloat constant) {
        return weakSelf.layout_centerXToItemAttribute(toItem, constant, NSLayoutAttributeRight);
    };
}
/** centerX 等于 toItem right */
- (UIView *(^)(id))layout_centerXEqualToItemRight
{
    __weak typeof(self) weakSelf = self;
    return ^ (id toItem) {
        return weakSelf.layout_centerXToItemAttribute(toItem, 0, NSLayoutAttributeRight);
    };
}

#pragma mark - 设置 centerY

/** centerY 相对于 toItem attribute 的 偏移量constant */
- (UIView *(^)(id, CGFloat, NSLayoutAttribute))layout_centerYToItemAttribute
{
    __weak typeof(self) weakSelf = self;
    return ^ (id toItem,CGFloat constant,NSLayoutAttribute attribute) {
        weakSelf.translatesAutoresizingMaskIntoConstraints = NO;
        [weakSelf _removeLayoutConstraintWithKey:KDDAutoLayoutKey_centerY];

        NSLayoutConstraint * constraint = [NSLayoutConstraint constraintWithItem:weakSelf attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:[weakSelf _getToItem:toItem] attribute:attribute multiplier:1 constant:constant];
        
        UIView * addConstraintView = [constraint getAddConstraintView:toItem];
        [addConstraintView addConstraint:constraint];
        
        [weakSelf _autoLayoutAllDictionarySetObject:constraint forKey:KDDAutoLayoutKey_centerY];

        return weakSelf;
    };
}

/*****   superview   *****/
/** centerY 相对于 superview centerY的 偏移量constant */
- (UIView *(^)(CGFloat))layout_centerY
{
    __weak typeof(self) weakSelf = self;
    return ^ (CGFloat constant) {
        return weakSelf.layout_centerYToItemAttribute(weakSelf.superview, constant, NSLayoutAttributeCenterY);;
    };
}
/** centerY 等于 superview centerY */
- (UIView *(^)(void))layout_centerYEqualToSuperview
{
    __weak typeof(self) weakSelf = self;
    return ^ (void) {
        return weakSelf.layout_centerYToItemAttribute(weakSelf.superview, 0, NSLayoutAttributeCenterY);
    };
}

/*****   centerY   *****/
/** centerY 相对于 toItem centerY的 偏移量constant */
- (UIView *(^)(id, CGFloat))layout_centerYToItemCenterY
{
    __weak typeof(self) weakSelf = self;
    return ^ (id toItem,CGFloat constant) {
        return weakSelf.layout_centerYToItemAttribute(toItem, constant, NSLayoutAttributeCenterY);
    };
}

/** centerY 等于 toItem centerY */
- (UIView *(^)(id))layout_centerYEqualToItemCenterY
{
    __weak typeof(self) weakSelf = self;
    return ^ (id toItem) {
        return weakSelf.layout_centerYToItemAttribute(toItem, 0, NSLayoutAttributeCenterY);
    };
}


/*****   top   *****/
/** centerY 相对于 toItem top的 偏移量constant */
- (UIView *(^)(id, CGFloat))layout_centerYToItemTop
{
    __weak typeof(self) weakSelf = self;
    return ^ (id toItem,CGFloat constant) {
        return weakSelf.layout_centerYToItemAttribute(toItem, constant, NSLayoutAttributeTop);
    };
}
/** centerY 等于 toItem top */
- (UIView *(^)(id))layout_centerYEqualToItemTop
{
    __weak typeof(self) weakSelf = self;
    return ^ (id toItem) {
        return weakSelf.layout_centerYToItemAttribute(toItem, 0, NSLayoutAttributeTop);
    };
}

/*****   bottom   *****/
/** centerY 相对于 toItem bottom的 偏移量constant */
- (UIView *(^)(id, CGFloat))layout_centerYToItemBottom
{
    __weak typeof(self) weakSelf = self;
    return ^ (id toItem,CGFloat constant) {
        return weakSelf.layout_centerYToItemAttribute(toItem, constant, NSLayoutAttributeBottom);
    };
}
/** centerY 等于 toItem bottom */
- (UIView *(^)(id))layout_centerYEqualToItemBottom
{
    __weak typeof(self) weakSelf = self;
    return ^ (id toItem) {
        return weakSelf.layout_centerYToItemAttribute(toItem, 0, NSLayoutAttributeBottom);
    };
}


#pragma mark - 设置 center
/** center 相对于 toItem center的 偏移量point */
- (UIView *(^)(id, CGPoint))layout_centerToItemCenter
{
    __weak typeof(self) weakSelf = self;
    return ^ (id toItem,CGPoint point) {
        return weakSelf.layout_centerXToItemCenterX(toItem, point.x).layout_centerYToItemCenterY(toItem, point.y);;
    };
}
/** center 等于 toItem center */
- (UIView *(^)(id))layout_centerEqualToItemCenter
{
    __weak typeof(self) weakSelf = self;
    return ^ (id toItem) {
        return weakSelf.layout_centerToItemCenter(toItem, CGPointMake(0, 0));;
    };
}
/** center 相对于 superview center的 偏移量 x y  */
- (UIView *(^)(CGFloat, CGFloat))layout_center
{
    __weak typeof(self) weakSelf = self;
    return ^ (CGFloat x, CGFloat y) {
        return weakSelf.layout_centerToItemCenter(weakSelf.superview, CGPointMake(x, y));
    };
}
/** center 等于 superview center */
- (UIView *(^)(void))layout_centerEqualToSuperview
{
    __weak typeof(self) weakSelf = self;
    return ^ (void) {
        return weakSelf.layout_centerToItemCenter(weakSelf.superview, CGPointMake(0, 0));
    };
}


#pragma mark - 设置 top
/** top 相对于 toItem attribute 的 偏移量constant */
- (UIView *(^)(id, CGFloat, NSLayoutAttribute))layout_topToItemAttribute
{
    __weak typeof(self) weakSelf = self;
    return ^ (id toItem,CGFloat constant,NSLayoutAttribute attribute) {
        weakSelf.translatesAutoresizingMaskIntoConstraints = NO;
        [weakSelf _removeLayoutConstraintWithKey:KDDAutoLayoutKey_top];

        NSLayoutConstraint * constraint = [NSLayoutConstraint constraintWithItem:weakSelf attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:[weakSelf _getToItem:toItem] attribute:attribute multiplier:1 constant:constant];
        
        UIView * addConstraintView = [constraint getAddConstraintView:toItem];
        [addConstraintView addConstraint:constraint];
        
        [weakSelf _autoLayoutAllDictionarySetObject:constraint forKey:KDDAutoLayoutKey_top];

        return weakSelf;
    };
}

/*****   superview   *****/
/** top 相对于 superview top的 偏移量constant */
- (UIView *(^)(CGFloat))layout_top
{
    __weak typeof(self) weakSelf = self;
    return ^ (CGFloat constant) {
        return weakSelf.layout_topToItemAttribute(weakSelf.superview, constant, NSLayoutAttributeTop);;
    };
}
/** top 等于 superview top */
- (UIView *(^)(void))layout_topEqualToSuperview
{
    __weak typeof(self) weakSelf = self;
    return ^ (void) {
        return weakSelf.layout_topToItemAttribute(weakSelf.superview, 0, NSLayoutAttributeTop);
    };
}

/*****   top   *****/
/** top 相对于 toItem top的 偏移量constant */
- (UIView *(^)(id, CGFloat))layout_topToItemTop
{
    __weak typeof(self) weakSelf = self;
    return ^ (id toItem,CGFloat constant) {
        return weakSelf.layout_topToItemAttribute(toItem, constant, NSLayoutAttributeTop);
    };
}
/** top 等于 toItem top */
- (UIView *(^)(id))layout_topEqualToItemTop
{
    __weak typeof(self) weakSelf = self;
    return ^ (id toItem) {
        return weakSelf.layout_topToItemAttribute(toItem, 0, NSLayoutAttributeTop);
    };
}

/*****   centerY   *****/
/** top 相对于 toItem centerY的 偏移量constant */
- (UIView *(^)(id, CGFloat))layout_topToItemCenterY
{
    __weak typeof(self) weakSelf = self;
    return ^ (id toItem,CGFloat constant) {
        return weakSelf.layout_topToItemAttribute(toItem, constant, NSLayoutAttributeCenterY);
    };
}
/** top 等于 toItem centerY */
- (UIView *(^)(id))layout_topEqualToItemCenterY
{
    __weak typeof(self) weakSelf = self;
    return ^ (id toItem) {
        return weakSelf.layout_topToItemAttribute(toItem, 0, NSLayoutAttributeCenterY);
    };
}

/*****   bottom   *****/
/** top 相对于 toItem bottom的 偏移量constant */
- (UIView *(^)(id, CGFloat))layout_topToItemBottom
{
    __weak typeof(self) weakSelf = self;
    return ^ (id toItem,CGFloat constant) {
        return weakSelf.layout_topToItemAttribute(toItem, constant, NSLayoutAttributeBottom);
    };
}
/** top 等于 toItem bottom */
- (UIView *(^)(id))layout_topEqualToItemBottom
{
    __weak typeof(self) weakSelf = self;
    return ^ (id toItem) {
        return weakSelf.layout_topToItemAttribute(toItem, 0, NSLayoutAttributeBottom);
    };
}

#pragma mark - 设置 left
/** left 相对于 toItem attribute 的 偏移量constant */
- (UIView *(^)(id, CGFloat, NSLayoutAttribute))layout_leftToItemAttribute
{
    __weak typeof(self) weakSelf = self;
    return ^ (id toItem,CGFloat constant,NSLayoutAttribute attribute) {
        weakSelf.translatesAutoresizingMaskIntoConstraints = NO;
        [weakSelf _removeLayoutConstraintWithKey:KDDAutoLayoutKey_left];

        NSLayoutConstraint * constraint = [NSLayoutConstraint constraintWithItem:weakSelf attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:[weakSelf _getToItem:toItem] attribute:attribute multiplier:1 constant:constant];
        
        UIView * addConstraintView = [constraint getAddConstraintView:toItem];
        [addConstraintView addConstraint:constraint];
        
        [weakSelf _autoLayoutAllDictionarySetObject:constraint forKey:KDDAutoLayoutKey_left];

        return weakSelf;
    };
}

/*****   superview   *****/
/** left 相对于 superview left的 偏移量constant */
- (UIView *(^)(CGFloat))layout_left
{
    __weak typeof(self) weakSelf = self;
    return ^ (CGFloat constant) {
        return weakSelf.layout_leftToItemAttribute(weakSelf.superview, constant, NSLayoutAttributeLeft);
    };
}
/** left 等于 superview left */
- (UIView *(^)(void))layout_leftEqualToSuperview
{
    __weak typeof(self) weakSelf = self;
    return ^ (void) {
        return weakSelf.layout_leftToItemAttribute(weakSelf.superview, 0, NSLayoutAttributeLeft);
    };
}

/*****   left   *****/
/** left 相对于 toItem left的 偏移量constant */
- (UIView *(^)(id, CGFloat))layout_leftToItemLeft
{
    __weak typeof(self) weakSelf = self;
    return ^ (id toItem,CGFloat constant) {
        return weakSelf.layout_leftToItemAttribute(toItem, constant, NSLayoutAttributeLeft);
    };
}
/** left 等于 toItem left */
- (UIView *(^)(id))layout_leftEqualToItemLeft
{
    __weak typeof(self) weakSelf = self;
    return ^ (id toItem) {
        return weakSelf.layout_leftToItemAttribute(toItem, 0, NSLayoutAttributeLeft);
    };
}

/*****   centerX   *****/
/** left 相对于 toItem centerX的 偏移量constant */
- (UIView *(^)(id, CGFloat))layout_leftToItemCenterX
{
    __weak typeof(self) weakSelf = self;
    return ^ (id toItem,CGFloat constant) {
        return weakSelf.layout_leftToItemAttribute(toItem, constant, NSLayoutAttributeCenterX);
    };
}
/** left 等于 toItem centerX */
- (UIView *(^)(id))layout_leftEqualToItemCenterX
{
    __weak typeof(self) weakSelf = self;
    return ^ (id toItem) {
        return weakSelf.layout_leftToItemAttribute(toItem, 0, NSLayoutAttributeCenterX);
    };
}

/*****   right   *****/
/** left 相对于 toItem right的 偏移量constant */
- (UIView *(^)(id, CGFloat))layout_leftToItemRight
{
    __weak typeof(self) weakSelf = self;
    return ^ (id toItem,CGFloat constant) {
        return weakSelf.layout_leftToItemAttribute(toItem, constant, NSLayoutAttributeRight);
    };
}
/** left 等于 toItem right */
- (UIView *(^)(id))layout_leftEqualToItemRight
{
    __weak typeof(self) weakSelf = self;
    return ^ (id toItem) {
        return weakSelf.layout_leftToItemAttribute(toItem, 0, NSLayoutAttributeRight);
    };
}


#pragma mark - 设置 bottom
/** bottom 相对于 toItem attribute 的 偏移量constant */
- (UIView *(^)(id, CGFloat, NSLayoutAttribute))layout_bottomToItemAttribute
{
    __weak typeof(self) weakSelf = self;
    return ^ (id toItem,CGFloat constant,NSLayoutAttribute attribute) {
        weakSelf.translatesAutoresizingMaskIntoConstraints = NO;
        [weakSelf _removeLayoutConstraintWithKey:KDDAutoLayoutKey_bottom];

        NSLayoutConstraint * constraint = [NSLayoutConstraint constraintWithItem:weakSelf attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:[weakSelf _getToItem:toItem] attribute:attribute multiplier:1 constant:constant];
        
        UIView * addConstraintView = [constraint getAddConstraintView:toItem];
        [addConstraintView addConstraint:constraint];
        
        [weakSelf _autoLayoutAllDictionarySetObject:constraint forKey:KDDAutoLayoutKey_bottom];

        return weakSelf;
    };
}

/*****   superview   *****/
/** bottom 相对于 superview bottom的 偏移量constant */
- (UIView *(^)(CGFloat))layout_bottom
{
    __weak typeof(self) weakSelf = self;
    return ^ (CGFloat constant) {
        return weakSelf.layout_bottomToItemAttribute(weakSelf.superview, constant, NSLayoutAttributeBottom);
    };
}
/** bottom 等于 superview bottom */
- (UIView *(^)(void))layout_bottomEqualToSuperview
{
    __weak typeof(self) weakSelf = self;
    return ^ (void) {
        return weakSelf.layout_bottomToItemAttribute(weakSelf.superview,0, NSLayoutAttributeBottom);
    };
}

/*****   bottom   *****/
/** bottom 相对于 toItem bottom的 偏移量constant */
- (UIView *(^)(id, CGFloat))layout_bottomToItemBottom
{
    __weak typeof(self) weakSelf = self;
    return ^ (id toItem,CGFloat constant) {
        return weakSelf.layout_bottomToItemAttribute(toItem, constant, NSLayoutAttributeBottom);
    };
}
/** bottom 等于 toItem bottom */
- (UIView *(^)(id))layout_bottomEqualToItemBottom
{
    __weak typeof(self) weakSelf = self;
    return ^ (id toItem) {
        return weakSelf.layout_bottomToItemAttribute(toItem, 0, NSLayoutAttributeBottom);
    };
}

/*****   top   *****/
/** bottom 相对于 toItem top的 偏移量constant */
- (UIView *(^)(id, CGFloat))layout_bottomToItemTop
{
    __weak typeof(self) weakSelf = self;
    return ^ (id toItem,CGFloat constant) {
        return weakSelf.layout_bottomToItemAttribute(toItem, constant, NSLayoutAttributeTop);
    };
}
/** bottom 等于 toItem top */
- (UIView *(^)(id))layout_bottomEqualToItemTop
{
    __weak typeof(self) weakSelf = self;
    return ^ (id toItem) {
        return weakSelf.layout_bottomToItemAttribute(toItem, 0, NSLayoutAttributeTop);
    };
}

/*****   centerY   *****/
/** bottom 相对于 toItem centerY的 偏移量constant */
- (UIView *(^)(id, CGFloat))layout_bottomToItemCenterY
{
    __weak typeof(self) weakSelf = self;
    return ^ (id toItem,CGFloat constant) {
        return weakSelf.layout_bottomToItemAttribute(toItem, constant, NSLayoutAttributeCenterY);
    };
}
/** bottom 等于 toItem centerY */
- (UIView *(^)(id))layout_bottomEqualToItemCenterY
{
    __weak typeof(self) weakSelf = self;
    return ^ (id toItem) {
        return weakSelf.layout_bottomToItemAttribute(toItem, 0, NSLayoutAttributeCenterY);
    };
}

#pragma mark - 设置 right
/** right 相对于 toItem attribute 的 偏移量constant */
- (UIView *(^)(id, CGFloat, NSLayoutAttribute))layout_rightToItemAttribute
{
    __weak typeof(self) weakSelf = self;
    return ^ (id toItem,CGFloat constant,NSLayoutAttribute attribute) {
        weakSelf.translatesAutoresizingMaskIntoConstraints = NO;
        [weakSelf _removeLayoutConstraintWithKey:KDDAutoLayoutKey_right];
        
        NSLayoutConstraint * constraint = [NSLayoutConstraint constraintWithItem:weakSelf attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:[weakSelf _getToItem:toItem] attribute:attribute multiplier:1 constant:constant];
        
        UIView * addConstraintView = [constraint getAddConstraintView:toItem];
        [addConstraintView addConstraint:constraint];
        
        [weakSelf _autoLayoutAllDictionarySetObject:constraint forKey:KDDAutoLayoutKey_right];
        
        return weakSelf;
    };
}

/*****   superview   *****/
/** right 相对于 superview right的 偏移量constant */
- (UIView *(^)(CGFloat))layout_right
{
    __weak typeof(self) weakSelf = self;
    return ^ (CGFloat constant) {
        return weakSelf.layout_rightToItemAttribute(weakSelf.superview, constant, NSLayoutAttributeRight);
    };
}
/** right 等于 superview right */
- (UIView *(^)(void))layout_rightEqualToSuperview
{
    __weak typeof(self) weakSelf = self;
    return ^ (void) {
        return weakSelf.layout_rightToItemAttribute(weakSelf.superview, 0, NSLayoutAttributeRight);
    };
}

/*****   right   *****/
/** right 相对于 toItem right的 偏移量constant */
- (UIView *(^)(id, CGFloat))layout_rightToItemRight
{
    __weak typeof(self) weakSelf = self;
    return ^ (id toItem,CGFloat constant) {
        return weakSelf.layout_rightToItemAttribute(toItem, constant, NSLayoutAttributeRight);
    };
}
/** right 等于 toItem right */
- (UIView *(^)(id))layout_rightEqualToItemRight
{
    __weak typeof(self) weakSelf = self;
    return ^ (id toItem) {
        return weakSelf.layout_rightToItemAttribute(toItem, 0, NSLayoutAttributeRight);
    };
}

/*****   left   *****/
/** right 相对于 toItem left的 偏移量constant */
- (UIView *(^)(id, CGFloat))layout_rightToItemLeft
{
    __weak typeof(self) weakSelf = self;
    return ^ (id toItem,CGFloat constant) {
        return weakSelf.layout_rightToItemAttribute(toItem, constant, NSLayoutAttributeLeft);
    };
}
/** right 等于 toItem left */
- (UIView *(^)(id))layout_rightEqualToItemLeft
{
    __weak typeof(self) weakSelf = self;
    return ^ (id toItem) {
        return weakSelf.layout_rightToItemAttribute(toItem, 0, NSLayoutAttributeLeft);
    };
}

/*****   centerX   *****/
/** right 相对于 toItem centerX的 偏移量constant */
- (UIView *(^)(id, CGFloat))layout_rightToItemCenterX
{
    __weak typeof(self) weakSelf = self;
    return ^ (id toItem,CGFloat constant) {
        return weakSelf.layout_rightToItemAttribute(toItem, constant, NSLayoutAttributeCenterX);
    };
}
/** right 等于 toItem centerX */
- (UIView *(^)(id))layout_rightEqualToItemCenterX
{
    __weak typeof(self) weakSelf = self;
    return ^ (id toItem) {
        return weakSelf.layout_rightToItemAttribute(toItem, 0, NSLayoutAttributeCenterX);
    };
}

#pragma mark ---------------------  以iPhone 6 设计的UI图
#pragma mark - 适配6 高度
/** 设置高度 */
- (UIView *(^)(CGFloat))layout_height6
{
    __weak typeof(self) weakSelf = self;
    return ^ (CGFloat height6) {
        return weakSelf.layout_height(DDAdapter6Height(height6));
    };
}

#pragma mark - 适配6 宽度
/** 设置宽度 */
- (UIView *(^)(CGFloat))layout_width6
{
    __weak typeof(self) weakSelf = self;
    return ^ (CGFloat width6) {
        return weakSelf.layout_width(DDAdapter6Width(width6));
    };
}

#pragma mark - 适配6 centerX
/** centerX 相对于 toItem attribute 的 偏移量constant6 */
- (UIView *(^)(id, CGFloat, NSLayoutAttribute))layout_centerX6ToItemAttribute
{
    __weak typeof(self) weakSelf = self;
    return ^ (id toItem,CGFloat constant6,NSLayoutAttribute attribute) {
        return weakSelf.layout_centerXToItemAttribute(toItem, DDAdapter6Width(constant6), attribute);;
    };
}

/*****   superview   *****/
/** centerX 相对于 superview centerX的 偏移量constant6 */
- (UIView *(^)(CGFloat))layout_centerX6
{
    __weak typeof(self) weakSelf = self;
    return ^ (CGFloat constant6) {
        return weakSelf.layout_centerX6ToItemAttribute(weakSelf.superview, constant6, NSLayoutAttributeCenterX);
    };
}


/*****   centerX   *****/
/** centerX 相对于 toItem centerX的 偏移量constant6 */
- (UIView *(^)(id,CGFloat))layout_centerX6ToItemCenterX
{
    __weak typeof(self) weakSelf = self;
    return ^ (id toItem,CGFloat constant6) {
        return weakSelf.layout_centerX6ToItemAttribute(toItem, constant6, NSLayoutAttributeCenterX);
    };
}

/*****   left   *****/
/** centerX 相对于 toItem left的 偏移量constant6 */
- (UIView *(^)(id,CGFloat))layout_centerX6ToItemLeft
{
    __weak typeof(self) weakSelf = self;
    return ^ (id toItem,CGFloat constant6) {
        return weakSelf.layout_centerX6ToItemAttribute(toItem, constant6, NSLayoutAttributeLeft);
    };
}

/*****   right   *****/
/** centerX 相对于 toItem right的 偏移量constant6 */
- (UIView *(^)(id,CGFloat))layout_centerX6ToItemRight
{
    __weak typeof(self) weakSelf = self;
    return ^ (id toItem,CGFloat constant6) {
        return weakSelf.layout_centerX6ToItemAttribute(toItem, constant6, NSLayoutAttributeRight);
    };
}

#pragma mark - 适配6 centerY
/** centerY 相对于 toItem attribute 的 偏移量constant6 */
- (UIView *(^)(id, CGFloat, NSLayoutAttribute))layout_centerY6ToItemAttribute
{
    __weak typeof(self) weakSelf = self;
    return ^ (id toItem,CGFloat constant6,NSLayoutAttribute attribute) {
        return weakSelf.layout_centerYToItemAttribute(toItem, DDAdapter6Height(constant6), attribute);;
    };
}


/*****   superview   *****/
/** centerY 相对于 superview centerY的 偏移量constant6 */
- (UIView *(^)(CGFloat))layout_centerY6
{
    __weak typeof(self) weakSelf = self;
    return ^ (CGFloat constant6) {
        return weakSelf.layout_centerY6ToItemAttribute(weakSelf.superview, constant6, NSLayoutAttributeCenterY);
    };
}

/*****   centerY   *****/
/** centerY 相对于 toItem centerY的 偏移量constant6 */
- (UIView *(^)(id,CGFloat))layout_centerY6ToItemCenterY
{
    __weak typeof(self) weakSelf = self;
    return ^ (id toItem,CGFloat constant6) {
        return weakSelf.layout_centerY6ToItemAttribute(toItem, constant6, NSLayoutAttributeCenterY);
    };
}

/*****   top   *****/
/** centerY 相对于 toItem top的 偏移量constant6 */
- (UIView *(^)(id,CGFloat))layout_centerY6ToItemTop
{
    __weak typeof(self) weakSelf = self;
    return ^ (id toItem,CGFloat constant6) {
        return weakSelf.layout_centerY6ToItemAttribute(toItem, constant6, NSLayoutAttributeTop);
    };
}

/*****   bottom   *****/
/** centerY 相对于 toItem bottom的 偏移量constant6 */
- (UIView *(^)(id,CGFloat))layout_centerY6ToItemBottom
{
    __weak typeof(self) weakSelf = self;
    return ^ (id toItem,CGFloat constant6) {
        return weakSelf.layout_centerY6ToItemAttribute(toItem, constant6, NSLayoutAttributeBottom);
    };
}

#pragma mark - 适配6 center
/** center 相对于 toItem center的 偏移量point6 */
- (UIView *(^)(id, CGPoint))layout_center6ToItemCenter
{
    __weak typeof(self) weakSelf = self;
    return ^ (id toItem,CGPoint point6) {
        return weakSelf.layout_centerToItemCenter(toItem, CGPointMake(DDAdapter6Width(point6.x), DDAdapter6Height(point6.y)));;
    };
}

/** center 相对于 superview center的 偏移量 x6 y6  */
- (UIView *(^)(CGFloat, CGFloat))layout_center6
{
    __weak typeof(self) weakSelf = self;
    return ^ (CGFloat x6, CGFloat y6) {
        return weakSelf.layout_center(DDAdapter6Width(x6), DDAdapter6Height(y6));
    };
}

#pragma mark - 适配6 top
/** top 相对于 toItem attribute 的 偏移量constant6 */
- (UIView *(^)(id, CGFloat, NSLayoutAttribute))layout_top6ToItemAttribute
{
    __weak typeof(self) weakSelf = self;
    return ^ (id toItem,CGFloat constant6,NSLayoutAttribute attribute) {
        return weakSelf.layout_topToItemAttribute(toItem, DDAdapter6Height(constant6), attribute);
    };
}

/*****   superview   *****/
/** top 相对于 superview top的 偏移量constant6 */
- (UIView *(^)(CGFloat))layout_top6
{
    __weak typeof(self) weakSelf = self;
    return ^ (CGFloat constant6) {
        return weakSelf.layout_top6ToItemAttribute(weakSelf.superview, constant6, NSLayoutAttributeTop);
    };
}

/*****   top   *****/
/** top 相对于 toItem top的 偏移量constant6 */
- (UIView *(^)(id,CGFloat))layout_top6ToItemTop
{
    __weak typeof(self) weakSelf = self;
    return ^ (id toItem,CGFloat constant6) {
        return weakSelf.layout_top6ToItemAttribute(toItem, constant6, NSLayoutAttributeTop);
    };
}

/*****   centerY   *****/
/** top 相对于 toItem centerY的 偏移量constant6 */
- (UIView *(^)(id,CGFloat))layout_top6ToItemCenterY
{
    __weak typeof(self) weakSelf = self;
    return ^ (id toItem,CGFloat constant6) {
        return weakSelf.layout_top6ToItemAttribute(toItem, constant6, NSLayoutAttributeCenterY);
    };
}

/*****   bottom   *****/
/** top 相对于 toItem bottom的 偏移量constant6 */
- (UIView *(^)(id,CGFloat))layout_top6ToItemBottom
{
    __weak typeof(self) weakSelf = self;
    return ^ (id toItem,CGFloat constant6) {
        return weakSelf.layout_top6ToItemAttribute(toItem, constant6, NSLayoutAttributeBottom);
    };
}

#pragma mark - 适配6 left
/** left 相对于 toItem attribute 的 偏移量constant6 */
- (UIView *(^)(id, CGFloat, NSLayoutAttribute))layout_left6ToItemAttribute
{
    __weak typeof(self) weakSelf = self;
    return ^ (id toItem,CGFloat constant6,NSLayoutAttribute attribute) {
        return weakSelf.layout_leftToItemAttribute(toItem, DDAdapter6Width(constant6), attribute);;
    };
}

/*****   superview   *****/
/** left 相对于 superview left的 偏移量constant6 */
- (UIView *(^)(CGFloat))layout_left6
{
    __weak typeof(self) weakSelf = self;
    return ^ (CGFloat constant6) {
        return weakSelf.layout_left6ToItemAttribute(weakSelf.superview, constant6, NSLayoutAttributeLeft);
    };
}

/*****   left   *****/
/** left 相对于 toItem left的 偏移量constant6 */
- (UIView *(^)(id, CGFloat))layout_left6ToItemLeft
{
    __weak typeof(self) weakSelf = self;
    return ^ (id toItem,CGFloat constant6) {
        return weakSelf.layout_left6ToItemAttribute(toItem, constant6, NSLayoutAttributeLeft);
    };
}

/*****   centerX   *****/
/** left 相对于 toItem centerX的 偏移量constant6 */
- (UIView *(^)(id, CGFloat))layout_left6ToItemCenterX
{
    __weak typeof(self) weakSelf = self;
    return ^ (id toItem,CGFloat constant6) {
        return weakSelf.layout_left6ToItemAttribute(toItem, constant6, NSLayoutAttributeCenterX);
    };
}

/*****   right   *****/
/** left 相对于 toItem right的 偏移量constant6 */
- (UIView *(^)(id, CGFloat))layout_left6ToItemRight
{
    __weak typeof(self) weakSelf = self;
    return ^ (id toItem,CGFloat constant6) {
        return weakSelf.layout_left6ToItemAttribute(toItem, constant6, NSLayoutAttributeRight);
    };
}

#pragma mark - 适配6 bottom
/** bottom 相对于 toItem attribute 的 偏移量constant6 */
- (UIView *(^)(id, CGFloat, NSLayoutAttribute))layout_bottom6ToItemAttribute
{
    __weak typeof(self) weakSelf = self;
    return ^ (id toItem,CGFloat constant6,NSLayoutAttribute attribute) {
        return weakSelf.layout_bottomToItemAttribute(toItem, DDAdapter6Height(constant6), attribute);
    };
}

/*****   superview   *****/
/** bottom 相对于 superview bottom的 偏移量constant6 */
- (UIView *(^)(CGFloat))layout_bottom6
{
    __weak typeof(self) weakSelf = self;
    return ^ (CGFloat constant6) {
        return weakSelf.layout_bottom6ToItemAttribute(weakSelf.superview, constant6, NSLayoutAttributeBottom);
    };
}

/*****   bottom   *****/
/** bottom 相对于 toItem bottom的 偏移量constant6 */
- (UIView *(^)(id,CGFloat))layout_bottom6ToItemBottom
{
    __weak typeof(self) weakSelf = self;
    return ^ (id toItem,CGFloat constant6) {
        return weakSelf.layout_bottom6ToItemAttribute(toItem, constant6, NSLayoutAttributeBottom);
    };
}

/*****   top   *****/
/** bottom 相对于 toItem top的 偏移量constant6 */
- (UIView *(^)(id,CGFloat))layout_bottom6ToItemTop
{
    __weak typeof(self) weakSelf = self;
    return ^ (id toItem,CGFloat constant6) {
        return weakSelf.layout_bottom6ToItemAttribute(toItem, constant6, NSLayoutAttributeTop);
    };
}

/*****   centerY   *****/
/** bottom 相对于 toItem centerY的 偏移量constant6 */
- (UIView *(^)(id,CGFloat))layout_bottom6ToItemCenterY
{
    __weak typeof(self) weakSelf = self;
    return ^ (id toItem,CGFloat constant6) {
        return weakSelf.layout_bottom6ToItemAttribute(toItem, constant6, NSLayoutAttributeCenterY);
    };
}

#pragma mark - 适配6 right
/** right 相对于 toItem attribute 的 偏移量constant6 */
- (UIView *(^)(id, CGFloat, NSLayoutAttribute))layout_right6ToItemAttribute
{
    __weak typeof(self) weakSelf = self;
    return ^ (id toItem,CGFloat constant6,NSLayoutAttribute attribute) {
        return weakSelf.layout_rightToItemAttribute(toItem, DDAdapter6Width(constant6), attribute);
    };
}

/*****   superview   *****/
/** right 相对于 superview right的 偏移量constant6 */
- (UIView *(^)(CGFloat))layout_right6
{
    __weak typeof(self) weakSelf = self;
    return ^ (CGFloat constant6) {
        return weakSelf.layout_right6ToItemAttribute(weakSelf.superview, constant6, NSLayoutAttributeRight);
    };
}

/*****   right   *****/
/** right 相对于 toItem right的 偏移量constant6 */
- (UIView *(^)(id,CGFloat))layout_right6ToItemRight
{
    __weak typeof(self) weakSelf = self;
    return ^ (id toItem,CGFloat constant6) {
        return weakSelf.layout_right6ToItemAttribute(toItem, constant6, NSLayoutAttributeRight);
    };
}

/*****   left   *****/
/** right 相对于 toItem left的 偏移量constant6 */
- (UIView *(^)(id,CGFloat))layout_right6ToItemLeft
{
    __weak typeof(self) weakSelf = self;
    return ^ (id toItem,CGFloat constant6) {
        return weakSelf.layout_right6ToItemAttribute(toItem, constant6, NSLayoutAttributeLeft);
    };
}

/*****   centerX   *****/
/** right 相对于 toItem centerX的 偏移量constant6 */
- (UIView *(^)(id,CGFloat))layout_right6ToItemCenterX
{
    __weak typeof(self) weakSelf = self;
    return ^ (id toItem,CGFloat constant6) {
        return weakSelf.layout_right6ToItemAttribute(toItem, constant6, NSLayoutAttributeCenterX);
    };
}

#pragma mark ---------------------  以iPhone 6p 设计的UI图
#pragma mark - 适配6p 高度
/** 设置高度 */
- (UIView *(^)(CGFloat))layout_height6p
{
    __weak typeof(self) weakSelf = self;
    return ^ (CGFloat height6p) {
        return weakSelf.layout_height(DDAdapter6PHeight(height6p));
    };
}

#pragma mark - 适配6 宽度
/** 设置宽度 */
- (UIView *(^)(CGFloat))layout_width6p
{
    __weak typeof(self) weakSelf = self;
    return ^ (CGFloat width6p) {
        return weakSelf.layout_width(DDAdapter6PWidth(width6p));
    };
}


#pragma mark - 适配6p centerX
/** centerX 相对于 toItem attribute 的 偏移量constant6p */
- (UIView *(^)(id, CGFloat, NSLayoutAttribute))layout_centerX6pToItemAttribute
{
    __weak typeof(self) weakSelf = self;
    return ^ (id toItem,CGFloat constant6p,NSLayoutAttribute attribute) {
        return weakSelf.layout_centerXToItemAttribute(toItem, DDAdapter6PWidth(constant6p), attribute);;
    };
}

/*****   superview   *****/
/** centerX 相对于 superview centerX的 偏移量constant6p */
- (UIView *(^)(CGFloat))layout_centerX6p
{
    __weak typeof(self) weakSelf = self;
    return ^ (CGFloat constant6p) {
        return weakSelf.layout_centerX6pToItemAttribute(weakSelf.superview, constant6p, NSLayoutAttributeCenterX);
    };
}

/*****   centerX   *****/
/** centerX 相对于 toItem centerX的 偏移量constant6p */
- (UIView *(^)(id,CGFloat))layout_centerX6pToItemCenterX
{
    __weak typeof(self) weakSelf = self;
    return ^ (id toItem,CGFloat constant6p) {
        return weakSelf.layout_centerX6pToItemAttribute(toItem, constant6p, NSLayoutAttributeCenterX);
    };
}

/*****   left   *****/
/** centerX 相对于 toItem left的 偏移量constant6p */
- (UIView *(^)(id,CGFloat))layout_centerX6pToItemLeft
{
    __weak typeof(self) weakSelf = self;
    return ^ (id toItem,CGFloat constant6p) {
        return weakSelf.layout_centerX6pToItemAttribute(toItem, constant6p, NSLayoutAttributeLeft);
    };
}

/*****   right   *****/
/** centerX 相对于 toItem right的 偏移量constant6p */
- (UIView *(^)(id,CGFloat))layout_centerX6pToItemRight
{
    __weak typeof(self) weakSelf = self;
    return ^ (id toItem,CGFloat constant6p) {
        return weakSelf.layout_centerX6pToItemAttribute(toItem, constant6p, NSLayoutAttributeRight);
    };
}

#pragma mark - 适配6p centerY
/** centerY 相对于 toItem attribute 的 偏移量constant6p  */
- (UIView *(^)(id, CGFloat, NSLayoutAttribute))layout_centerY6pToItemAttribute
{
    __weak typeof(self) weakSelf = self;
    return ^ (id toItem,CGFloat constant6p,NSLayoutAttribute attribute) {
        return weakSelf.layout_centerYToItemAttribute(toItem, DDAdapter6PHeight(constant6p), attribute);;
    };
}

/*****   superview   *****/
/** centerY 相对于 superview centerY的 偏移量constant6p */
- (UIView *(^)(CGFloat))layout_centerY6p
{
    __weak typeof(self) weakSelf = self;
    return ^ (CGFloat constant6p) {
        return weakSelf.layout_centerY6pToItemAttribute(weakSelf.superview, constant6p, NSLayoutAttributeCenterY);
    };
}

/*****   centerY   *****/
/** centerY 相对于 toItem centerY的 偏移量constant6p */
- (UIView *(^)(id,CGFloat))layout_centerY6pToItemCenterY
{
    __weak typeof(self) weakSelf = self;
    return ^ (id toItem,CGFloat constant6p) {
        return weakSelf.layout_centerY6pToItemAttribute(toItem, constant6p, NSLayoutAttributeCenterY);
    };
}

/*****   top   *****/
/** centerY 相对于 toItem top的 偏移量constant6p */
- (UIView *(^)(id,CGFloat))layout_centerY6pToItemTop
{
    __weak typeof(self) weakSelf = self;
    return ^ (id toItem,CGFloat constant6p) {
        return weakSelf.layout_centerY6pToItemAttribute(toItem, constant6p, NSLayoutAttributeTop);
    };
}

/*****   bottom   *****/
/** centerY 相对于 toItem bottom的 偏移量constant6p */
- (UIView *(^)(id,CGFloat))layout_centerY6pToItemBottom
{
    __weak typeof(self) weakSelf = self;
    return ^ (id toItem,CGFloat constant6p) {
        return weakSelf.layout_centerY6pToItemAttribute(toItem, constant6p, NSLayoutAttributeBottom);
    };
}

#pragma mark - 适配6p center
/** center 相对于 toItem center的 偏移量point6p */
- (UIView *(^)(id, CGPoint))layout_center6pToItemCenter
{
    __weak typeof(self) weakSelf = self;
    return ^ (id toItem,CGPoint point6p) {
        return weakSelf.layout_centerToItemCenter(toItem, CGPointMake(DDAdapter6PWidth(point6p.x), DDAdapter6PHeight(point6p.y)));
    };
}

/** center 相对于 superview center的 偏移量 x6p y6p  */
- (UIView *(^)(CGFloat, CGFloat))layout_center6p
{
    __weak typeof(self) weakSelf = self;
    return ^ (CGFloat x6p, CGFloat y6p) {
        return weakSelf.layout_center(DDAdapter6PWidth(x6p), DDAdapter6PHeight(y6p));
    };
}

#pragma mark - 适配6p top
/** top 相对于 toItem attribute 的 偏移量constant6p */
- (UIView *(^)(id, CGFloat, NSLayoutAttribute))layout_top6pToItemAttribute
{
    __weak typeof(self) weakSelf = self;
    return ^ (id toItem,CGFloat constant6p,NSLayoutAttribute attribute) {
        return weakSelf.layout_topToItemAttribute(toItem, DDAdapter6PHeight(constant6p), attribute);
    };
}


/*****   superview   *****/
/** top 相对于 superview top的 偏移量constant6p */
- (UIView *(^)(CGFloat))layout_top6p
{
    __weak typeof(self) weakSelf = self;
    return ^ (CGFloat constant6p) {
        return weakSelf.layout_top6pToItemAttribute(weakSelf.superview, constant6p, NSLayoutAttributeTop);
    };
}

/*****   top   *****/
/** top 相对于 toItem top的 偏移量constant6p */
- (UIView *(^)(id,CGFloat))layout_top6pToItemTop
{
    __weak typeof(self) weakSelf = self;
    return ^ (id toItem,CGFloat constant6p) {
        return weakSelf.layout_top6pToItemAttribute(toItem, constant6p, NSLayoutAttributeTop);
    };
}

/*****   centerY   *****/
/** top 相对于 toItem centerY的 偏移量constant6p */
- (UIView *(^)(id,CGFloat))layout_top6pToItemCenterY
{
    __weak typeof(self) weakSelf = self;
    return ^ (id toItem,CGFloat constant6p) {
        return weakSelf.layout_top6pToItemAttribute(toItem, constant6p, NSLayoutAttributeCenterY);
    };
}

/*****   bottom   *****/
/** top 相对于 toItem bottom的 偏移量constant6p */
- (UIView *(^)(id,CGFloat))layout_top6pToItemBottom
{
    __weak typeof(self) weakSelf = self;
    return ^ (id toItem,CGFloat constant6p) {
        return weakSelf.layout_top6pToItemAttribute(toItem, constant6p, NSLayoutAttributeBottom);
    };
}

#pragma mark - 适配6p left
/** left 相对于 toItem attribute 的 偏移量constant6p */
- (UIView *(^)(id, CGFloat, NSLayoutAttribute))layout_left6pToItemAttribute
{
    __weak typeof(self) weakSelf = self;
    return ^ (id toItem,CGFloat constant6p,NSLayoutAttribute attribute) {
        return weakSelf.layout_leftToItemAttribute(toItem, DDAdapter6PWidth(constant6p), attribute);;
    };
}

/*****   superview   *****/
/** left 相对于 superview left的 偏移量constant6p */
- (UIView *(^)(CGFloat))layout_left6p
{
    __weak typeof(self) weakSelf = self;
    return ^ (CGFloat constant6p) {
        return weakSelf.layout_left6pToItemAttribute(weakSelf.superview, constant6p, NSLayoutAttributeLeft);
    };
}

/*****   left   *****/
/** left 相对于 toItem left的 偏移量constant6p */
- (UIView *(^)(id, CGFloat))layout_left6pToItemLeft
{
    __weak typeof(self) weakSelf = self;
    return ^ (id toItem,CGFloat constant6p) {
        return weakSelf.layout_left6pToItemAttribute(toItem, constant6p, NSLayoutAttributeLeft);
    };
}

/*****   centerX   *****/
/** left 相对于 toItem centerX的 偏移量constant6p */
- (UIView *(^)(id, CGFloat))layout_left6pToItemCenterX
{
    __weak typeof(self) weakSelf = self;
    return ^ (id toItem,CGFloat constant6p) {
        return weakSelf.layout_left6pToItemAttribute(toItem, constant6p, NSLayoutAttributeCenterX);
    };
}

/*****   right   *****/
/** left 相对于 toItem right的 偏移量constant6p */
- (UIView *(^)(id, CGFloat))layout_left6pToItemRight
{
    __weak typeof(self) weakSelf = self;
    return ^ (id toItem,CGFloat constant6p) {
        return weakSelf.layout_left6pToItemAttribute(toItem, constant6p, NSLayoutAttributeRight);
    };
}

#pragma mark - 适配6p bottom
/** bottom 相对于 toItem attribute 的 偏移量constant6p */
- (UIView *(^)(id, CGFloat, NSLayoutAttribute))layout_bottom6pToItemAttribute
{
    __weak typeof(self) weakSelf = self;
    return ^ (id toItem,CGFloat constant6p,NSLayoutAttribute attribute) {
        return weakSelf.layout_bottomToItemAttribute(toItem, DDAdapter6PHeight(constant6p), attribute);
    };
}

/*****   superview   *****/
/** bottom 相对于 superview bottom的 偏移量constant6p */
- (UIView *(^)(CGFloat))layout_bottom6p
{
    __weak typeof(self) weakSelf = self;
    return ^ (CGFloat constant6p) {
        return weakSelf.layout_bottom6pToItemAttribute(weakSelf.superview, constant6p, NSLayoutAttributeBottom);
    };
}

/*****   bottom   *****/
/** bottom 相对于 toItem bottom的 偏移量constant6p */
- (UIView *(^)(id,CGFloat))layout_bottom6pToItemBottom
{
    __weak typeof(self) weakSelf = self;
    return ^ (id toItem,CGFloat constant6p) {
        return weakSelf.layout_bottom6pToItemAttribute(toItem, constant6p, NSLayoutAttributeBottom);
    };
}

/*****   top   *****/
/** bottom 相对于 toItem top的 偏移量constant6p */
- (UIView *(^)(id,CGFloat))layout_bottom6pToItemTop
{
    __weak typeof(self) weakSelf = self;
    return ^ (id toItem,CGFloat constant6p) {
        return weakSelf.layout_bottom6pToItemAttribute(toItem, constant6p, NSLayoutAttributeTop);
    };
}

/*****   centerY   *****/
/** bottom 相对于 toItem centerY的 偏移量constant6p */
- (UIView *(^)(id,CGFloat))layout_bottom6pToItemCenterY
{
    __weak typeof(self) weakSelf = self;
    return ^ (id toItem,CGFloat constant6p) {
        return weakSelf.layout_bottom6pToItemAttribute(toItem, constant6p, NSLayoutAttributeCenterY);
    };
}

#pragma mark - 适配6p right
/** right 相对于 toItem attribute 的 偏移量constant6p */
- (UIView *(^)(id, CGFloat, NSLayoutAttribute))layout_right6pToItemAttribute
{
    __weak typeof(self) weakSelf = self;
    return ^ (id toItem,CGFloat constant6p,NSLayoutAttribute attribute) {
        return weakSelf.layout_rightToItemAttribute(toItem, DDAdapter6PWidth(constant6p), attribute);
    };
}

/*****   superview   *****/
/** right 相对于 superview right的 偏移量constant6p */
- (UIView *(^)(CGFloat))layout_right6p
{
    __weak typeof(self) weakSelf = self;
    return ^ (CGFloat constant6p) {
        return weakSelf.layout_right6pToItemAttribute(weakSelf.superview, constant6p, NSLayoutAttributeRight);
    };
}

/*****   right   *****/
/** right 相对于 toItem right的 偏移量constant6p */
- (UIView *(^)(id,CGFloat))layout_right6pToItemRight
{
    __weak typeof(self) weakSelf = self;
    return ^ (id toItem,CGFloat constant6p) {
        return weakSelf.layout_right6pToItemAttribute(toItem, constant6p, NSLayoutAttributeRight);
    };
}

/*****   left   *****/
/** right 相对于 toItem left的 偏移量constant6p */
- (UIView *(^)(id,CGFloat))layout_right6pToItemLeft
{
    __weak typeof(self) weakSelf = self;
    return ^ (id toItem,CGFloat constant6p) {
        return weakSelf.layout_right6pToItemAttribute(toItem, constant6p, NSLayoutAttributeLeft);
    };
}

/*****   centerX   *****/
/** right 相对于 toItem centerX的 偏移量constant6p */
- (UIView *(^)(id,CGFloat))layout_right6pToItemCenterX
{
    __weak typeof(self) weakSelf = self;
    return ^ (id toItem,CGFloat constant6p) {
        return weakSelf.layout_right6pToItemAttribute(toItem, constant6p, NSLayoutAttributeCenterX);
    };
}

@end
















