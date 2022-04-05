//
//  TiXiItemModel.m
//  WanIOS
//
//  Created by zhenfei ren on 2022/3/27.
//

#import "TiXiItemModel.h"

@implementation TiXiItemModel

+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{
        @"id_":@"id"
    };
}

@end
