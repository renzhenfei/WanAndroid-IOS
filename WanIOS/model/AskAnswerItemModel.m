//
//  AskAnswerItemModel.m
//  WanIOS
//
//  Created by zhenfei ren on 2022/3/29.
//

#import "AskAnswerItemModel.h"

@implementation AskAnswerItemModel

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{
        @"tags":[TagModel class]
    };
}

+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{
        @"id":@"id_"
    };
}

- (NSString* )allTag{
    NSMutableArray *tagArr = [[NSMutableArray alloc] init];
    for (TagModel* tag in self.tags) {
        [tagArr addObject:tag.name];
    }
    return [tagArr componentsJoinedByString:@"·"];
}

@end
