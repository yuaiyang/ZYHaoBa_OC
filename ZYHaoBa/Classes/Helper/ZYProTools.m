//
//  ZYProTools.m
//  ZYHaoBa
//
//  Created by ylcf on 16/8/12.
//  Copyright © 2016年 正羽. All rights reserved.
//

#import "ZYProTools.h"
#import <LocalAuthentication/LAContext.h>
#import <LocalAuthentication/LAError.h>

@implementation ZYProTools

#pragma mark 根据text 文字内容 显示文字控件大小size 文字大小 font计算自适应size
+(CGSize)getSizeOfText:(NSString *)text sizeBy:(CGSize)size font:(UIFont*)font {
    NSDictionary * attrs = [NSDictionary dictionaryWithObjectsAndKeys:
                            font,
                            NSFontAttributeName,
                            nil];
    CGRect rect = [text boundingRectWithSize:size options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading) attributes:attrs context:nil];
    return rect.size;
}

+(NSString*)getCurTimeLong {
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970];
    NSString *timeString = [NSString stringWithFormat:@"%.0f", a];
    return timeString;
}

// 无代理  btnText按钮文字信息 YYY
+ (void)showAlertViewWithMsg:(NSString*)msg withBtnText:(NSString*)btnText {
    if (btnText == nil) {
        btnText = @"返回";
    }
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil
                                                        message:msg
                                                       delegate:nil
                                              cancelButtonTitle:btnText
                                              otherButtonTitles:nil];
    [alertView show];
}

//提示功能:msg提示信息  delegate代理  btnText按钮文字信息 YYY
+(void)showAlertViewWithMsg:(NSString*)msg withDelegate:(id<UIAlertViewDelegate>)delegate withBtnText:(NSString*)btnText WithTag:(int)tag {
    if (btnText == nil) {
        btnText = @"返回";
    }
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil
                                                        message:msg
                                                       delegate:delegate
                                              cancelButtonTitle:nil
                                              otherButtonTitles:btnText,nil];
    alertView.tag = tag;
    [alertView show];
}

+(void)showAlertViewWithMsg:(NSString*)msg withDelegate:(id<UIAlertViewDelegate>)delegate withLeftIsCancel:(BOOL)isCancel WithTag:(int)tag{
    
    if (isCancel) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil
                                                            message:msg
                                                           delegate:delegate
                                                  cancelButtonTitle:nil
                                                  otherButtonTitles:@"取消", @"确定", nil];
        alertView.tag = tag;
        [alertView show];
    }
    else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil
                                                            message:msg
                                                           delegate:delegate
                                                  cancelButtonTitle:nil
                                                  otherButtonTitles:@"确定", @"取消", nil];
        alertView.tag = tag;
        [alertView show];
    }
}

+ (void)showAlertViewWithMsg:(NSString*)msg withDelegate:(id<UIAlertViewDelegate>)delegate withLeftText:(NSString *)leftTxt  withRightText:(NSString *)rightTxt WithTag:(int)tag {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil
                                                        message:msg
                                                       delegate:delegate
                                              cancelButtonTitle:nil
                                              otherButtonTitles:leftTxt, rightTxt, nil];
    alertView.tag = tag;
    [alertView show];
}

#pragma mark Net Connection
+ (BOOL)checkNetWorkConnection {
    return YES;
}

#pragma mark Write & Read File
//添加数据至缓存，用于本地化
+ (BOOL)writeFileToCache:(id)data dataType:(NSString *)type FileName:(NSString *)fileName {
    BOOL ret = NO;
    
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString * docDir = [paths objectAtIndex:0];
    if(!docDir) {
        xh(@"cache 目录未找到");
        return ret;
    }
    
    NSString * filePath = [docDir stringByAppendingPathComponent:fileName];
    if ([type isEqualToString:@"NSDictionary"]) {
        NSData * da = [self getDataWithDictionaary:data];
        ret = [da writeToFile:filePath atomically:YES];
    }
    
    if ([type isEqualToString:@"NSString"]) {
        ret = [data writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
    }
    return ret;
}

//读取数据 获取的是filePath
+ (NSString *)readFileFromCacheWithFileName:(NSString *)fileName {
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString * docDir = [paths objectAtIndex:0];
    NSString * filePath = [docDir stringByAppendingPathComponent:fileName];
    return filePath;
}


//NSDictionary类型转换为NSData类型：
+ (NSData *)getDataWithDictionaary:(NSDictionary *)dic {
    
    NSMutableData * data = [[NSMutableData alloc] init];
    NSKeyedArchiver * archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:dic forKey:@"Some Key Value"];
    [archiver finishEncoding];
    return data;
}


//NSData类型转换为NSDictionary类型：
+ (NSDictionary *)getDictionaryWithData:(NSData *)data {
    NSKeyedUnarchiver * unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    NSDictionary * myDictionary = [unarchiver decodeObjectForKey:@"Some Key Value"];
    [unarchiver finishDecoding];
    return myDictionary;
}

//定义函数，进行对应的网络地址的汉字转换操作
+(NSString *)getFormatURLFromString:(NSString *)dataString
{
    //对传入的数据进行对应的验空操作处理
    if(dataString==nil||dataString.length==0)
    {
        //        xh(@"进行对应请求网址转化时传入的对应网络地址为空，请检查输入！");
        return @"";
    }
    
    //将对应的原始url转化为cfstring
    CFStringRef originalURL=(__bridge CFStringRef)dataString;
    //将对应的汉字转化为对应的空字符串并进行对应的替代操作
    CFStringRef preProcessedString=CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault, originalURL,CFSTR(""), kCFStringEncodingUTF8);
    //用对应的空位符进行对应的字符串的替代处理操作
    CFStringRef processedString=CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, preProcessedString, NULL, NULL, kCFStringEncodingUTF8);
    //获得对应的url变量
    CFURLRef url=CFURLCreateWithString(kCFAllocatorDefault, processedString, NULL);
    
    //将对应的url转化为对应的nsurl对象
    //    NSString *resultString = (__bridge NSString*)url;
    NSString *resultString =(__bridge_transfer NSString*)url;
    
    
    //将对应的nsurl对象转化为对应的nsstring对象
    if([resultString isKindOfClass:[NSURL class]])
    {
        NSURL* tempURL=(__bridge NSURL*)url;
        resultString=[tempURL absoluteString];
    }
    
    //将对应的结果进行返回操作
    return resultString;
}


//定义函数，进行对应空字符串的“--”转化，对于非空字符串直接返回处理
+(NSString *)getChangedStringFromString:(NSString *)dataString
{
    NSString *resultString=@"";
    
    if(dataString==nil||dataString.length==0)
    {
        resultString=@"--";
    }
    else
    {
        resultString=dataString;
    }
    
    return resultString;
}

//定义函数，获取以空格分隔的4位一组且将中间字符串替换为*的字符串,主要用于银行卡
+(NSString*)getSecretedStringFromString:(NSString *)sourceString
{
    //对传入数据进行判空操作
    if(sourceString==nil||sourceString.length==0)
    {
        xh(@"进行我的银行卡cell转化时传入的源字符串信息有误，请检查输入！");
        return @"";
    }
    
    //定义字符串，进行对应的处理结果变量的保存操作
    NSString *result = @"";
    
    //定义可变字符串，进行对应处理结果的保存处理
    NSMutableString *tempString=[[NSMutableString alloc]init];
    
    //定义变量，保存对应源字符串的长度
    int stringLength = (int)sourceString.length;
    
    //定义可变字符串，进行对应的当前字符串的替换字符串的保存处理
    NSMutableString *replaceString=[[NSMutableString alloc]init];
    
    //利用循环，根据对应的数据长度，进行对应替换字符串的生成操作处理
    for(int i=0;i<stringLength-8;i++)
    {
        [replaceString appendString:@"*"];
    }
    
    //定义字符串，进行已经替换为*的对应字符串的处理操作
    NSString *dealtString=[sourceString stringByReplacingCharactersInRange:NSMakeRange(4, stringLength-8) withString:replaceString];
    
    //调用循环进行对应格式字符串的生成操作
    for(int i=0;i<stringLength;i++)
    {
        //当为第一个字符时直接进行字符添加
        if(i==0)
        {
            [tempString appendString:[NSString stringWithFormat:@"%c",[dealtString characterAtIndex:i]]];
        }
        //当对应的字符为能被4整除且不为最后一个时进行空格添加处理
        else if(i%4==0&&i!=(stringLength-1))
        {
            [tempString appendString:[NSString stringWithFormat:@" %c",[dealtString characterAtIndex:i]]];
        }
        //当为其他情况时，直接进行字符添加处理
        else
        {
            [tempString appendString:[NSString stringWithFormat:@"%c",[dealtString characterAtIndex:i]]];
        }
    }
    
    //进行对应结果变量的保存操作
    result=[NSString stringWithFormat:@"%@",tempString];
    
    return result;
}

//* 获取银行卡末4位数
+(NSString *)getLastForthStringFromString:(NSString *)sourceString {
    if (sourceString == nil || sourceString.length <= 4) {
        xh(@"获取银行卡末4位数，卡号信息错误");
        return @"";
    }
    
    return [sourceString substringFromIndex:sourceString.length-4];
}

#pragma mark 判断手机号合法性
+(BOOL)CheckPhoneInput:(NSString *)_text {
    
    NSString *Regex = @"^0?(13|15|18|14|17)[0-9]{9}$";
    
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", Regex];
    
    return [emailTest evaluateWithObject:_text];
    
}

#pragma mark  邮箱验证合法性
+(BOOL)isValidateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

#pragma mark  邮政编码验证合法性
+(BOOL)isPostalCode:(NSString *)postalCode
{
    NSString *codeRegex = @"^\\d{6}$";
    NSPredicate *codeTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", codeRegex];
    return [codeTest evaluateWithObject:postalCode];
}

#pragma mark 身份证号校验
+ (BOOL)validateIDCardNumber:(NSString *)value {
    value = [value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    int length =0;
    if (!value) {
        return NO;
    }
    else {
        length = (int)value.length;
        
        if (length !=15 && length !=18) {
            return NO;
        }
    }
    // 省份代码
    NSArray * areasArray = @[@"11", @"12", @"13", @"14", @"15", @"21", @"22", @"23", @"31", @"32", @"33", @"34", @"35", @"36", @"37", @"41", @"42", @"43", @"44", @"45", @"46", @"50", @"51", @"52", @"53", @"54", @"61", @"62", @"63", @"64", @"65", @"71", @"81", @"82", @"91"];
    
    NSString * valueStart2 = [value substringToIndex:2];
    BOOL areaFlag = NO;
    for (NSString * areaCode in areasArray) {
        if ([areaCode isEqualToString:valueStart2]) {
            areaFlag = YES;
            break;
        }
    }
    
    if (!areaFlag) {
        return false;
    }
    
    NSRegularExpression *regularExpression;
    NSUInteger numberofMatch;
    
    int year =0;
    switch (length) {
        case 15:
            year = [value substringWithRange:NSMakeRange(6,2)].intValue +1900;
            
            if (year %4 ==0 || (year %100 ==0 && year %4 ==0)) {
                
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}$"
                                                                        options:NSRegularExpressionCaseInsensitive
                                                                          error:nil];//测试出生日期的合法性
            }else {
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}$"
                                                                        options:NSRegularExpressionCaseInsensitive
                                                                          error:nil];//测试出生日期的合法性
            }
            numberofMatch = [regularExpression numberOfMatchesInString:value
                                                               options:NSMatchingReportProgress
                                                                 range:NSMakeRange(0, value.length)];
            
            //            [regularExpression release];
            
            if(numberofMatch > 0) {
                return YES;
            }
            else {
                return NO;
            }
        case 18:
            
            year = [value substringWithRange:NSMakeRange(6,4)].intValue;
            if (year %4 ==0 || (year %100 ==0 && year %4 ==0)) {
                
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}[0-9Xx]$"
                                                                        options:NSRegularExpressionCaseInsensitive
                                                                          error:nil];//测试出生日期的合法性
            }else {
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}[0-9Xx]$"
                                                                        options:NSRegularExpressionCaseInsensitive
                                                                          error:nil];//测试出生日期的合法性
            }
            numberofMatch = [regularExpression numberOfMatchesInString:value
                                                               options:NSMatchingReportProgress
                                                                 range:NSMakeRange(0, value.length)];
            
            //            [regularExpression release];
            
            if(numberofMatch >0) {
                int S = ([value substringWithRange:NSMakeRange(0,1)].intValue + [value substringWithRange:NSMakeRange(10,1)].intValue) *7 + ([value substringWithRange:NSMakeRange(1,1)].intValue + [value substringWithRange:NSMakeRange(11,1)].intValue) *9 + ([value substringWithRange:NSMakeRange(2,1)].intValue + [value substringWithRange:NSMakeRange(12,1)].intValue) *10 + ([value substringWithRange:NSMakeRange(3,1)].intValue + [value substringWithRange:NSMakeRange(13,1)].intValue) *5 + ([value substringWithRange:NSMakeRange(4,1)].intValue + [value substringWithRange:NSMakeRange(14,1)].intValue) *8 + ([value substringWithRange:NSMakeRange(5,1)].intValue + [value substringWithRange:NSMakeRange(15,1)].intValue) *4 + ([value substringWithRange:NSMakeRange(6,1)].intValue + [value substringWithRange:NSMakeRange(16,1)].intValue) *2 + [value substringWithRange:NSMakeRange(7,1)].intValue *1 + [value substringWithRange:NSMakeRange(8,1)].intValue *6 + [value substringWithRange:NSMakeRange(9,1)].intValue *3;
                int Y = S %11;
                NSString *M =@"F";
                NSString *JYM =@"10X98765432";
                M = [JYM substringWithRange:NSMakeRange(Y,1)];// 判断校验位
                if ([M isEqualToString:[value substringWithRange:NSMakeRange(17,1)]]) {
                    return YES;// 检测ID的校验位
                }else {
                    return NO;
                }
                
            }
            else {
                return NO;
            }
        default:
            return false;
    }
}

#pragma mark 全数字输入验证
+(BOOL)PureNumbers:(NSString*)str{
    for(int i=0;i<str.length;i++){
        unichar c = [str characterAtIndex:i];
        if(c<'0'||c>'9')
            return NO;
    }
    return YES;
}

//判断 金额输入的格式
+(BOOL)isMoneyInputJudgeWithInputString:(NSString*)string {
    
    static BOOL isHaveDian=YES;
    
    if ([string rangeOfString:@"."].location==NSNotFound) {
        isHaveDian=NO;
    }
    if ([string length]>0)
    {
        unichar single=[string characterAtIndex:0];//当前输入的字符
        
        if ((single >='0' && single<='9') || single=='.')//数据格式正确
        {
            if (string.length==1&&[string isEqualToString:@"0"]) {
                
                if (single!='.') {
                    
                    return NO;
                }
                
            }
            //首字母不能为小数点
            if([string length]==0){
                if(single == '.'){
                    return NO;
                }
            }
            if (single=='.')
            {
                if(!isHaveDian)//text中还没有小数点
                {
                    isHaveDian=YES;
                    return YES;
                }else
                {
                    return NO;
                }
            }
            else
            {
                if (isHaveDian)//存在小数点
                {
                    //判断小数点的位数
                    //                    NSRange ran=[textField.text rangeOfString:@"."];
                    //                    int tt=textField.text.length-1-ran.location;
                    
                    //不进行小数位数的校验
                    return YES;
                }
                else
                {
                    return YES;
                }
            }
        }else{
            return NO;
        }
    }
    else
    {
        return YES;
    }
    
}

//将20141122 格式化为2014-11-22
+ (NSString *)getDateStringForVisiable:(NSString*)dateString withTime:(BOOL)withTime{
    if (dateString == nil) {
        return @"";
    }
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    if (dateString.length > 8) {
        formatter.dateFormat = @"yyyyMMddHHmmss";
    }else{
        formatter.dateFormat = @"yyyyMMdd";
    }
    NSDate *date = [formatter dateFromString:dateString];
    if (withTime == YES) {
        formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    }else{
        formatter.dateFormat = @"yyyy-MM-dd";
    }
    NSString *returnValue = [formatter stringFromDate:date];
    return returnValue;
}

//将2014-11-22 10:00:10 格式化为2014-11-22

+ (NSString *)getFormatDateStringForVisiable:(NSString*)dateString {
    if (dateString.length < 10) {
        return dateString;
    }
    
    return [[dateString componentsSeparatedByString:@" "] firstObject];
}

//将2014-11-22格式化为11-22
+ (NSString *)getSubDateStringForMonthAndDay:(NSString *)dateString {
    if (dateString.length < 10) {
        return dateString;
    }
    
    return [dateString substringFromIndex:5];
}


//判空
+ (BOOL)CheckEmptyWithString:(NSString *)string {
    BOOL ret = YES;
    if (string == nil) {
        return ret;
    }
    if (string.length == 0) {
        return ret;
    }
    
    ret = NO;
    return ret;
}

//去空格
+ (NSString *)CompareRemovalSpaceWithString:(NSMutableString *)string {
    NSString * str = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
    return str;
}

- (NSString*)weekDayStr:(NSString *)format
{
    NSString *weekDayStr = nil;
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    
    NSString *str = [self description];
    if (str.length >= 10) {
        NSString *nowString = [str substringToIndex:10];
        NSArray *array = [nowString componentsSeparatedByString:@"-"];
        if (array.count == 0) {
            array = [nowString componentsSeparatedByString:@"/"];
        }
        if (array.count >= 3) {
            int year = [[array objectAtIndex:0] intValue];
            int month = [[array objectAtIndex:1] intValue];
            int day = [[array objectAtIndex:2] intValue];
            [comps setYear:year];
            [comps setMonth:month];
            [comps setDay:day];
        }
    }
    
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *_date = [gregorian dateFromComponents:comps];
    NSDateComponents *weekdayComponents = [gregorian components:NSWeekdayCalendarUnit fromDate:_date];
    int week = (int)[weekdayComponents weekday];
    week ++;
    switch (week) {
        case 1:
            weekDayStr = @"星期日";
            break;
        case 2:
            weekDayStr = @"星期一";
            break;
        case 3:
            weekDayStr = @"星期二";
            break;
        case 4:
            weekDayStr = @"星期三";
            break;
        case 5:
            weekDayStr = @"星期四";
            break;
        case 6:
            weekDayStr = @"星期五";
            break;
        case 7:
            weekDayStr = @"星期六";
            break;
        default:
            weekDayStr = @"";
            break;
    }
    return weekDayStr;
}


+ (BOOL)fingerprintIdentification {
    BOOL ret = NO;
    if ([UIDevice currentDevice].systemVersion.floatValue < 8.0) {
        return ret;
    }
    
    LAContext * ctx = [[LAContext alloc] init];
    NSError *authError = nil;
    
    // 判断设备是否支持指纹识别
    if ([ctx canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&authError]) {
        return !ret;
    }
    else {
        switch (authError.code) {
            case LAErrorTouchIDNotEnrolled: {
                xh(@"TouchID is not enrolled--没有设置指纹");
                return !ret;
                break;
            }
            case LAErrorPasscodeNotSet: {
                xh(@"A passcode has not been set--没有设置密码");
                return !ret;
                break;
            }
            default: {
                xh(@"TouchID not available--指纹解锁不可用");
                break;
            }
        }
        return ret;
    }
}

+ (BOOL)fingerIdentificationIsCanUse {
    BOOL ret = NO;
    if ([UIDevice currentDevice].systemVersion.floatValue < 8.0) {
        return ret;
    }
    
    LAContext * ctx = [[LAContext alloc] init];
    NSError *authError = nil;
    
    // 判断设备是否支持指纹识别
    if ([ctx canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&authError]) {
        return !ret;
    }
    else {
        return ret;
    }
}

#pragma mark 时间戳转换
+ (NSString *)GetTimeDateWith:(NSString *)timesp {
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setDateStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    
    NSDate * confromTimesp = [NSDate dateWithTimeIntervalSince1970:[timesp doubleValue]];
    NSString * dateStr = [formatter stringFromDate:confromTimesp];
    return dateStr;
}

#pragma mark 格式化电话薄
+ (NSString *)formatPhoneNumberWithString:(NSString *)phoneNumber {
    if (phoneNumber.length == 0) {
        return phoneNumber;
    }
    NSString * tmp = phoneNumber;
    NSString * start = [tmp substringToIndex:3];
    if ([start isEqualToString:@"+86"]) {
        tmp = [tmp substringFromIndex:3];
    }
    tmp = [tmp stringByReplacingOccurrencesOfString:@" " withString:@""];
    tmp = [tmp stringByReplacingOccurrencesOfString:@"-" withString:@""];
    tmp = [tmp stringByReplacingOccurrencesOfString:@"+" withString:@""];
    
    xh(@"%@", tmp);
    return tmp;
}

#pragma mark 将电话号码中间隐藏
+ (NSString *)getPhoneNumberHideFromString:(NSString *)sourceString {
    if (![ZYProTools CheckPhoneInput:sourceString]) {
        return sourceString;
    }
    
    NSString * string = [NSString stringWithFormat:@"%@****%@", [sourceString substringToIndex:3], [sourceString substringFromIndex:7]];
    return string;
}

#pragma mark Read & Save PList File
+ (NSMutableDictionary *)readJYUserPListFile {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *plistPath1 = [paths objectAtIndex:0];
    
    //得到完整的文件名
    NSString *filename = [plistPath1 stringByAppendingPathComponent:@"JYUserList.plist"];
    
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile:filename];
    
    if (data == nil) {
        data = [self doInitFormatJYUserList];
    }
    
    return data;
}

+ (BOOL)saveJYUserPListFileWithData:(NSMutableDictionary *)data {
    //获取应用程序沙盒的Documents目录
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *plistPath1 = [paths objectAtIndex:0];
    
    //得到完整的文件名
    NSString *filename = [plistPath1 stringByAppendingPathComponent:@"JYUserList.plist"];
    
    //输入写入
    BOOL ret = [data writeToFile:filename atomically:YES];
    
    if (ret) {
        //ZYUserInfo 数据初始化
    }
    return ret;
}




+ (NSMutableDictionary *)doInitFormatJYUserList {
    NSString * plistPath = [[NSBundle mainBundle] pathForResource:@"JYUserList" ofType:@"plist"];
    NSMutableDictionary * data = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    return data;
}

#pragma mark JYKeyboard Button
+ (UIButton *)instanceKeyBoardButton {
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(SCREEN_WIDTH-78.f, SCREEN_HEIGHT, 78.f, 33.f);
    [button setBackgroundImage:[UIImage imageNamed:@"btn_keyboard_close"] forState:UIControlStateNormal];
    return button;
}

#pragma mark 时间戳确定3min的间隔
+ (BOOL)isLastStartForFiveMinutes {
    if (![__UserDefaults boolForKey:kISCanSaveTime]) {
        return YES;
    }
    
    //取当前时间的秒数
    NSTimeInterval time = [[NSDate date] timeIntervalSince1970];
    long long int date = (long long int)time;
    xh(@"当前时间date = %lld", date);
    
    //#warning - msg
    long long int distance = 3 * 60;
    
    NSString * string = [__UserDefaults objectForKey:kTimeStamp];
    long long int disdate = [string integerValue];
    //    NSInteger disdate = confromTimespStr;
    xh(@"date = %lld, disdate = %lld, distance = %lld, (distance + disdate) = %lld", date , disdate, distance, (distance + disdate));
    if (date > (distance + disdate)) {
        return YES;
    }
    
    return NO;
}

#pragma mark 保存当前的时间戳
+ (void)doSaveCurrentTime {
    NSTimeInterval time = [[NSDate date] timeIntervalSince1970];
    long long int date = (long long int)time;
    NSString * stampString = [NSString stringWithFormat:@"%lld", date];
    [__UserDefaults setObject:stampString forKey:kTimeStamp];
    xh(@"存储时间 = %@", stampString);
}

#pragma mark 处理字符串最后一个设置字体大小
+ (NSMutableAttributedString *)setStringLastWordForString:(nullable NSString *)string fontSize:(CGFloat)size {
    NSMutableAttributedString * str = [[NSMutableAttributedString alloc] initWithString:string];
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:size] range:NSMakeRange(str.length - 1, 1)];
    return str;
}

#pragma mark 设置标题（逸飞重新设置）
+ (nullable UIView *)setZYTitleLabel:(nullable NSString *)titleName fontSize:(float)size {
    if (!titleName) {
        titleName = @"详情";
    }
    if (!size) {
        size = 17.0;
    }
    CGRect tempRect = [titleName boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-40,2000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:size]}context:nil];
    UILabel *zyTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20,100, tempRect.size.width, tempRect.size.height)];
    zyTitleLabel.numberOfLines =0;
    zyTitleLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    zyTitleLabel.text = titleName;
    return (UIView *)zyTitleLabel;
}

#pragma mark iOS8.0以后设置提示框（单按钮）
+ (void)showZYSingleAlertViewWithTitle:(nullable NSString *)title Msg:(nullable NSString*)msg withBtnText:(nullable NSString *)btnTxt {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleAlert];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    //paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    paragraphStyle.alignment = NSTextAlignmentCenter;
    //行间距
    //    paragraphStyle.lineSpacing = 2.0;
    
    NSDictionary * attributes = @{NSFontAttributeName : [UIFont systemFontOfSize:17.0], NSParagraphStyleAttributeName : paragraphStyle};
    NSMutableAttributedString *attributedTitle = [[NSMutableAttributedString alloc] initWithString:msg];
    [attributedTitle addAttributes:attributes range:NSMakeRange(0, msg.length)];
    [alertController setValue:attributedTitle forKey:@"attributedMessage"];
    
    UIAlertAction *defaultAction1 = [UIAlertAction actionWithTitle:btnTxt
                                                             style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                                                                 [alertController dismissViewControllerAnimated:YES completion:nil];
                                                             }];
    
    [alertController addAction:defaultAction1];
    
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    [rootViewController presentViewController:alertController animated: YES completion: nil];
}

#pragma mark iOS8.0以后设置提示框（左右按钮）
+ (void)showZYDoublelAlertViewWithTitle:(nullable NSString *)title Msg:(nullable NSString*)msg withLeftText:(nullable NSString *)leftTxt withRightText:(nullable NSString *)rightTxt rightHandler:(void (^ __nullable)(UIAlertAction *action))rightHandler {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleAlert];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    //paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    paragraphStyle.alignment = NSTextAlignmentCenter;
    //行间距
    //    paragraphStyle.lineSpacing = 2.0;
    
    NSDictionary * attributes = @{NSFontAttributeName : [UIFont systemFontOfSize:17.0], NSParagraphStyleAttributeName : paragraphStyle};
    NSMutableAttributedString *attributedTitle = [[NSMutableAttributedString alloc] initWithString:msg];
    [attributedTitle addAttributes:attributes range:NSMakeRange(0, msg.length)];
    [alertController setValue:attributedTitle forKey:@"attributedMessage"];
    
    UIAlertAction *defaultAction1 = [UIAlertAction actionWithTitle:leftTxt
                                                             style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                                                                 [alertController dismissViewControllerAnimated:YES completion:nil];
                                                             }];
    UIAlertAction *defaultAction2 = [UIAlertAction actionWithTitle:rightTxt
                                                             style: UIAlertActionStyleDefault
                                                           handler:rightHandler];
    
    [alertController addAction:defaultAction1];
    [alertController addAction:defaultAction2];
    
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    [rootViewController presentViewController:alertController animated: YES completion: nil];
}

#pragma mark iOS8.0以后设置提示框（左右按钮） 左对齐
+ (void)showLeftAlineAlertViewWithTitle:(nullable NSString *)title Msg:(nullable NSString*)msg withLeftText:(nullable NSString *)leftTxt withRightText:(nullable NSString *)rightTxt rightHandler:(void (^ __nullable)(UIAlertAction *action))rightHandler {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleAlert];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    //paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    paragraphStyle.alignment = NSTextAlignmentLeft;
    //行间距
    paragraphStyle.lineSpacing = 2.0;
    
    NSDictionary * attributes = @{NSFontAttributeName : [UIFont systemFontOfSize:15.0], NSParagraphStyleAttributeName : paragraphStyle};
    NSMutableAttributedString *attributedTitle = [[NSMutableAttributedString alloc] initWithString:msg];
    [attributedTitle addAttributes:attributes range:NSMakeRange(0, msg.length)];
    [alertController setValue:attributedTitle forKey:@"attributedMessage"];//attributedTitle\attributedMessage
    //end ---
    
    UIAlertAction *defaultAction1 = [UIAlertAction actionWithTitle:leftTxt
                                                             style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                                                                 [alertController dismissViewControllerAnimated:YES completion:nil];
                                                             }];
    UIAlertAction *defaultAction2 = [UIAlertAction actionWithTitle:rightTxt
                                                             style: UIAlertActionStyleDefault
                                                           handler:rightHandler];
    
    [alertController addAction:defaultAction1];
    [alertController addAction:defaultAction2];
    
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    [rootViewController presentViewController:alertController animated: YES completion: nil];
}

#pragma mark iOS8.0以后设置底部提示框（底部按钮）
+ (void)showBottomAlertViewWithTitle:(nullable NSString *)title Msg:(nullable NSString*)msg cancelText:(nullable NSString *)cancelText withActionText:(nullable NSString *)actionText actionHandler:(void (^ __nullable)(UIAlertAction *action))actionHandler {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:(UIAlertControllerStyleActionSheet)];
    
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:cancelText style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
        [alert dismissViewControllerAnimated:YES completion:nil];
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:actionText style:(UIAlertActionStyleDefault) handler:actionHandler];

    [alert addAction:action1];
    [alert addAction:action2];
    
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    [rootViewController presentViewController:alert animated: YES completion: nil];
    
}

#pragma mark 获取用户唯一标示1
+(NSString*)uuid {
    CFUUIDRef puuid = CFUUIDCreate( nil );
    CFStringRef uuidString = CFUUIDCreateString( nil, puuid );
    NSString * result = (NSString *)CFBridgingRelease(CFStringCreateCopy( NULL, uuidString));
    CFRelease(puuid);
    CFRelease(uuidString);
    return result;
}
#pragma mark 获取用户唯一标示2
+ (NSString *)stringWithUUID {
    CFUUIDRef uuid = CFUUIDCreate(NULL);
    CFStringRef string = CFUUIDCreateString(NULL, uuid);
    CFRelease(uuid);
    return (__bridge_transfer NSString *)string;
}


@end
