//
//  ZYCommonGroup.h
//  ZYHaoBa
//
//  Created by ylcf on 16/8/22.
//  Copyright © 2016年 正羽. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark 用一个HMCommonGroup模型来描述每组的信息：组头、组尾、这组的所有行模型
@interface ZYCommonGroup : NSObject

/** 组头 */
@property (nonatomic, copy) NSString *header;
/** 组尾 */
@property (nonatomic, copy) NSString *footer;
/** 这组的所有行模型(数组中存放的都是HMCommonItem模型) */
@property (nonatomic, strong) NSArray *items;

+ (instancetype)group;

@end
