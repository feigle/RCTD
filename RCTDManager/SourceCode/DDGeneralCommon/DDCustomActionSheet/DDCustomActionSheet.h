//
//  DDCustomActionSheet.h
//  DoorDuOEM
//
//  Created by 刘和东 on 2018/4/7.
//  Copyright © 2018年 深圳市多度科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DDCustomActionSheet : UIView

/**单行高度，默认 50*/
@property (nonatomic,assign) CGFloat lineHeight;

/**取消按钮 和 内容 view之间的间隙，默认 5*/
@property (nonatomic,assign) CGFloat cancelButtonContentViewSpace;

/**内容view的背景,默认白色*/
@property (nonatomic,strong) UIColor * contentViewBackgroundColor;

#pragma mark - 标题头

/** 弹出框标题，如果没有或者空字符串则不显示  */
@property (nonatomic, strong) NSString * titleString;
/** 弹出框标题颜色，有默认值  */
@property (nonatomic, strong) UIColor * titleColor;
/** 弹出框标题Font，有默认值  */
@property (nonatomic, strong) UIFont * titleFont;

#pragma mark - 取消按钮

/** 取消按钮文字，如果没有或者空字符串则不显示，默认是取消 */
@property (nonatomic, strong) NSString * cancelString;
/** 取消按钮文字颜色，有默认值  */
@property (nonatomic, strong) UIColor * cancelColor;
/** 取消按钮文字Font，有默认值  */
@property (nonatomic, strong) UIFont * cancelFont;

#pragma mark - 正文标题

/** 其他标题 */
@property (nonatomic, strong) NSArray * otherTitleArray;
/** 其他标题 文字颜色(可以是数组，也可以单个 UIColor) */
@property (nonatomic, strong) id otherTitleColor;
/** 其他标题文字Font，有默认值  */
@property (nonatomic, strong) UIFont * otherTitleFont;
/** 其他标题背景颜色颜色，有默认值  */
@property (nonatomic, strong) UIColor * otherTitleBackgroundColor;

#pragma mark - 正文图片数组
/** 图片数组，如果中间哪个没有图片，以@""，空字符串 */
@property (nonatomic, strong) NSArray * otherImageNameArray;



/** 最后弹出 */
- (void)showFromView:(UIView *)fromView selectedBlock:(void (^)(NSInteger row,NSString * title))selectedBlock;

/**隐藏消失,外部可以不调用*/
- (void)dismiss:(void (^)(BOOL finished))completion;

+ (void)showWithView:(UIView *)fromView
               title:(NSString *)title
              cancel:(NSString *)cancel
    otherButtonTitles:(NSArray *)otherButtonTitles
 otherImageNameArray:(NSArray *)otherImageNameArray
        clickedBlock:(void (^)(NSInteger index,NSString * title))clickedBlock;

+ (void)showWithView:(UIView *)fromView
               title:(NSString *)title
              cancel:(NSString *)cancel
    otherButtonTitles:(NSArray *)otherButtonTitles
        clickedBlock:(void (^)(NSInteger index,NSString * title))clickedBlock;

/** 默认 没有title */
+ (void)showWithView:(UIView *)fromView
              cancel:(NSString *)cancel
   otherButtonTitles:(NSArray *)otherButtonTitles
        clickedBlock:(void (^)(NSInteger index,NSString * title))clickedBlock;

/** 默认 没有title，取消按钮文字为：取消 */
+ (void)showWithView:(UIView *)fromView
   otherButtonTitles:(NSArray *)otherButtonTitles
        clickedBlock:(void (^)(NSInteger index,NSString * title))clickedBlock;

@end
