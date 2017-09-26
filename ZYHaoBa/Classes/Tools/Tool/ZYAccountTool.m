//
//  ZYAccountTool.m
//  ZYHaoBa
//
//  Created by ylcf on 16/8/24.
//  Copyright © 2016年 正羽. All rights reserved.
//

#import "ZYAccountTool.h"
#import "ZYAccount.h"

//存储用户个人信息的文件路径
#define HMAccountFilepath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.data"]

@implementation ZYAccountTool

+ (void)save:(ZYAccount *)account
{
    // 归档
    [NSKeyedArchiver archiveRootObject:account toFile:HMAccountFilepath];
}

+ (ZYAccount *)account
{
    // 读取帐号
    ZYAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:HMAccountFilepath];
    
    // 判断帐号是否已经过期
    NSDate *now = [NSDate date];
    
    if ([now compare:account.expires_time] != NSOrderedAscending) { // 过期
        account = nil;
    }
    return account;
}

@end
