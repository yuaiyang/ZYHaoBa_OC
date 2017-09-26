//
//  AORequest.m
//  allinone
//
//  Created by Johnil on 16/2/27.
//  Copyright © 2016年 Johnil. All rights reserved.
//

#import "AORequest.h"

@implementation AORequest

+ (void)requestApi:(NSString *)api parames:(NSDictionary *)params success:(void (^)(id))success failed:(void (^)(id))failed{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (success) {
            success(@{@"data": api});
        }
    });

}

@end
