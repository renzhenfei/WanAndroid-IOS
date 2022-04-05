//
//  AskAnswerCell.h
//  WanIOS
//
//  Created by zhenfei ren on 2022/3/29.
//

#import <UIKit/UIKit.h>
#import "AskAnswerItemModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface AskAnswerCell : UITableViewCell

- (void)setData:(AskAnswerItemModel *)model;

@end

NS_ASSUME_NONNULL_END
