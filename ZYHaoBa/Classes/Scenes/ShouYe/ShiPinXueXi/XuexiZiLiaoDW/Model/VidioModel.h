//
//  VidioModel.h
//  ZYHaoBa
//
//  Created by ylcf on 16/10/14.
//  Copyright © 2016年 正羽. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VidioModel : NSObject

/**
 *  视频ID
 */
@property (assign, nonatomic) int ID;
/**
 *  视频名称
 */
@property (copy, nonatomic) NSString *name;
/**
 *  视频长度
 */
@property (assign, nonatomic) int length;
/**
 *  视频图片
 */
@property (copy, nonatomic) NSString *image;
/**
 *  视频链接
 */
@property (copy, nonatomic) NSString *url;

+ (instancetype)videoWithDict:(NSDictionary *)dict;

@end
