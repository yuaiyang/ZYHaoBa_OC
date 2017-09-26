//
//  DemoCache.m
//  NavigationBarTranslation
//
//  Created by Johnil on 16/2/19.
//  Copyright © 2016年 Johnil. All rights reserved.
//

#import "DemoCache.h"

@implementation DemoCache

+ (NSCache *)cache{
    static NSCache *cache;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        cache = [[NSCache alloc] init];
    });
    return cache;
}

@end
