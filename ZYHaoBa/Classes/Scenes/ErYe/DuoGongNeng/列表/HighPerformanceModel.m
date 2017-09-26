//
//  HighPerformanceModel.m
//  NavigationBarTranslation
//
//  Created by Johnil on 16/2/19.
//  Copyright © 2016年 Johnil. All rights reserved.
//

#import "HighPerformanceModel.h"
#import "HighPerformanceTableViewCell.h"

@implementation HighPerformanceModel

- (instancetype)initWithDict:(NSDictionary *)dict{
    self = [super init];
    if (self) {
        _text = dict[@"text"];
        _avatarUrl = dict[@"avatarUrl"];
        _height = [HighPerformanceTableViewCell calcHeighWithString:_text];
    }
    return self;
}

@end
