//
//  AskAnswerItemModel.h
//  WanIOS
//
//  Created by zhenfei ren on 2022/3/29.
//

#import <Foundation/Foundation.h>
#import "TagModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface AskAnswerItemModel : NSObject<YYModel>

@property(nonatomic, copy) NSString* author;

@property(nonatomic, copy) NSString* shareUser;

@property(nonatomic, copy) NSString* desc;

@property(nonatomic, copy) NSString* link;

@property(nonatomic, copy) NSString* niceDate;

@property(nonatomic, copy) NSString* chapterName;

@property(nonatomic, copy) NSString* superChapterName;

@property(nonatomic,strong) NSArray<TagModel*>* tags;

@property(nonatomic, copy) NSString* title;

@property(nonatomic,assign) int _id;

- (NSString* )allTag;

@end

NS_ASSUME_NONNULL_END
