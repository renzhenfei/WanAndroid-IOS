//
//  TabBarView.m
//  WanIOS
//
//  Created by zhenfei ren on 2022/4/1.
//

#import "TabBarView.h"
#define MARGIN 15
#define INDICATOR_HEIGHT 4
#define DEFAULT_COLOR RGB_COLOR(@"#007aff", 1)

@interface TabBarView ()

@property(nonatomic,strong) UIView *indicatorView;

@property(nonatomic,assign) NSInteger index;

@end

@implementation TabBarView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.showsVerticalScrollIndicator = false;
        self.showsHorizontalScrollIndicator = false;
    }
    return self;
}

- (void)tags:(NSArray *)tags index:(NSInteger)index{
    self.index = index;
    [self tags:tags];
}

- (void)update:(NSInteger)index{
    self.index = index;
    UIView *view = self.subviews[index];
    int value = view.frame.origin.x - self.frame.size.width / 2 + view.frame.size.width / 2;
    int offset = MAX(0, MIN(MAX(0, value), self.contentSize.width - self.frame.size.width));
    [UIView animateWithDuration:0.3 animations:^{
        self.indicatorView.frame = CGRectMake(view.frame.origin.x, self.indicatorView.frame.origin.y, view.frame.size.width, self.indicatorView.frame.size.height);
        self.contentOffset = CGPointMake(offset, 0);
    }];
    for (UIView *subView in self.subviews) {
        if ([subView isKindOfClass:[UILabel class]]) {
            UILabel *tagLable = (UILabel *)subView;
            tagLable.textColor = UIColor.blackColor;
        }
    }
    UILabel *selectedTagView = (UILabel *)view;
    selectedTagView.textColor = DEFAULT_COLOR;
    if (self.listener) {
        [self.listener onTagSelected:index];
    }
}

- (void)onTagClick:(UIGestureRecognizer *)gesture{
    NSInteger index = [self.subviews indexOfObject:gesture.view];
    [self update:index];
}

- (void)tags:(NSArray *)tags{
    UILabel *tmp = [[UILabel alloc] init];
    int left = MARGIN;
    CGSize size;
    for (int i = 0; i < tags.count; i++) {
        size = [tags[i] sizeWithAttributes:@{NSFontAttributeName:tmp.font}];
        UILabel *tag = [[UILabel alloc] initWithFrame:CGRectMake(left, 0, size.width, size.height)];
        tag.textColor = i == 0 ? DEFAULT_COLOR : UIColor.blackColor;
        [tag addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTagClick:)]];
        tag.text = tags[i];
        tag.userInteractionEnabled = YES;
        [self addSubview:tag];
        left += size.width + MARGIN;
    }
    CGRect rect = self.subviews[0].frame;
    self.indicatorView = [[UIView alloc] initWithFrame:CGRectMake(rect.origin.x, self.frame.size.height - INDICATOR_HEIGHT, rect.size.width, INDICATOR_HEIGHT)];
    self.indicatorView.layer.cornerRadius = 3;
    self.indicatorView.clipsToBounds = YES;
    self.indicatorView.backgroundColor = DEFAULT_COLOR;
    [self addSubview:self.indicatorView];
    self.contentSize = CGSizeMake(left, 0);
    
    [self update:self.index];
}

- (void)scoll2Index:(NSInteger)index{
    [self update:index];
}

@end
