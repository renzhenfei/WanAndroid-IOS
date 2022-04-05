//
//  TiXiItemModel.h
//  WanIOS
//
//  Created by zhenfei ren on 2022/3/27.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TiXiItemModel : NSObject<YYModel>

@property(nonatomic,copy) NSString* author;

@property(nonatomic,copy) NSString* name;

@property(nonatomic,assign) int id_;

@end

NS_ASSUME_NONNULL_END
