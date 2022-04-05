//
//  ArticleModel.m
//  WanIOS
//
//  Created by zhenfei ren on 2022/3/26.
//

#import "ArticleModel.h"

@implementation ArticleModel

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{
        @"datas":[ArticleDetail class]
    };
}

@end
