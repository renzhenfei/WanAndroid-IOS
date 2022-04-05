//
//  NavItemModel.m
//  WanIOS
//
//  Created by zhenfei ren on 2022/3/29.
//

#import "NavItemModel.h"

@implementation NavItemModel

+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{
        @"id_":@"id"
    };
}

@end
