//
//  ZYAccount.h
//  ZYHaoBa
//
//  Created by ylcf on 16/8/24.
//  Copyright © 2016年 正羽. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZYAccount : NSObject

/** string 	access_token的生命周期，单位是秒数。*/
@property (nonatomic, copy) NSString *expires_in;

/** 过期时间 */
@property (nonatomic, strong) NSDate *expires_time;

/** string 	当前授权用户的ID。*/
@property (nonatomic, copy) NSString *uid;

/**
 *  用户昵称
 */
@property (nonatomic, copy) NSString *name;

@end
