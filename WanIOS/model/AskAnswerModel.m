//
//  AskAnswerModel.m
//  WanIOS
//
//  Created by zhenfei ren on 2022/3/29.
//

#import "AskAnswerModel.h"

@implementation AskAnswerModel

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{
        @"datas":[AskAnswerItemModel class]
    };
}

@end
