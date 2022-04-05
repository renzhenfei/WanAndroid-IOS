//
//  NSString+StringUtils.m
//  WanIOS
//
//  Created by zhenfei ren on 2022/3/26.
//

#import "NSString+StringUtils.h"

@implementation NSString (StringUtils)

- (BOOL) isEmpty{
    return [[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] == 0;
}

@end
