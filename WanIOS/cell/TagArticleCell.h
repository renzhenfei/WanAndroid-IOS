//
//  TagArticleCell.h
//  WanIOS
//
//  Created by zhenfei ren on 2022/3/31.
//

#import <UIKit/UIKit.h>
#import "AskAnswerItemModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface TagArticleCell : UITableViewCell

- (void)setData:(AskAnswerItemModel *)article;

@end

NS_ASSUME_NONNULL_END
