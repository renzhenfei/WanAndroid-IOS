//
//  AskAnswerModel.h
//  WanIOS
//
//  Created by zhenfei ren on 2022/3/29.
//

#import <Foundation/Foundation.h>
#import "AskAnswerItemModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface AskAnswerModel : NSObject<YYModel>

@property(nonatomic, assign) int curPage;

@property(nonatomic, assign) int offset;

@property(nonatomic, assign) int pageCount;

@property(nonatomic, assign) int size;

@property(nonatomic, assign) int total;

@property(nonatomic, assign) BOOL over;

@property(nonatomic, strong) NSMutableArray<AskAnswerItemModel*>* datas;

@end

NS_ASSUME_NONNULL_END
