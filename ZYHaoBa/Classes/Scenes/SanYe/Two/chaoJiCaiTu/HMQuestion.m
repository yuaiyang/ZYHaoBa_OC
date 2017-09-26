//
//  HMQuestion.m
//  01-超级猜图
//
//  Created by apple on 14-8-15.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "HMQuestion.h"

@implementation HMQuestion
@synthesize image = _image;

- (UIImage *)image
{
    if (_image == nil) {
        _image = [UIImage imageNamed:self.icon];
    }
    return _image;
}

// 在成员方法中，如果给self赋值，只能在initXXX方法中进行
// 语法约定：
// 1> 所有的方法首字母小写
// 2> 当单词切换的时候，单词首字母大写（驼峰法）
// 3> 类名要大写
- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dict];
        
        // 对备选按钮进行乱序，只在加载的时候，做一次乱序
        [self randamOptions];
    }
    return self;
}

+ (instancetype)questionWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

+ (NSArray *)questions
{
    NSArray *array = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"questions.plist" ofType:nil]];
    
    NSMutableArray *arrayM = [NSMutableArray array];
    for (NSDictionary *dict in array) {
        [arrayM addObject:[self questionWithDict:dict]];
    }
    
    return arrayM;
}

- (void)randamOptions
{
    // 对options数组乱序
    self.options = [self.options sortedArrayUsingComparator:^NSComparisonResult(NSString *str1, NSString *str2) {
        int seed = arc4random_uniform(2);
        
        if (seed) {
            return [str1 compare:str2];
        } else {
            return [str2 compare:str1];
        }
    }];
    NSLog(@"%@", self.options);
}

// 对象描述方法，类似于java中的toString()，便于跟踪调试的
// 建议：如果是自定义的模型，最好编写description方法，可以方便调试
- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@: %p> {answer: %@, icon: %@, title: %@, options: %@}", self.class, self, self.answer, self.icon, self.title, self.options];
}

@end
