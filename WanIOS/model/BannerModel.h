//
//  BannerModel.h
//  WanIOS
//
//  Created by zhenfei ren on 2022/3/25.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BannerModel : NSObject<YYModel>

@property(nonatomic,copy) NSString* desc;
@property(nonatomic,copy) NSString* imagePath;
@property(nonatomic,copy) NSString* title;
@property(nonatomic,copy) NSString* url;

@property(nonatomic,assign) int id_;
@property(nonatomic,assign) int isVisible;
@property(nonatomic,assign) int order;
@property(nonatomic,assign) int type;

@end

NS_ASSUME_NONNULL_END
