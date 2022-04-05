//
//  UITableViewEndRefresh.m
//  WanIOS
//
//  Created by zhenfei ren on 2022/4/4.
//

#import "UITableViewEndRefresh.h"

@implementation UITableViewEndRefresh

- (void)reloadData{
    [super reloadData];
    [self.mj_header endRefreshing];
    [self.mj_footer endRefreshing];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
