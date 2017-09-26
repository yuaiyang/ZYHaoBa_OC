//
//  ZYHttpsTool.h
//  AllTheWealth
//
//  Created by ylcf on 16/8/24.
//  Copyright © 2016年 正羽. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZYHttpsTool : NSObject

+ (void) POST:(NSString *)URLString
   parameters:(id)parameters
      success:(void (^)(id responseObject))success
      failure:(void (^)(NSError *error))failure;

+ (void) GET:(NSString *)URLString
  parameters:(id)parameters
     success:(void (^)(id responseObject))success
     failure:(void (^)(NSError *error))failure;
@end
