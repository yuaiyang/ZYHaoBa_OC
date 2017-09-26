//
//  UIView+Extension.h
//  ZYHaoBa
//
//  Created by ylcf on 16/8/22.
//  Copyright © 2016年 正羽. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extension)
#pragma mark - 设置标题
+ (nullable UIView *)viewWithLabelText:(nullable NSString *)titleName textColor:(nullable UIColor *)color fontSize:(float)size;
#pragma mark - 设置尺寸
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGPoint origin;
@end
