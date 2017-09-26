//
//  ZYHttpsTool.m
//  AllTheWealth
//
//  Created by ylcf on 16/8/24.
//  Copyright © 2016年 正羽. All rights reserved.
//

#import "ZYHttpsTool.h"
#import "AFNetworking.h"

@implementation ZYHttpsTool


+ (void) POST:(NSString *)URLString
   parameters:(id)parameters
      success:(void (^)(id responseObject))success
      failure:(void (^)(NSError *error))failure {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //请求序列化
    //    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    //回复序列化
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager POST:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        [manager.operationQueue cancelAllOperations];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
            showAlert(error.localizedDescription);
        }
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        [manager.operationQueue cancelAllOperations];
    }];
   
}

+ (void) GET:(NSString *)URLString
   parameters:(id)parameters
      success:(void (^)(id responseObject))success
      failure:(void (^)(NSError *error))failure {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //请求序列化
    //    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    //回复序列化
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
//        [manager.operationQueue cancelAllOperations];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
            showAlert(error.localizedDescription);
        }
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
//        [manager.operationQueue cancelAllOperations];
    }];
    
}


// block作为方法的使用总结
void test(){
    void (^block)() = ^{
    
    };
    
    int (^sum)(int,int) = ^(int a,int b){
        return a + b;
    };
}


@end
