//
//  NavModel.h
//  WanIOS
//
//  Created by zhenfei ren on 2022/3/29.
//

#import <Foundation/Foundation.h>
#import "NavItemModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface NavModel : NSObject<YYModel>

@property(nonatomic,assign) int cid;

@property(nonatomic,copy) NSString* name;

@property(nonatomic,strong) NSArray<NavItemModel*>* articles;

@end

NS_ASSUME_NONNULL_END
