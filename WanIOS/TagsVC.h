//
//  TagsVC.h
//  WanIOS
//
//  Created by zhenfei ren on 2022/3/30.
//

#import <UIKit/UIKit.h>

#import "TiXiModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TagsVC : BaseViewController

@property(nonatomic,strong) TiXiModel *tixiModel;

@property(nonatomic,assign) NSInteger currentIndex;

@end

NS_ASSUME_NONNULL_END
