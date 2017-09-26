//
//  JPCLViewController.m
//  ZYHaoBa
//
//  Created by ylcf on 16/9/17.
//  Copyright © 2016年 正羽. All rights reserved.
//

#import "JPCLViewController.h"
#import "NJProvince.h"
#import "NJKeyboardTool.h"
#import "NJSexBox.h"
#import "NJCityPicker.h"

@interface JPCLViewController ()<UITextFieldDelegate, NJCityPickerDelegate, NJKeyboardToolDelegate>
{
    NSMutableArray *_fields; // 所有的文本输入框
    UITextField *_focusedField;// 当前聚焦的文本框
    NJKeyboardTool *_keyboardTool;
}
//姓名
@property (weak, nonatomic) IBOutlet UITextField *nameField;

//电话
@property (weak, nonatomic) IBOutlet UITextField *phoneField;
//生日
@property (weak, nonatomic) IBOutlet UITextField *birthdayField;
//地址
@property (weak, nonatomic) IBOutlet UITextField *addressField;


@end

@implementation JPCLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    //    1.添加性别选择控件
    [self addSexBox];
    //    2.设置键盘
    [self settingKeyboard];
    //    3.处理所有文本输入框
    [self dealFields];
    //    4.监听系统发出的键盘通知
    [self addKeyboardNote];
}
#pragma mark 添加性别选择控件
- (void)addSexBox
{
    //    1.创建性别键盘
    NJSexBox *sexBox = [NJSexBox sexBox];
    sexBox.center = CGPointMake(190, 120);
    [self.view addSubview:sexBox];
}
#pragma mark 设置键盘
- (void)settingKeyboard
{
    //    1.创建生日键盘
    UIDatePicker *datePicker = [[UIDatePicker alloc]init];
    datePicker.datePickerMode = UIDatePickerModeDate;
    datePicker.locale = [NSLocale localeWithLocaleIdentifier:@"zh_CN"];
    [datePicker addTarget:self action:@selector(datePickerChanged:) forControlEvents:UIControlEventValueChanged];
    _birthdayField.inputView = datePicker;
    _birthdayField.delegate = self;
    
    //    2.创建城市键盘
    NJCityPicker *cityPicker = [NJCityPicker cityPicker];
    cityPicker.delegate = self;
    _addressField.inputView = cityPicker;
}
#pragma mark 处理所有文本输入框
- (void)dealFields
{
    // 1.初始化数组
    _fields = [NSMutableArray array];
    // 2.创建键盘工具条
    NJKeyboardTool *keyboardTool = [NJKeyboardTool keyboardTool];
    keyboardTool.delegate = self;
    //    3.递归遍历找出所有的文本框控件
    NSArray *subViews = self.view.subviews;
    for (UIView *view in subViews) {
        if ([view isKindOfClass:[UITextField class]]){
            // 如果是文本输入框设置工具条
            UITextField *field = (UITextField *)view;
            field.inputAccessoryView = keyboardTool;
            // 设置代理
            field.delegate = self;
            //            保存文本输入框
            [_fields addObject:field];
        }
    }
    
    // 4.对所有的文本框控件进行排序
    [_fields sortUsingComparator:^NSComparisonResult(UITextField * obj1, UITextField * obj2) {
        /*
         NSOrderedAscending = -1L, // 右边的对象排后面
         NSOrderedSame, // 一样
         NSOrderedDescending // 左边的对象排后面
         */
        CGFloat obj1Y = obj1.frame.origin.y;
        CGFloat obj2Y = obj2.frame.origin.y;
        
        if (obj1Y > obj2Y) {
            return NSOrderedDescending;
        }else
        {
            return NSOrderedAscending;
        }
    }];
    
    _keyboardTool = keyboardTool;
}
#pragma mark 监听系统发出的键盘通知
- (void)addKeyboardNote
{
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    // 1.显示键盘
    [center addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    // 2.隐藏键盘
    [center addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark 当前控制器销毁时调用
- (void)dealloc
{
    //    移除监听通知
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

#pragma mark 显示键盘
- (void)keyboardWillShow:(NSNotification *)notification
{
    //    1.获取键盘弹出时间（注意只有第一次有）
    CGFloat duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    if (duration <= 0) {
        duration = 0.25;
    }
    
    //    2.获取键盘的Y值
    //    2.1.获取键盘的frame
    NSValue *value = notification.userInfo[UIKeyboardFrameEndUserInfoKey];
    CGRect rect = [value CGRectValue];
    //    2.2.计算键盘的Y值
    //    键盘的Y值 ＝ 屏幕的高 - 键盘的高
    CGFloat keyboardY = self.view.frame.size.height - rect.size.height;
    //    3.获得当前聚焦文本框最下面的Y值
    CGFloat fieldY = CGRectGetMaxY(_focusedField.frame);
    
    //    4.比较聚焦文本框和键盘的Y值，如果文本框的Y值大于键盘的Y值，说明挡住了
    if (fieldY > keyboardY) {
        xh(@"挡住了");
        [UIView animateWithDuration:duration animations:^{
            //            计算需要移动的距离
            CGFloat y = keyboardY - fieldY - 10;
            self.view.transform = CGAffineTransformMakeTranslation(0, y);
        }];
    }else
    {
        xh(@"没有挡住");
        [UIView animateWithDuration:duration animations:^{
            self.view.transform = CGAffineTransformIdentity;
        }];
    }
}
#pragma mark 隐藏键盘
- (void)keyboardWillHide:(NSNotification *)notification
{
    //    1.获取键盘弹出时间
    CGFloat duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    //    2.恢复所有形变
    [UIView animateWithDuration:duration animations:^{
        self.view.transform = CGAffineTransformIdentity;
    }];
}

#pragma mark NJCityPickerDelegate
#pragma mark 城市选择回调
- (void)cityPicker:(NJCityPicker *)cityPicker province:(NSString *)province city:(NSString *)city
{
    //    设置城市数据
    _addressField.text = [NSString stringWithFormat:@"%@ -%@", province, city];
}

#pragma mark NJKeyboardToolDelegate
#pragma mark 自定义键盘工具条回调
- (void)keyboardTool:(NJKeyboardTool *)tool itemClick:(NJKeyboardToolItemType)type
{
    //    1.判断是否点击完成按钮
    if (NJKeyboardToolItemTypeFinish == type) {
        //        点击完成按钮，退出键盘
        [self.view endEditing:YES];
    }else
    {
        //        2.点击上一步下一步
        //        2.1获得当前文本框索引
        NSInteger index = [_fields indexOfObject:_focusedField];
        if (NJKeyboardToolItemTypePrevious == type) {
            //            2.2击上一个
            index--;
        }else if (NJKeyboardToolItemTypeNext == type)
        {
            //            2.3点击下一个
            index++;
        }
        //        3设置第一响应者
        UITextField *field = _fields[index];
        [field becomeFirstResponder];
    }
    
}

#pragma mark Actions
#pragma mark 时间改变
- (void)datePickerChanged:(UIDatePicker *)picker
{
    //    xh(@"%@", picker.date);
    NSDateFormatter *formatter = [[NSDateFormatter  alloc]init];
    formatter.dateFormat = @"yyyy-MM-dd";
    NSString *date = [formatter stringFromDate:picker.date];
    
    _birthdayField.text = date;
}

#pragma mark UITextFieldDelegate
#pragma mark 每当用户输入文字的时候就会调用这个方法，返回NO，禁止输入；但会YES，允许输入
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    //    生日和城市不允许键盘输入
    return (textField != _addressField) || (textField != _birthdayField);
}
#pragma mark 返回NO，代表不能聚焦（不能弹出键盘）
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}
#pragma mark 当文本框开始编辑的时候调用---开始聚焦
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    //    记录当前聚焦文本框
    _focusedField = textField;
    // 判断当前聚焦的文本框是否为最前面或者最后面的文本框
    NSInteger index = [_fields indexOfObject:textField];
    // 如果不是第0个文本框，“上一个”可以被点击
    _keyboardTool.previousItem.enabled = (index != 0);
    // 如果不是最后一个文本框，“下一个”可以被点击
    _keyboardTool.nextItem.enabled = (index != _fields.count - 1);
}

#pragma mark UIResponder
#pragma mark 手指开始触摸时调用，不用掌握
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //    关闭键盘
    [self.view endEditing:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
