//
//  ZYAccountTool.h
//  ZYHaoBa
//
//  Created by ylcf on 16/8/24.
//  Copyright © 2016年 正羽. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ZYAccount;

@interface ZYAccountTool : NSObject

/**
 *  存储帐号
 */
+ (void)save:(ZYAccount *)account;

/**
 *  读取帐号
 */
+ (ZYAccount *)account;

@end
