//
//  NJCityPicker.m
//  32-键盘处理
//
//  Created by 李南江 on 14-2-9.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "NJCityPicker.h"
#import "NJProvince.h"

@interface NJCityPicker ()<UIPickerViewDataSource, UIPickerViewDelegate>
{
    NSMutableArray *_provinces;
    NSArray *_tempArray;
}

@end

@implementation NJCityPicker


+ (id)cityPicker
{
    NSArray *array = [[NSBundle mainBundle]loadNibNamed:@"NJCityPicker" owner:nil options:nil];
    return [array firstObject];
}

#pragma mark 任何对象从xib中创建完毕的时候都会调用一次
- (void)awakeFromNib
{
//    初始化数据
    NSString *path = [[NSBundle mainBundle]pathForResource:@"cities.plist" ofType:nil];
    NSArray *array = [NSArray arrayWithContentsOfFile:path];
    _provinces = [NSMutableArray arrayWithCapacity:array.count];
    
    for (NSDictionary *dict in array) {
        NJProvince *p = [NJProvince provinceWithDict:dict];
        [_provinces addObject:p];
    }
    
     NJProvince *p = _provinces[0];
    _tempArray = p.cities;
}

#pragma mark UIPickerViewDataSource
#pragma mark 有多少列
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}
#pragma mark component列有多少行
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{

    if (0 == component) {
        //        省份
        return _provinces.count;
    }else
    {
        /*
        //        城市
        // 1.获取当前第0列选中的行
        NSInteger provinceIndex = [pickerView selectedRowInComponent:0];
        // 2.取出当前选中省份对应模型
        NJProvince *province = _provinces[provinceIndex];
        return province.cities.count;
         */
        return _tempArray.count;
    }
}

#pragma mark UIPickerViewDelegate
#pragma mark component列row行显示的内容
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
        xh(@"%d - %d", component, row);
    if (0 == component) {
        //        省份
        return [_provinces[row] name];
    }else
    {
        /*
        //        城市
        // 1.获取当前第0列选中的行
        NSInteger provinceIndex = [pickerView selectedRowInComponent:0];
        // 2.取出当前选中省份对应模型
        NJProvince *province = _provinces[provinceIndex];
        NSString *cityName = province.cities[row];
        return cityName;
         */
        return _tempArray[row];
    }
}

#pragma mark component列row行被选中时调用
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    xh(@"didSelectRow");
    if (0 == component) {
        //        改变了省份
        //        1.刷新第一列（城市列），重新调用数据源和代理的相应方法获得数据
        
        
        
        
        NJProvince *province = _provinces[row];
        _tempArray = province.cities;
        
        [pickerView reloadComponent:1];
    }
    /*
    //    2.获取数据
    //        2.1.获得第0列选中的省份索引
    NSInteger provinceIndex = [pickerView selectedRowInComponent:0];
    //        2.2.根据选中的省份索引获取对应省的实例对象
    NJProvince *p = _provinces[provinceIndex];
    //        2.3.获取省份名称
    NSString *provinceName = p.name;
    
    //        2.4.获取选中城市索引
    // NSInteger cityIndex = [pickerView selectedRowInComponent:1];
    //        2.5.根据选中城市索引获取城市名称
    //NSString *cityName = p.cities[cityIndex];
    NSString *cityName = _tempArray[row];
    //    3.调用代理返回用户选中地址
    
    if ([_delegate respondsToSelector:@selector(cityPicker:province:city:)]) {
        [_delegate cityPicker:self province:provinceName city:cityName];
    }
     */
    
}
@end
