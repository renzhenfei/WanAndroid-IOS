//
//  HomeCell.h
//  WanIOS
//
//  Created by zhenfei ren on 2022/3/26.
//

#import <UIKit/UIKit.h>
#import "ArticleDetail.h"
NS_ASSUME_NONNULL_BEGIN

@interface HomeCell : UITableViewCell

- (void)setData:(ArticleDetail*)article;

@end

NS_ASSUME_NONNULL_END
