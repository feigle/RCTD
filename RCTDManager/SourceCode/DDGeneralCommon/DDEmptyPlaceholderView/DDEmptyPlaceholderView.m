//
//  DDEmptyPlaceholderView.m
//  DoorDuOEM
//
//  Created by 刘和东 on 2018/4/14.
//  Copyright © 2018年 深圳市多度科技有限公司. All rights reserved.
//

#import "DDEmptyPlaceholderView.h"

@interface DDEmptyPlaceholderView ()

@property (nonatomic, strong) DDButton * button;

@end

@implementation DDEmptyPlaceholderView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self _configUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self _configUI];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.button.frame = self.bounds;
}

- (void)_configUI
{
    self.imageTextSpace = 15;
    
    self.placeholderColor = [UIColor colorWithRed:191/255.0 green:191/255.0 blue:191/255.0 alpha:1/1.0];
    
    self.backgroundColor = [UIColor colorWithRed:251/255.0 green:250/255.0 blue:248/255.0 alpha:1/1.0];
    
    [self addSubview:self.button];
    
    self.button.space = self.imageTextSpace;
    
}

- (void)setImageName:(NSString *)imageName
{
    _imageName = imageName;
    [self.button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [self.button layoutIfNeeded];
}

- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = placeholder;
    [self.button setTitle:placeholder forState:UIControlStateNormal];
    [self.button layoutIfNeeded];
}

- (void)setImageTextSpace:(CGFloat)imageTextSpace
{
    _imageTextSpace = imageTextSpace;
    self.button.space = imageTextSpace;
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor;
    [self.button setTitleColor:placeholderColor forState:UIControlStateNormal];
    [self.button layoutIfNeeded];
}

- (void)setPlaceholderFont:(UIFont *)placeholderFont
{
    _placeholderFont = placeholderFont;
    self.button.titleLabel.font = placeholderFont;
    [self.button layoutIfNeeded];
}

- (DDButton *)button
{
    if (!_button) {
        _button = [DDButton buttonWithType:UIButtonTypeCustom];
        _button.styleType = DDButtonStyleImageViewTopType;
        _button.titleLabel.font = [UIFont systemFontOfSize:36/2.0];
        [_button setImage:[UIImage imageNamed:@"DDEmptyPlaceholderBigEmptyImage"] forState:UIControlStateNormal];
    }
    return _button;
}

+ (DDEmptyPlaceholderView *)placeholder:(NSString *)placeholder
          imageName:(NSString *)imageName
     imageTextSpace:(CGFloat)imageTextSpace
   placeholderColor:(UIColor *)placeholderColor
    placeholderFont:(UIFont *)placeholderFont
          superView:(UIView *)superView
       clickedBlock:(void (^)(void))clickedBlock
{
    if (!superView) {
        return nil;
    }
    [DDEmptyPlaceholderView removeSelfSuperView:superView];
    
    DDEmptyPlaceholderView * view = [[DDEmptyPlaceholderView alloc] init];
    
    if (placeholder)        view.placeholder = placeholder;
    if (imageName)          view.imageName = imageName;
    if (imageTextSpace)     view.imageTextSpace = imageTextSpace;
    if (placeholderColor)   view.placeholderColor = placeholderColor;
    if (placeholderFont)    view.placeholderFont = placeholderFont;
    
    view.frame = superView.bounds;
    view.clickedBlock = clickedBlock;
    
    [superView addSubview:view];
    
    return view;
}

+ (DDEmptyPlaceholderView *)placeholder:(NSString *)placeholder
          imageName:(NSString *)imageName
          superView:(UIView *)superView
       clickedBlock:(void (^)(void))clickedBlock
{
    return [self placeholder:placeholder imageName:imageName imageTextSpace:0 placeholderColor:nil placeholderFont:nil superView:superView clickedBlock:clickedBlock];
}

/** 默认展示大页面的空白页面 */
+ (DDEmptyPlaceholderView *)showBigPlaceholder:(NSString*)placeholder
                 superView:(UIView *)superView
              clickedBlock:(void (^)(void))clickedBlock
{
    return [self placeholder:placeholder imageName:nil imageTextSpace:68/2.0 placeholderColor: [UIColor colorWithRed:116/255.0 green:116/255.0 blue:116/255.0 alpha:1/1.0] placeholderFont:nil superView:superView clickedBlock:clickedBlock];
}

/** 默认展示小页面的空白页面 */
+ (DDEmptyPlaceholderView *)showSmallPlaceholder:(NSString*)placeholder
                   superView:(UIView *)superView
                clickedBlock:(void (^)(void))clickedBlock
{
    return [self placeholder:placeholder imageName:@"DDEmptyPlaceholderSmallEmptyImage" imageTextSpace:0 placeholderColor:  [UIColor colorWithRed:191/255.0 green:191/255.0 blue:191/255.0 alpha:1/1.0] placeholderFont:[UIFont systemFontOfSize:34/2.0] superView:superView clickedBlock:clickedBlock];
}

/** 移除self view */
+ (void)removeSelfSuperView:(UIView *)superView
{
    if (!superView || ![superView respondsToSelector:@selector(subviews)]) {
        return;
    }
    for (UIView * view in superView.subviews) {
        if ([view isKindOfClass:DDEmptyPlaceholderView.class]) {
            [view removeFromSuperview];
        }
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
