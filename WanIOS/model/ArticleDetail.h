//
//  ArticleDetail.h
//  WanIOS
//
//  Created by zhenfei ren on 2022/3/26.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ArticleDetail : NSObject<YYModel>

@property(nonatomic,copy) NSString* link;

@property(nonatomic,copy) NSString* title;

@property(nonatomic,copy) NSString* niceDate;

@property(nonatomic,copy) NSString* shareUser;

@property(nonatomic,copy) NSString* superChapterName;

@property(nonatomic,copy) NSString* chapterName;

@property(nonatomic,copy) NSString* author;

@property(nonatomic,assign) int curPage;

@property(nonatomic,assign) int id_;

@property(nonatomic,assign) int zan;

@property(nonatomic,assign) int userId;

@property(nonatomic,assign) BOOL collect;

@property(nonatomic,assign) BOOL fresh;

@property(nonatomic,assign) BOOL isTop;

@end

NS_ASSUME_NONNULL_END
