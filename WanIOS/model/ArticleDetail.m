//
//  ArticleDetail.m
//  WanIOS
//
//  Created by zhenfei ren on 2022/3/26.
//

#import "ArticleDetail.h"

@implementation ArticleDetail

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.isTop = false;
    }
    return self;
}

+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{
        @"id_":@"id"
    };
}

@end
