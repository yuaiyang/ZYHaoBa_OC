//
//  UIImage+Extension.h
//  ZYHaoBa
//
//  Created by ylcf on 16/8/22.
//  Copyright © 2016年 正羽. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)
/**
 *  根据图片名返回一张能够自由拉伸的图片
 */
+ (UIImage *)resizedImage:(NSString *)name;
#pragma mark - 给予颜色返回一个带有颜色的图片
+(UIImage *)imageWithBankgroudColor:(UIColor *)color;
#pragma mark - 给予颜色返回一个带有颜色的图片（黑马网易使用）
+ (UIImage *)imageWithColor:(UIColor *)color;
@end
