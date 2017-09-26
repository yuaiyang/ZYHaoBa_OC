//
//  HMApp.h
//  04-自定义Operation
//
//  Created by apple on 14-6-24.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HMApp : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *download;
@property (nonatomic, copy) NSString *icon;

+ (instancetype)appWithDict:(NSDictionary *)dict;
@end
