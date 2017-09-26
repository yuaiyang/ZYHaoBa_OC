//
//  HighPerformanceModel.h
//  NavigationBarTranslation
//
//  Created by Johnil on 16/2/19.
//  Copyright © 2016年 Johnil. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HighPerformanceModel : NSObject

@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSString *avatarUrl;
@property (nonatomic) float height;

- (instancetype)initWithDict:(NSDictionary *)dict;

@end
