//
//  NSString+Extension.h
//  ZYHaoBa
//
//  Created by ylcf on 16/8/24.
//  Copyright © 2016年 正羽. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)

#pragma mark - 表情处理（传入emoji表情编码）
/**
 *  将十六进制的编码转为emoji字符
 */
+ (NSString *)emojiWithIntCode:(int)intCode;

/**
 *  将十六进制的编码转为emoji字符
 */
+ (NSString *)emojiWithStringCode:(NSString *)stringCode;

/**
 *  是否为emoji字符
 */
- (BOOL)isEmoji;

#pragma mark - 清除缓存（传入文件路径，可以是文件，也可以是文件夹-内部是递归处理）返回内容文件字节大小
- (long long)fileSize;

#pragma mark -  判断字符串小数点后两位数字是否为0，为0则删除
+ (NSString *)judgeStringIsGreaterThanTwoWithString:(NSString *)str;


@end
