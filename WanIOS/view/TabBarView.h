//
//  TabBarView.h
//  WanIOS
//
//  Created by zhenfei ren on 2022/4/1.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol OnTagListener <NSObject>

@required
- (void)onTagSelected:(NSInteger)index;

@end

@interface TabBarView : UIScrollView

@property(nonatomic,strong) id<OnTagListener> listener;

- (void)tags:(NSArray *)tags;

- (void)tags:(NSArray *)tags index:(NSInteger)index;

- (void)scoll2Index:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
