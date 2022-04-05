//
//  ApiUtil.m
//  WanIOS
//
//  Created by zhenfei ren on 2022/3/24.
//

#import "ApiUtil.h"
#import <AFNetworking.h>

@implementation ApiUtil

+ (void)handleData:(NSDictionary *)data succBlock:(SuccesssCallback) succBlock faildBlock:(FaildCallback)faildBlock{
    int code = [data[@"errorCode"] intValue];
    NSString *msg = [data objectForKey:@"errorMsg"];
    if (code == 0 || code == 200) {
        succBlock(data[@"data"]);
    }else{
        if (faildBlock) {
            faildBlock(code,msg);
        }
    }
}

+ (void)request:(NSString *)url succBlock:(SuccesssCallback) succBlock faildBlock:(FaildCallback)faildBlock{
    [self request:url andMethod:GET succBlock:succBlock faildBlock:faildBlock];
}

+ (void)request:(NSString *)url andMethod:(RequestMethod)method succBlock:(SuccesssCallback) succBlock faildBlock:(FaildCallback)faildBlock{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSString *requestUrl = [NSString stringWithFormat:@"%@%@",BASE_URL,url];
    if (method == GET) {
        [manager GET:requestUrl parameters:nil headers:nil progress:^(NSProgress * _Nonnull downloadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [self handleData:responseObject succBlock:succBlock faildBlock:faildBlock];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (faildBlock) {
                    faildBlock(task.error.code,task.error.description);
                }
            }];
    }else if(method == POST){
        [manager POST:url parameters:nil headers:nil progress:^(NSProgress * _Nonnull uploadProgress) {
                    
                } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    [self handleData:responseObject succBlock:succBlock faildBlock:faildBlock];
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    if (faildBlock) {
                        faildBlock(task.error.code,task.error.description);
                    }
                }];
    }
    
}

@end
