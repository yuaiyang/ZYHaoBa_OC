//
//  System.h
//  ZYHaoBa
//
//  Created by ylcf on 16/8/11.
//  Copyright © 2016年 正羽. All rights reserved.
//  一些自己使用参数宏定义

#ifndef System_h
#define System_h

#import "ZYProTools.h"// 常用方法
#import "ZYConfig.h"// 配置
#import "Defines.h"     //网址
#import "ZYMacroTools.h" // 宏定义方法
#import "TKAlertCenter.h"//提示框
#import "AFNetworking.h" //请求数据
#import "UIImageView+WebCache.h" //请求图片数据
#import "ZYHttpsTool.h" //请求数据封装
#import "ZYProTools.h" // 一些自定义方法
#import "UIViewController+HUD.h"// 等待图形


//系统设置

//#ifdef DEBUG // 调试状态, 打开LOG功能
//#define ZYLog(...) NSLog(__VA_ARGS__)
//#else // 发布状态, 关闭LOG功能
//#define ZYLog(...)
//#endif

#define DEBUGS

#ifdef DEBUGS
#	define xh(fmt, ...)   NSLog((@"[ak]%s " fmt), __PRETTY_FUNCTION__, ##__VA_ARGS__);
#	define xhf(view)      NSLog(@"(x=%f,y=%f,w=%f,h=%f)",view.frame.origin.x,view.frame.origin.y,view.frame.size.width,view.frame.size.height)
#   define exLog(text, error)   NSLog(@"****请求Error****%@ ：%@", text, error.localizedDescription)

#else
#	define xh(...) {}
#	define xhf(view) {}
#   define exLog(text, error) {}
#endif

// 设置随机色使用宏
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
#define RGBCOLOR(r,g,b)    [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

// 设置随机色
#define ZYRandomColor RGBCOLOR(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))


//主题颜色
#define ZYMAINCOLOER [UIColor colorWithRed:199/255.0 green:122/255.0 blue:233/255.0 alpha:1]

//文字 黑色
#define COLOR_TEXT_BLACK     RGBACOLOR(51, 51, 51, 1)



//提示语
#define showAlert(NSString_string) {\
if ([NSString_string length] && [NSString_string isKindOfClass:[NSString class]]) [[TKAlertCenter defaultCenter] postAlertWithMessage:NSString_string];\
}


//参数方面
//锁定状态未解锁，在置入后台的时候，不需要记录当前时间
#define kISCanSaveTime      @"kISCanSaveTime"
#define kTimeStamp      @"kTimeStamp"

//是否开启手势密码
#define START_GES       @"getStat.txt"
#define GES_PWD         @"gesPwd.txt"

//打开一路财富appstore
#define AppStore_Link @"https://itunes.apple.com/cn/app/yi-lu-cai-fu/id830061089?mt=8"



//用于view跳转页面
extern UIViewController *superVC;

// 键盘处理使用到的宏定义
#define kInitH(name) \
- (id)initWithDict:(NSDictionary *)dict; \
+ (id)name##WithDict:(NSDictionary *)dict;

#define kInitM(name) \
+ (id)name##WithDict:(NSDictionary *)dict \
{ \
return [[self alloc] initWithDict:dict]; \
}

/** 发微博，自定义键盘 表情相关 */
// 表情的最大行数
#define HMEmotionMaxRows 3
// 表情的最大列数
#define HMEmotionMaxCols 7
// 每页最多显示多少个表情
#define HMEmotionMaxCountPerPage (HMEmotionMaxRows * HMEmotionMaxCols - 1)

// 通知
// 表情选中的通知
#define HMEmotionDidSelectedNotification @"HMEmotionDidSelectedNotification"
// 点击删除按钮的通知
#define HMEmotionDidDeletedNotification @"HMEmotionDidDeletedNotification"
// 通知里面取出表情用的key
#define HMSelectedEmotion @"HMSelectedEmotion"

// 链接选中的通知
#define HMLinkDidSelectedNotification @"HMLinkDidSelectedNotification"

// 富文本里面出现的链接
#define HMLinkText @"HMLinkText"

// 关于键盘的通知
// 数字或者英文选中的通知
#define ZYNumberDidSelectedNotification @"ZYNumberDidSelectedNotification"
// 通知里面取出点击数字用的key
#define ZYSelectedNumber @"ZYSelectedNumber"
// 数字或者英文选中的通知
#define ZYToolBarDidSelectedDeleteNotification @"ZYToolBarDidSelectedDeleteNotification"

#endif /* System_h */
