//
//  TiXiModel.m
//  WanIOS
//
//  Created by zhenfei ren on 2022/3/27.
//

#import "TiXiModel.h"

@implementation TiXiModel

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{
        @"children":[TiXiItemModel class]
    };
}

@end
