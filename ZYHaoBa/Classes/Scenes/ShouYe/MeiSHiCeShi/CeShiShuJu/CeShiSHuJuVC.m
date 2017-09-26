//
//  CeShiSHuJuVC.m
//  ZYHaoBa
//
//  Created by ylcf on 16/10/19.
//  Copyright © 2016年 正羽. All rights reserved.
//

#import "CeShiSHuJuVC.h"

@interface CeShiSHuJuVC ()

@property (nonatomic, strong)NSMutableString * mutableString;
@property (nonatomic, strong)NSString * string;
@property (weak, nonatomic) IBOutlet UILabel *mutableStringL;
@property (weak, nonatomic) IBOutlet UILabel *stringL;

@property (nonatomic, strong)NSMutableArray * mutableArray;
@property (nonatomic, strong)NSArray * array;

@property (weak, nonatomic) IBOutlet UILabel *mutableArrayL;
@property (weak, nonatomic) IBOutlet UILabel *arrayL;

@property (nonatomic, strong)NSMutableDictionary * mutableDictionary;
@property (nonatomic, strong)NSDictionary * dictionary;
@property (weak, nonatomic) IBOutlet UILabel *mutableDictionaryL;
@property (weak, nonatomic) IBOutlet UILabel *dictionaryL;

@property (nonatomic, strong)NSMutableSet * mutableSet;
@property (nonatomic, strong)NSSet * set;

@property (weak, nonatomic) IBOutlet UILabel *mutableSetL;
@property (weak, nonatomic) IBOutlet UILabel *setL;

@property(nonatomic, assign)NSInteger integer;
@property(nonatomic, assign)NSUInteger uinteger;

@property (weak, nonatomic) IBOutlet UILabel *integerL;
@property (weak, nonatomic) IBOutlet UILabel *uintegerL;

@property(nonatomic, assign)double double1;
@property(nonatomic, assign)long long1;
@property(nonatomic, assign)long long long2;
@property(nonatomic, assign)int int1;
@property(nonatomic, assign)float float1;
@property(nonatomic, assign)BOOL bool1;


@property (weak, nonatomic) IBOutlet UILabel *double1L;
@property (weak, nonatomic) IBOutlet UILabel *long1L;
@property (weak, nonatomic) IBOutlet UILabel *long2L;
@property (weak, nonatomic) IBOutlet UILabel *int1L;
@property (weak, nonatomic) IBOutlet UILabel *float1L;
@property (weak, nonatomic) IBOutlet UILabel *bool1L;


@property (weak, nonatomic) IBOutlet UILabel *conclusionL;

@end

@implementation CeShiSHuJuVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self SetData];
}

- (void)SetData {
    if (_mutableString) {
        self.mutableStringL.text= [@"_mutableString:" stringByAppendingString:_mutableString];
    } else {
        self.mutableStringL.text= @"_mutableString为空";
    }
    
    if (_string) {
        self.stringL.text= [@"_string" stringByAppendingString:_string];
    } else {
        self.stringL.text= @"_string为空";
    }
    
    if (_mutableArray != nil) {
        self.mutableArrayL.text = [@"_mutableArray-懒加载创建" stringByAppendingString:@"判空无效"];
    } else {
        self.mutableArrayL.text = [@"_mutableArray-懒加载创建" stringByAppendingString:@"判空有效"];
    }
    
    if (_array) {
        self.arrayL.text = [@"_array-懒加载创建" stringByAppendingString:@"判空无效"];
    } else {
        self.arrayL.text = [@"_array-懒加载创建" stringByAppendingString:@"判空有效"];
    }
    
    if (_mutableDictionary != nil) {
        self.mutableDictionaryL.text =[@"_mutableDictionary-未创建" stringByAppendingString:@"判空无效"];
    } else {
        self.mutableDictionaryL.text =[@"_mutableDictionary-未创建" stringByAppendingString:@"判空有效"];
    }
    
    if (_dictionary != nil) {
        self.dictionaryL.text =[@"_dictionary-未创建" stringByAppendingString:@"判空无效"];
    } else {
        self.dictionaryL.text =[@"_dictionary-未创建" stringByAppendingString:@"判空有效"];
    }
    
    if (_mutableSet) {
        self.mutableSetL.text =[@"_mutableSet" stringByAppendingString:@"判空无效"];
    } else {
        self.mutableSetL.text =[@"_mutableSet" stringByAppendingString:@"判空有效"];
    }
    
    if (_set) {
        self.setL.text =[@"_set" stringByAppendingString:@"判空无效"];
    } else {
        self.setL.text =[@"_set" stringByAppendingString:@"判空有效"];
    }
    
    self.integerL.text= [@"_integer:" stringByAppendingString:[NSString stringWithFormat:@"%ld",(long)_integer]];
    
    self.uintegerL.text= [@"_uinteger:" stringByAppendingString:[NSString stringWithFormat:@"%ld",(long)_uinteger]];
    
    self.double1L.text= [@"_double1:" stringByAppendingString:[NSString stringWithFormat:@"%f",_double1]];
    self.long1L.text= [@"_long1:" stringByAppendingString:[NSString stringWithFormat:@"%ld",_long1]];
    self.long2L.text= [@"_long2:" stringByAppendingString:[NSString stringWithFormat:@"%lld",_long2]];
    self.int1L.text = [@"_int1:" stringByAppendingString:[NSString stringWithFormat:@"%d",_int1]];
    self.float1L.text = [@"_float1:" stringByAppendingString:[NSString stringWithFormat:@"%f",_float1]];
    self.bool1L.text = [@"_bool1:" stringByAppendingString:[NSString stringWithFormat:@"%d",_bool1]];
    if (!_bool1) {
        xh(@"BOOL默认值为0");
    }
    
    self.conclusionL.text = @"总结：字符串拼接和其他使用，尽量做判空处理，其他基本数据类型赋值均为空,存储数据均可直接使用nil判空或者直接'！'判断";
    
}

#pragma mark - 懒加载
-(NSMutableArray *)mutableArray {
    if (!_mutableArray) {
        _mutableArray = [NSMutableArray array];
    }
    return _mutableArray;
}

-(NSArray *)array {
    if (!_array) {
        _array = [[NSArray alloc] init];
    }
    return _array;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
