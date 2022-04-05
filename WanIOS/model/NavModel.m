//
//  NavModel.m
//  WanIOS
//
//  Created by zhenfei ren on 2022/3/29.
//

#import "NavModel.h"

@implementation NavModel

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{
        @"articles":[NavItemModel class]
    };
}

@end
