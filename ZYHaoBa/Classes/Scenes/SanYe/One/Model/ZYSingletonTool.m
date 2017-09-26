//
//  ZYSingletonTool.m
//  ZYHaoBa
//
//  Created by ylcf on 16/9/29.
//  Copyright © 2016年 正羽. All rights reserved.
//

#import "ZYSingletonTool.h"

@implementation ZYSingletonTool
//不知道为什么不可以用了 以前是可以的
singleton_m(SingletonTool)

//static id _instance;
//+ (id)allocWithZone:(struct _NSZone *)zone
//{
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        _instance = [super allocWithZone:zone];
//    });
//    return _instance;
//}
//
//+ (instancetype)sharedSingletonTool
//{
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        _instance = [[self alloc] init];
//    });
//    return _instance;
//}
//+ (id)copyWithZone:(struct _NSZone *)zone
//{
//    return _instance;
//}



@end
