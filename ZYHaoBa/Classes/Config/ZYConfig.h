
//
//  ZYConfig.h
//  ZYHaoBa
//
//  Created by ylcf on 16/8/11.
//  Copyright © 2016年 正羽. All rights reserved.
//  一些系统配置文件不包含自己定义参数

#ifndef ZYConfig_h
#define ZYConfig_h

//配置文件
#define __UserDefaults [NSUserDefaults standardUserDefaults]

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#define IS_IPHONE_4 (SCREEN_HEIGHT < 568.0)
#define IS_IPHONE_5 (SCREEN_HEIGHT == 568.0)
#define IS_IPHONE_6 (SCREEN_HEIGHT == 667.0)
#define IS_IPHONE_6P (SCREEN_HEIGHT == 736.0)

#define IS_IOS6 [[[UIDevice currentDevice] systemVersion] floatValue] < 7.0f
#define IS_IOS7 [[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0f
#define IS_IOS8 [[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0f
#define IS_IOS9 [[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0f

// 屏幕尺寸
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#define kTab_HEIGHT     49.f
#define kNav_HEIGHT     64.f
#define kHeaderHeight   44.f


//其他
#define __UserDefaults [NSUserDefaults standardUserDefaults]
#define KEY_WINDOW  [[UIApplication sharedApplication] keyWindow]


#endif /* ZYConfig_h */
