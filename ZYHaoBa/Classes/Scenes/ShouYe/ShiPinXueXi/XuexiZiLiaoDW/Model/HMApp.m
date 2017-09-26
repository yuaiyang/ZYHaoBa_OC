//
//  HMApp.m
//  04-自定义Operation
//
//  Created by apple on 14-6-24.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "HMApp.h"

@implementation HMApp
+ (instancetype)appWithDict:(NSDictionary *)dict
{
    HMApp *app = [[self alloc] init];
    [app setValuesForKeysWithDictionary:dict];
    return app;
}
@end
