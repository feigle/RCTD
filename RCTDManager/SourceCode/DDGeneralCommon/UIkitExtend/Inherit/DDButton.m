//
//  DDButton.m
//  DoorDuOEM
//
//  Created by 刘和东 on 2018/3/28.
//  Copyright © 2018年 刘和东. All rights reserved.
//

#import "DDButton.h"

@implementation DDButton

- (void)layoutSubviews
{
    [super layoutSubviews];
    //{top, left, bottom, right}
    switch (self.styleType) {
        case DDButtonStyleImageViewTopType:
        {//{top, left, bottom, right}
            self.imageEdgeInsets = UIEdgeInsetsMake(-self.titleLabel.intrinsicContentSize.height-ceil(self.space/2.0), 0, 0, -self.titleLabel.intrinsicContentSize.width);
            
            self.titleEdgeInsets = UIEdgeInsetsMake(self.currentImage.size.height+ceil(self.space/2.0), -self.currentImage.size.width, 0, 0);
            
//            self.contentEdgeInsets = UIEdgeInsetsMake(-ceil(self.space/2.0), 0, -ceil(self.space/4.0), 0);
        }
            break;
        case DDButtonStyleImageViewBottomType:
        {//{top, left, bottom, right}
            self.titleEdgeInsets = UIEdgeInsetsMake(-self.currentImage.size.height-ceil(self.space/2.0), -self.currentImage.size.width, 0, 0);
            self.imageEdgeInsets = UIEdgeInsetsMake(self.titleLabel.intrinsicContentSize.height+ceil(self.space/2.0), 0, 0, -self.titleLabel.intrinsicContentSize.width);
//            self.contentEdgeInsets = UIEdgeInsetsMake(ceil(self.space/2.0), 0, ceil(self.space/2.0), 0);
        }
            break;
        case DDButtonStyleImageViewLeftType://完
        {//{top, left, bottom, right}
//            self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
            self.imageEdgeInsets = UIEdgeInsetsMake(0, -ceil(self.space/2.0), 0, ceil(self.space/2.0));
            self.titleEdgeInsets = UIEdgeInsetsMake(0, ceil(self.space/2.0), 0, -ceil(self.space/2.0));
            self.contentEdgeInsets = UIEdgeInsetsMake(0, 2, 0, 0);
        }
            break;
        case DDButtonStyleImageViewRightType:
        {//{top, left, bottom, right} self.titleLabel.intrinsicContentSize.width
//            self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
            self.imageEdgeInsets = UIEdgeInsetsMake(0, self.titleLabel.intrinsicContentSize.width+ceil(self.space/4.0), 0, -self.titleLabel.intrinsicContentSize.width-ceil(self.space/4.0));
            self.titleEdgeInsets = UIEdgeInsetsMake(0, -self.currentImage.size.width-ceil(self.space/4.0), 0, ceil(self.currentImage.size.width+self.space/4.0));
            self.contentEdgeInsets = UIEdgeInsetsMake(0, 2, 0, 2);
        }
            break;

        default:
            break;
    }
    
    
}

- (void)setStyleType:(DDButtonStyleType)styleType
{
    _styleType = styleType;
    [self setNeedsLayout];
}

- (void)setImage:(UIImage *)image forState:(UIControlState)state {
    [super setImage:image forState:state];
    [self setNeedsLayout];
}
- (void)setTitle:(NSString *)title forState:(UIControlState)state {
    [super setTitle:title forState:state];
    [self setNeedsLayout];
}
- (void)setSpace:(CGFloat)space
{
    _space = space;
    [self setNeedsLayout];
}

- (void)sizeToFit
{
    [super sizeToFit];
    [self setNeedsLayout];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
