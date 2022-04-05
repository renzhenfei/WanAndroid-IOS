//
//  NavItemModel.h
//  WanIOS
//
//  Created by zhenfei ren on 2022/3/29.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NavItemModel : NSObject<YYModel>

@property(nonatomic,copy) NSString* chapterName;

@property(nonatomic,copy) NSString* link;

@property(nonatomic,copy) NSString* niceDate;

@property(nonatomic,copy) NSString* title;

@property(nonatomic,assign) int id_;

@end

NS_ASSUME_NONNULL_END
