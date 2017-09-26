//
//  ZYDatePickerVC.m
//  ZYHaoBa
//
//  Created by ylcf on 16/9/16.
//  Copyright © 2016年 正羽. All rights reserved.
//

#import "ZYDatePickerVC.h"

@interface ZYDatePickerVC ()<UITextFieldDelegate>

@property (weak, nonatomic) UIDatePicker *datePicker;

@property (weak, nonatomic) UITextField *dateText;

@property (weak, nonatomic) UISegmentedControl *segment;

@end

@implementation ZYDatePickerVC

#pragma mark 创建界面
- (void)loadView
{
    // 1. 实例化视图
    self.view = [[UIView alloc]initWithFrame:[UIScreen mainScreen].applicationFrame];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    //    NSMutableArray *array = [NSMutableArray arrayWithCapacity:30];
    //    for (NSInteger i = 0; i < 30; i++) {
    //        NSString *str = [NSString stringWithFormat:@"itcat-%d", i];
    //
    //        [array addObject:str];
    //    }
    //    self.dateList = array;
    
    // 2. 实例化日期选择控件，不需要指定它的大小
    // 注释：不指定大小是因为可以用于textFiled inputView
    UIDatePicker *datePicker = [[UIDatePicker alloc]init];
    [self.view addSubview:datePicker];
    
    self.datePicker = datePicker;
    
    // 设置日期选择属性
    // 1) 设置显示模式：日期，时间，日期和时间，倒计时
    [datePicker setDatePickerMode:UIDatePickerModeDate];
    // 2) 设置区域：指定是中国地区
    //    xh(@"%@", [NSLocale availableLocaleIdentifiers]);
    [datePicker setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"zh_Hans"]];
    // 3) 增加监听方法
    [datePicker addTarget:self action:@selector(dateValueChanged:) forControlEvents:UIControlEventValueChanged];
    
    // 3. 创建选项卡控件
    NSArray *array = @[@"日期", @"日期和时间", @"时间", @"倒计时"];
    UISegmentedControl *segment = [[UISegmentedControl alloc]initWithItems:array];
    // 1) 指定大小和位置
    [segment setFrame:CGRectMake(20, 250, SCREEN_WIDTH, 44)];
    // 2) 调整选项卡样式
    [segment setSegmentedControlStyle:UISegmentedControlStyleBar];
    // 3) 添加监听方法
    [segment addTarget:self action:@selector(segmentValueChanged:) forControlEvents:UIControlEventValueChanged];
    
    [self.view addSubview:segment];
    
    self.segment = segment;
    
    // 4. 创建文本框控件
    UITextField *dateText = [[UITextField alloc]initWithFrame:CGRectMake(20, 320, 280, 44)];
    [self.view addSubview:dateText];
    // 1) 文本控件默认没有边框
    [dateText setBorderStyle:UITextBorderStyleRoundedRect];
    // 2) 文本控件默认文字是顶端对齐的，需要改为垂直居中1
    [dateText setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    // 3) 设置文本框代理，以便禁止编辑
    [dateText setDelegate:self];
    
    self.dateText = dateText;
}

#pragma mark 视图加载之后，做后续的界面处理
- (void)viewDidLoad
{
    // 调用选项卡数值切换方法
    [self.segment setSelectedSegmentIndex:0];
    [self segmentValueChanged:self.segment];
}

#pragma mark 文本框代理方法，禁止用户输入
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return NO;
}

#pragma mark 私有方法
#pragma mark 将字符串转换成NSDate，"2013-09-10"
- (NSDate *)dateFromString:(NSString *)dateString
{
    // 字符串是无法直接转换成NSDate的
    // 如果要进行日期和字符串的转换，需要借助NSDateFormatter
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    // 1) 设置日期格式
    /*
     yyyy 4位年
     MM   2位月
     dd   2位日
     HH   2位小时 - 24小时制
     mm   2位分钟
     ss   2位秒
     */
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    // 2) 转换日期
    return [formatter dateFromString:dateString];
}

#pragma mark 选项卡监听事件
- (void)segmentValueChanged:(UISegmentedControl *)segment
{
    xh(@"%d", segment.selectedSegmentIndex);
    // 根据选中的选项卡，设置日期控件的显示模式
    // 同时修改日期选择控件的默认数值
    switch (segment.selectedSegmentIndex) {
        case 0:
            self.datePicker.date = [self dateFromString:@"1990-01-01 12:30"];
            [self.datePicker setDatePickerMode:UIDatePickerModeDate];
            break;
        case 1:
            self.datePicker.date = [self dateFromString:@"2012-12-30 10:50"];
            [self.datePicker setDatePickerMode:UIDatePickerModeDateAndTime];
            break;
        case 2:
            self.datePicker.date = [self dateFromString:@"2013-09-10 15:23"];
            [self.datePicker setDatePickerMode:UIDatePickerModeTime];
            break;
        case 3:
            // 1) 设置日期选择的模式
            [self.datePicker setDatePickerMode:UIDatePickerModeCountDownTimer];
            
            // 2) 设置倒计时的时长
            // 注意：设置倒计时时长需要在确定模式之后指定
            // 倒计时的时长，以秒为单位
            [self.datePicker setCountDownDuration:10 * 60];
            
            break;
    }
    
    // 选项卡切换时，执行一次日期选择控件的数值变化方法
    [self dateValueChanged:self.datePicker];
}

#pragma mark 日期选择控件监听方法
- (void)dateValueChanged:(UIDatePicker *)datePicker
{
    /**
     1. 选择日期时，文本的格式不对
     2. 选项卡控件切换时，第一个日期没有被选中
     */
    
    xh(@"%@", datePicker.date);
    // 日期数值变化后，显示在文本控件中
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    
    // 日期格式
    switch (datePicker.datePickerMode) {
        case UIDatePickerModeDate:
            [formatter setDateFormat:@"yyyy-MM-dd"];
            break;
        case UIDatePickerModeDateAndTime:
            [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
            break;
        case UIDatePickerModeTime:
            [formatter setDateFormat:@"HH:mm"];
            break;
        case UIDatePickerModeCountDownTimer:
            [formatter setDateFormat:@"HH:mm:ss"];
            break;
    }
    
    [self.dateText setText:[formatter stringFromDate:datePicker.date]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
