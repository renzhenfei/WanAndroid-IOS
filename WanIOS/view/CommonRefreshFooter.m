//
//  CommonRefreshFooter.m
//  WanIOS
//
//  Created by zhenfei ren on 2022/4/4.
//

#import "CommonRefreshFooter.h"

@implementation CommonRefreshFooter

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)prepare{
    [super prepare];
    [self setTitle:@"上拉加载更多" forState:MJRefreshStateIdle];
    [self setTitle:@"松开加载哦～" forState:MJRefreshStatePulling];
    [self setTitle:@"正在加载中..." forState:MJRefreshStateRefreshing];
}

@end
