//
//  HMQuestion.h
//  01-超级猜图
//
//  Created by apple on 14-8-15.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HMQuestion : NSObject
@property (nonatomic, copy) NSString *answer;
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) NSArray *options;

@property (nonatomic, strong, readonly) UIImage *image;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)questionWithDict:(NSDictionary *)dict;

/** 返回所有题目数组 */
+ (NSArray *)questions;

/** 打乱备选文字的数组 */
- (void)randamOptions;

@end
