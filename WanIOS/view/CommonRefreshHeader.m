//
//  CommonRefreshHeader.m
//  WanIOS
//
//  Created by zhenfei ren on 2022/4/4.
//

#import "CommonRefreshHeader.h"

@implementation CommonRefreshHeader

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)prepare{
    [super prepare];
    self.lastUpdatedTimeLabel.hidden = YES;
//    self.stateLabel.hidden = YES;
    [self setTitle:@"下拉刷新" forState:MJRefreshStateIdle];
    [self setTitle:@"松开刷新哦～" forState:MJRefreshStatePulling];
    [self setTitle:@"正在刷新..." forState:MJRefreshStateRefreshing];
}

@end
