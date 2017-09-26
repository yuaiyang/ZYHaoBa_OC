//
//  UIImage+Additions.h
//  allinone
//
//  Created by Johnil on 16/2/24.
//  Copyright © 2016年 Johnil. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Additions)

- (UIImage *) tintImageWithColor:(UIColor *)tintColor;
+ (UIImage *)imageWithColor:(UIColor *)color;
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

@end
