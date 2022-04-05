//
//  TiXiModel.h
//  WanIOS
//
//  Created by zhenfei ren on 2022/3/27.
//

#import <Foundation/Foundation.h>

#import "TiXiItemModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TiXiModel : NSObject<YYModel>

@property(nonatomic,copy) NSString* author;

@property(nonatomic,assign) int courseId;

@property(nonatomic,copy) NSString* name;

@property(nonatomic,strong) NSArray<TiXiItemModel*>* children;

@end

NS_ASSUME_NONNULL_END
