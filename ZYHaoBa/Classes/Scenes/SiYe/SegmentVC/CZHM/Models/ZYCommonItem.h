//
//  ZYCommonItem.h
//  ZYHaoBa
//
//  Created by ylcf on 16/8/22.
//  Copyright © 2016年 正羽. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark 用一个HMCommonItem模型来描述每行的信息：图标、标题、子标题、右边的样式（箭头、文字、数字、开关、打钩）
@interface ZYCommonItem : NSObject


/** 图标 */
@property (nonatomic, copy) NSString *icon;
/** 标题 */
@property (nonatomic, copy) NSString *title;
/** 子标题 */
@property (nonatomic, copy) NSString *subtitle;
/** 右边显示的数字标记 */
@property (nonatomic, copy) NSString *badgeValue;
/** 点击这行cell，需要调转到哪个控制器 */
@property (nonatomic, assign) Class destVcClass;
/** 封装点击这行cell想做的事情 */
// block 只能用 copy
@property (nonatomic, copy) void (^operation)();

+ (instancetype)itemWithTitle:(NSString *)title icon:(NSString *)icon;
+ (instancetype)itemWithTitle:(NSString *)title;

@end
