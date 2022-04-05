//
//  UILableWithPadding.m
//  WanIOS
//
//  Created by zhenfei ren on 2022/3/29.
//

#import "UILableWithPadding.h"

@interface UILableWithPadding ()

@property(nonatomic, assign) UIEdgeInsets edgeInsets;

@end

@implementation UILableWithPadding

- (instancetype)initWithInsets:(UIEdgeInsets)edgeInsets
{
    self = [super init];
    if (self) {
        self.edgeInsets = edgeInsets;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.edgeInsets = UIEdgeInsetsMake(2, 2, 2, 2);
    }
    return self;
}

- (void)drawTextInRect:(CGRect)rect{
    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, self.edgeInsets)];
}

- (CGRect)textRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines{
    CGRect rect = [super textRectForBounds:bounds limitedToNumberOfLines:numberOfLines];
    rect.origin.x -= self.edgeInsets.left;
    rect.origin.y -= self.edgeInsets.top;
    rect.size.width += self.edgeInsets.left + self.edgeInsets.right;
    rect.size.height += self.edgeInsets.top + self.edgeInsets.bottom;
    return rect;
}


@end
