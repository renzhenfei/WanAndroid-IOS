//
//  TapGestureWithArgs.h
//  WanIOS
//
//  Created by zhenfei ren on 2022/3/31.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TapGestureWithArgs : UITapGestureRecognizer

@property(nonatomic,assign) int arg1;

@property(nonatomic,assign) int arg2;

@end

NS_ASSUME_NONNULL_END
