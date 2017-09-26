//
//  ZYCommonGroup.m
//  ZYHaoBa
//
//  Created by ylcf on 16/8/22.
//  Copyright © 2016年 正羽. All rights reserved.
//

#import "ZYCommonGroup.h"

#pragma mark 用一个HMCommonGroup模型来描述每组的信息：组头、组尾、这组的所有行模型
@implementation ZYCommonGroup

+ (instancetype)group
{
    return [[self alloc] init];
}

@end
