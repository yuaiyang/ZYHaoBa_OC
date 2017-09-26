//
//  AORequest.h
//  allinone
//
//  Created by Johnil on 16/2/27.
//  Copyright © 2016年 Johnil. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AORequest : NSObject

+ (void)requestApi:(NSString *)api
           parames:(NSDictionary *)params
           success:(void(^)(id responseObject))success
           failed:(void(^)(id responseObject))failed;


@end
