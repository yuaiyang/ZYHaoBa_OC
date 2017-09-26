//
//  JiuGongGeModel.m
//  ZYHaoBa
//
//  Created by ylcf on 16/11/3.
//  Copyright © 2016年 正羽. All rights reserved.
//

#import "JiuGongGeModel.h"

@implementation JiuGongGeModel
// 合成指令，主动指定属性使用的成员变量名称
@synthesize image = _image;//_image可以更改为别的名字，但是以下调用的getter方法也需更改

/**
 使用KVC的注意事项
 
 1> plist中的键值名称必须与模型中的属性一致
 2> 模型中的属性可以不全部出现在plist中
 */


- (UIImage *)image
{
    if (_image == nil) {
//        这里需要优化 很多时候使用sdwebimage
        _image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.icon]]];
        //  以下适代码块用于加载本地图片
//        _image = [UIImage imageNamed:self.icon];
    }
    return _image;
}

- (instancetype)initWithDict:(NSDictionary *)dict
{
    // self 是 对象
    self = [super init];
    if (self) {
        // 用字典给属性赋值，所有与plist键值有关的方法，均在此处！
        //        self.name = dict[@"name"];
        //        self.icon = dict[@"icon"];
        
        // KVC - key value coding键值编码
        // 是一种间接修改/读取对象属性的一种方法
        // KVC 被称为 cocoa 的大招！
        // 参数：
        // 1. 数值
        // 2. 属性名称
        //        [self setValue:dict[@"name"] forKeyPath:@"name"];
        //        [self setValue:dict[@"icon"] forKeyPath:@"icon"];
        // setValuesForKeysWithDictionary本质上就是调用以上两句代码
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)appInfoWithDict:(NSDictionary *)dict
{
    // self 是 class
    return [[self alloc] initWithDict:dict];
}

+ (NSArray *)appList
{
    NSArray *array = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"apps.plist" ofType:nil]];
    
    // 创建一个临时数组
    NSMutableArray *arrayM = [NSMutableArray array];
    
    // 遍历数组，依次转换模型
    for (NSDictionary *dict in array) {
//        以下两句代码等价
//        [arrayM addObject:[JiuGongGeModel appInfoWithDict:dict]];
        [arrayM addObject:[self appInfoWithDict:dict]];
    }
    
    return arrayM;
}
@end
