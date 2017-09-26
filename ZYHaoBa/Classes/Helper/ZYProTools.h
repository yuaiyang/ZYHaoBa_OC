//
//  ZYProTools.h
//  ZYHaoBa
//
//  Created by ylcf on 16/8/12.
//  Copyright © 2016年 正羽. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZYProTools : NSObject

#pragma mark 根据text 文字内容 显示文字控件大小size 文字大小 font计算自适应size
+(CGSize)getSizeOfText:(NSString *)text sizeBy:(CGSize)size font:(UIFont*)font;

#pragma mark 时间戳
+ (NSString*)getCurTimeLong;
+ (NSString *)GetTimeDateWith:(NSString *)timesp;

#pragma mark 是否有网络连接
+ (BOOL)checkNetWorkConnection;

#pragma mark 提示框
// 无代理  btnText按钮文字信息
+ (void)showAlertViewWithMsg:(NSString*)msg withBtnText:(NSString*)btnText;
//提示功能:msg提示信息  delegate代理  btnText按钮文字信息
+ (void)showAlertViewWithMsg:(NSString*)msg withDelegate:(id<UIAlertViewDelegate>)delegate withBtnText:(NSString*)btnText WithTag:(int)tag;
+ (void)showAlertViewWithMsg:(NSString*)msg withDelegate:(id<UIAlertViewDelegate>)delegate withLeftIsCancel:(BOOL)isCancel WithTag:(int)tag;
+ (void)showAlertViewWithMsg:(NSString*)msg withDelegate:(id<UIAlertViewDelegate>)delegate withLeftText:(NSString *)leftTxt  withRightText:(NSString *)rightTxt WithTag:(int)tag;

#pragma mark 缓存
//添加数据至缓存，用于本地化
+ (BOOL)writeFileToCache:(id)data dataType:(NSString *)type FileName:(NSString *)fileName;
//读取数据 获取的是filePath
+ (NSString *)readFileFromCacheWithFileName:(NSString *)fileName;

#pragma mark 类型转换
//NSDictionary类型转换为NSData类型：
+ (NSData *)getDataWithDictionaary:(NSDictionary *)dic;
//NSData类型转换为NSDictionary类型：
+ (NSDictionary *)getDictionaryWithData:(NSData *)data;

#pragma mark 字符串格式化
//定义函数，进行对应的网络地址的汉字转换操作
+(NSString *)getFormatURLFromString:(NSString *)dataString;
//定义函数，进行对应空字符串的“--”转化，对于非空字符串直接返回处理
+(NSString *)getChangedStringFromString:(NSString *)dataString;
//定义函数，获取以空格分隔的4位一组且将中间字符串替换为*的字符串,主要用于银行卡
+(NSString*)getSecretedStringFromString:(NSString *)sourceString;
//* 获取银行卡末4位数
+(NSString *)getLastForthStringFromString:(NSString *)sourceString;
//* 将电话号码中间隐藏
+ (NSString *)getPhoneNumberHideFromString:(NSString *)sourceString;

#pragma mark 校验
//判断手机号合法性
+(BOOL)CheckPhoneInput:(NSString *)_text;
#pragma mark  邮箱验证合法性
+(BOOL)isValidateEmail:(NSString *)email;
#pragma mark  邮政编码验证合法性
+(BOOL)isPostalCode:(NSString *)postalCode;
//身份证号校验
+ (BOOL)validateIDCardNumber:(NSString *)value;
//判断 金额输入的格式
+(BOOL)isMoneyInputJudgeWithInputString:(NSString*)string;
//全数字输入
+(BOOL)PureNumbers:(NSString*)str;

#pragma mark 时间格式转换
//将20141122 格式化为2014-11-22  是否带时间
+ (NSString *)getDateStringForVisiable:(NSString*)dateString withTime:(BOOL)withTime;
//将2014-11-22 10:00:10 格式化为2014-11-22
+ (NSString *)getFormatDateStringForVisiable:(NSString*)dateString;
//将2014-11-22格式化为11-22
+ (NSString *)getSubDateStringForMonthAndDay:(NSString *)dateString;

#pragma mark 判空 去空格
//判空
+ (BOOL)CheckEmptyWithString:(NSString *)string;
//去空格
+ (NSString *)CompareRemovalSpaceWithString:(NSMutableString *)string;

#pragma mark 指纹解锁
// 是否支持指纹解锁
+ (BOOL)fingerprintIdentification;
// 是否可用
+ (BOOL)fingerIdentificationIsCanUse;

#pragma mark 格式化电话薄
+ (NSString *)formatPhoneNumberWithString:(NSString *)phoneNumber;

#pragma mark Read & Save PList文件
+ (NSMutableDictionary *)readJYUserPListFile;
+ (BOOL)saveJYUserPListFileWithData:(NSMutableDictionary *)data;

+ (NSMutableDictionary *)doInitFormatJYUserList;

#pragma mark JYKeyboard Button
+ (UIButton *)instanceKeyBoardButton;

#pragma mark 时间戳确定5min的间隔
+ (BOOL)isLastStartForFiveMinutes;

#pragma mark 保存当前的时间戳
+ (void)doSaveCurrentTime;

#pragma mark 处理字符串最后一个设置字体大小
+ (NSMutableAttributedString *)setStringLastWordForString:(nullable NSString *)string fontSize:(CGFloat)size;

#pragma mark 设置标题（逸飞重新设置）
+ (nullable UIView *)setZYTitleLabel:(nullable NSString *)titleName fontSize:(float)size;

#pragma mark iOS8.0以后设置提示框（单按钮）
+ (void)showZYSingleAlertViewWithTitle:(nullable NSString *)title Msg:(nullable NSString*)msg withBtnText:(nullable NSString *)btnTxt;

#pragma mark iOS8.0以后设置提示框（左右按钮）
+ (void)showZYDoublelAlertViewWithTitle:(nullable NSString *)title Msg:(nullable NSString*)msg withLeftText:(nullable NSString *)leftTxt withRightText:(nullable NSString *)rightTxt rightHandler:(void (^ __nullable)(UIAlertAction *action))rightHandler;
#pragma mark iOS8.0以后设置提示框 左对齐 （左右按钮）
+ (void)showLeftAlineAlertViewWithTitle:(nullable NSString *)title Msg:(nullable NSString*)msg withLeftText:(nullable NSString *)leftTxt withRightText:(nullable NSString *)rightTxt rightHandler:(void (^ __nullable)(UIAlertAction *action))rightHandler;

#pragma mark iOS8.0以后设置底部提示框（底部按钮）
+ (void)showBottomAlertViewWithTitle:(nullable NSString *)title Msg:(nullable NSString*)msg cancelText:(nullable NSString *)cancelText withActionText:(nullable NSString *)actionText actionHandler:(void (^ __nullable)(UIAlertAction *action))actionHandler;

#pragma mark 获取用户唯一标示1
+(NSString*)uuid;

#pragma mark 获取用户唯一标示2
+ (NSString *)stringWithUUID;

@end
