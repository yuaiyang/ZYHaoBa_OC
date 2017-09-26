//
//  NJProvince.m
//  32-键盘处理
//
//  Created by 李南江 on 14-2-9.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "NJProvince.h"

@implementation NJProvince

kInitM(province)

- (id)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        self.name = dict[@"name"];
        self.cities = dict[@"cities"];
    }
    return self;
}
@end
