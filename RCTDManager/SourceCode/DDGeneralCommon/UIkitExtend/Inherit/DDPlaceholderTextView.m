//
//  DDPlaceholderTextView.m
//  DoorDuOEM
//
//  Created by 刘和东 on 2018/4/2.
//  Copyright © 2018年 深圳市多度科技有限公司. All rights reserved.
//

#import "DDPlaceholderTextView.h"

@implementation DDPlaceholderTextView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self _setupConfig];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self _setupConfig];
    }
    return self;
}


- (void)_setupConfig
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(__didReceiveTextDidChangeNotification:)
                                                 name:UITextViewTextDidChangeNotification
                                               object:self];
    _placeholderTextColor = [UIColor lightGrayColor];
    self.userInteractionEnabled = YES;
    self.font = [UIFont systemFontOfSize:15.0f];
    self.textColor = [UIColor blackColor];
    self.backgroundColor = [UIColor whiteColor];
    self.textAlignment = NSTextAlignmentLeft;
}

#pragma mark - Notifications

- (void)__didReceiveTextDidChangeNotification:(NSNotification *)notification {
    [self setNeedsDisplay];
}

- (void)setPlaceholder:(NSString *)placeholder {
    if([placeholder isEqualToString:_placeholder]) {
        return;
    }
    _placeholder = placeholder;
    [self setNeedsDisplay];
}

- (void)setPlaceholderTextColor:(UIColor *)placeholderTextColor {
    if([placeholderTextColor isEqual:_placeholderTextColor]) {
        return;
    }
    _placeholderTextColor = placeholderTextColor;
    [self setNeedsDisplay];
}


- (void)setText:(NSString *)text {
    [super setText:text];
    [self setNeedsDisplay];
}

- (void)setAttributedText:(NSAttributedString *)attributedText {
    [super setAttributedText:attributedText];
    [self setNeedsDisplay];
}

- (void)setContentInset:(UIEdgeInsets)contentInset {
    [super setContentInset:contentInset];
    [self setNeedsDisplay];
}

- (void)setFont:(UIFont *)font {
    [super setFont:font];
    [self setNeedsDisplay];
}

- (void)setTextAlignment:(NSTextAlignment)textAlignment {
    [super setTextAlignment:textAlignment];
    [self setNeedsDisplay];
}


#pragma mark - Drawing
- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    if([self.text length] == 0 && self.placeholder) {
        CGRect placeHolderRect = CGRectMake(5.0f,
                                            5.0f,
                                            rect.size.width-10,
                                            rect.size.height-10);
        [self.placeholderTextColor set];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
        paragraphStyle.alignment = self.textAlignment;
        [self.placeholder drawInRect:placeHolderRect
                      withAttributes:@{ NSFontAttributeName : self.font,
                                        NSForegroundColorAttributeName : self.placeholderTextColor,
                                        NSParagraphStyleAttributeName : paragraphStyle }];
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidChangeNotification object:self];
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
