//
//  NJCityPicker.h
//  32-键盘处理
//
//  Created by 李南江 on 14-2-9.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>
@class NJCityPicker;

@protocol NJCityPickerDelegate <NSObject>
@optional
- (void)cityPicker:(NJCityPicker *)cityPicker province:(NSString *)province city:(NSString *)city;

@end

@interface NJCityPicker : UIView
//创建实例工厂方法
+ cityPicker;
//代理
@property (nonatomic, weak)id<NJCityPickerDelegate> delegate;

@end
