//
//  ZYDatePickerView.m
//  ZYHaoBa
//
//  Created by ylcf on 16/9/16.
//  Copyright © 2016年 正羽. All rights reserved.
//

#import "ZYDatePickerView.h"

// 起始年数
#define kStartYear 1980
// 总年数
#define kYearCount 200

@interface ZYDatePickerView()<UIPickerViewDataSource, UIPickerViewDelegate>

// 定义数据属性
// 1. 年数组
@property (strong, nonatomic) NSArray *yearList;
// 2. 月数组
@property (strong, nonatomic) NSArray *monthList;
// 3. 日数组
@property (strong, nonatomic) NSMutableArray *dayList;

// 4. 选中的年数
@property (assign, nonatomic) NSInteger selectedYear;
// 5. 选中的月数
@property (assign, nonatomic) NSInteger selectedMonth;

@end

@implementation ZYDatePickerView

/*
 1. 实例化根视图
 2. 实例化pickerView并指定代理
 3. 设置pickerView的数据源：年数组、月数组、日数组
 */

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame =frame;
        [self createDatePickerView];
    }
    return self;
}

- (void)createDatePickerView {
    // 2. 实例化pickerView
    // 提示：在使用pickerView之前，必须指定数据源
    UIPickerView *pickerView = [[UIPickerView alloc]init];
    // 指定数据源
    [pickerView setDataSource:self];
    // 指定代理
    [pickerView setDelegate:self];
    // PickerView默认是没有选中标示的
    [pickerView setShowsSelectionIndicator:YES];
    
    [self addSubview:pickerView];
    
    // 3. 初始化数据
    // 1) 年数据
    NSMutableArray *yearArray = [NSMutableArray arrayWithCapacity:kYearCount];
    for (NSInteger i = 0; i < kYearCount; i++) {
        NSString *str = [NSString stringWithFormat:@"%ld年", i + kStartYear];
        
        [yearArray addObject:str];
    }
    self.yearList = yearArray;
    
    // 2) 月数据
    NSMutableArray *monthArray = [NSMutableArray arrayWithCapacity:12];
    for (NSInteger i = 1; i <= 12; i++) {
        NSString *str = [NSString stringWithFormat:@"%ld月", (long)i];
        
        [monthArray addObject:str];
    }
    self.monthList = monthArray;
    
    // 初始化选中年、月
    self.selectedYear = 1980;
    self.selectedMonth = 1;
}

#pragma mark 私有方法
#pragma mark 判断闰年
- (BOOL)isLeapYear:(NSInteger)year
{
    // 如果年数能被4整除，同时不能被100整除
    // 能被400整除的是闰年
    return (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0);
}

#pragma mark 创建日数组
// 此方法的返回值是void，是为了不改变dayList的指针
- (void)createDayListWithYear:(NSInteger)year month:(NSInteger)month
{
    // 日数组是懒加载，需要时在创建
    if (self.dayList == nil) {
        // 在开发时尽可能要去控制NSMutableArray的容量
        self.dayList = [NSMutableArray arrayWithCapacity:31];
    } else {
        [self.dayList removeAllObjects];
    }
    
    // 初始化日数组
    /**
     年：是否是闰年
     月：大月，小月
     */
    NSInteger days = 31;
    if ([self isLeapYear:year] && month == 2) {
        // 闰年的2月
        days = 29;
    } else if (2 == month) {
        // 非闰年的2月
        days = 28;
    } else if (month == 4 || month == 6 || month == 9 || month == 11) {
        // 小月
        days = 30;
    }
    
    for (NSInteger i = 1; i <= days; i++) {
        NSString *str = [NSString stringWithFormat:@"%ld日", (long)i];
        
        [self.dayList addObject:str];
    }
}

#pragma mark PickerView的数据源方法
#pragma mark 指定列数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}

#pragma mark 指定行数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (0 == component) {
        // 年
        return self.yearList.count;
    } else if (1 == component) {
        // 月
        return self.monthList.count;
    } else {
        // 日
        // 需要创建日数组-懒加载
        [self createDayListWithYear:self.selectedYear month:self.selectedMonth];
        
        return self.dayList.count;
    }
}

#pragma mark 指定component列row行的内容
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (0 == component) {
        return self.yearList[row];
    } else if (1 == component) {
        return self.monthList[row];
    } else {
        return self.dayList[row];
    }
}

#pragma mark PickerView代理方法
/**
 component : 用户当前操作的列
 row :用户在component列选中的行
 
 这两个参数主要目的是用于数据联动操作的
 如果不需要数据联动，可以无视这两个参数
 
 如果需要知道用户在所有列中选择的信息，可以直接使用pickerView的selectedRowInComponent
 */
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    // 当用户在月份列选择数值时，需要刷新日期的数组
    self.selectedYear = [pickerView selectedRowInComponent:0] + kStartYear;
    self.selectedMonth = [pickerView selectedRowInComponent:1] + 1;
    
    if (component == 1) {
        [pickerView reloadComponent:2];
    } else if (component == 0 && self.selectedMonth == 2) {
        // 如果用户是在年列选择的数值，同时月份中的当前数值是2月，需要刷新数据
        [pickerView reloadComponent:2];
    }
    
    /*
     以下三行代码同时刷新所有数据，性能略差，但是好编写
     */
    // 取出当前选中的年
    //    self.selectedYear = [pickerView selectedRowInComponent:0] + kStartYear;
    //    self.selectedMonth = [pickerView selectedRowInComponent:1] + 1;
    //
    //    [pickerView reloadAllComponents];
    
    //    NSInteger col0Row = [pickerView selectedRowInComponent:0];
    //    NSInteger col1Row = [pickerView selectedRowInComponent:1];
    //
    //    xh(@"%d - %d", col0Row, col1Row);
}


@end
