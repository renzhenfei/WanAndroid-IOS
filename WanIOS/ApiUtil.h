//
//  ApiUtil.h
//  WanIOS
//
//  Created by zhenfei ren on 2022/3/24.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^SuccesssCallback)(id info);
typedef void (^FaildCallback)(NSInteger code,NSString* msg);

typedef NS_ENUM(NSInteger,RequestMethod){
    GET = 0,
    POST = 1
};

@interface ApiUtil : NSObject

+ (void)request:(NSString *)url andMethod:(RequestMethod)method succBlock:(SuccesssCallback) succBlock faildBlock:(FaildCallback)faildBlock;

+ (void)request:(NSString *)url succBlock:(SuccesssCallback) succBlock faildBlock:(FaildCallback)faildBlock;
                                 
@end

NS_ASSUME_NONNULL_END
