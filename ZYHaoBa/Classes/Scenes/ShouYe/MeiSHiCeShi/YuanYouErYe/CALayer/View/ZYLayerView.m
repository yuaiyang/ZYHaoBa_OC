//
//  ZYLayerView.m
//  ZYHaoBa
//
//  Created by ylcf on 16/8/23.
//  Copyright © 2016年 正羽. All rights reserved.
//

#import "ZYLayerView.h"

@interface ZYLayerView()

@property (nonatomic, strong)UIView * customView;
@property (nonatomic, strong)UIView * customView1;
@property (nonatomic, strong)UIImageView * imgView;

@end

@implementation ZYLayerView

-(instancetype)initWithFrame:(CGRect)frame {
    if ([super initWithFrame:frame]) {
        self.backgroundColor = [UIColor grayColor];
        /** 图层 imagView视图*/
        [self test3];
    }
    return self;
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    /** 图层 view设置图片*/
    [self test1];
    /** 图层 设置阴影*/
    [self test2];
    /** 图层 imagView视图动画偏移*/
    [self test4];
    /** 图层 imagView视图动画旋转*/
    [self test5];
#warning - 为什么不能同时旋转，缩放111111111
    /** 图层 imagView视图动画缩放*/
//    [self test6];
    /** 自定义图层*/
    [self test7];
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    layer.superlayer
}

- (void)test1 {
    self.customView.frame = CGRectMake(50, 20, 100, 100);
    _customView.backgroundColor = [UIColor orangeColor];
    _customView.layer.borderWidth = 3.0;//设置边框宽度
    _customView.layer.borderColor = [UIColor redColor].CGColor;//设置边框颜色
    _customView.layer.cornerRadius = 10;//设置边框圆角
    
    /** 设置图片 会有超出部分 contents属性设置其他id类型就可以*/
    _customView.layer.contents = (id)[UIImage imageNamed:@"test"].CGImage;
    /** 设置超出主图层部分去掉*/
    _customView.clipsToBounds = YES;
//    _customView.layer.masksToBounds = YES;
    
    [self addSubview:_customView];
}

- (void)test2 {
    self.customView1.frame = CGRectMake(75, 150, 100, 100);
    _customView1.backgroundColor = [UIColor orangeColor];
    _customView1.layer.borderWidth = 3.0;//设置边框宽度
    _customView1.layer.borderColor = [UIColor redColor].CGColor;//设置边框颜色
    _customView1.layer.cornerRadius = 10;//设置边框圆角
    
    _customView1.layer.shadowColor = [UIColor purpleColor].CGColor;// 设置阴影颜色
    _customView1.layer.shadowOffset = CGSizeMake(10, 10);// 设置阴影偏移距离
    _customView1.layer.shadowOpacity = 1;// 设置阴影透明度
    
    [self addSubview:_customView1];
}

- (void)test3 {
    self.imgView.frame = CGRectMake(100, 300, 100, 100);
    _imgView.image = [UIImage imageNamed:@"test"];
    _imgView.backgroundColor = [UIColor orangeColor];
    
    _imgView.layer.backgroundColor = [UIColor yellowColor].CGColor;
    _imgView.layer.borderWidth = 3.0;//设置边框宽度
    _imgView.layer.borderColor = [UIColor redColor].CGColor;//设置边框颜色
    _imgView.layer.cornerRadius = 10;//设置边框圆角
    /** 设置超出主图层部分去掉*/
    _imgView.clipsToBounds = YES;
    _imgView.layer.masksToBounds = YES;
    
    [self addSubview:_imgView];
}

- (void)test4 {
//    _imgView.transform = CGAffineTransformMakeTranslation(50, 100);//设置偏移x，y值
//    _imgView.layer.transform = CATransform3DMakeTranslation(100, 0, 1);//设置偏移x，y,z值 z值没有作用 原因手机为平面视图
    
    /** 使用kvc赋值操作*/
//    NSValue * value = [NSValue valueWithCATransform3D:CATransform3DMakeTranslation(100, 10, 1)];
//    [_imgView.layer setValue:value forKeyPath:@"transform"];

    [_imgView.layer setValue:@(100) forKeyPath:@"transform.translation.x"];//key值查看API可知 eg：搜索CATransform3D Key Paths即可找到相应key （步骤：help-API-seach）
}

- (void)test5 {
    /** y值可以任意设定 在手机平面视图上没有作用*/
//    _imgView.transform = CGAffineTransformMakeRotation(M_PI_4);
//    _imgView.layer.transform = CATransform3DMakeRotation(M_PI_4, 1, 1, 0);
    
//    [_imgView.layer setValue:[NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI_4, 0, 0, 2)] forKey:@"transform"];
    
    [_imgView.layer setValue:@(M_PI_4) forKeyPath:@"transform.rotation.z"];
    
}

- (void)test6 {
//    _imgView.transform = CGAffineTransformMakeScale(0.5, 0.5);// 缩放大小比例
    _imgView.layer.transform = CATransform3DMakeScale(1.5, 1.5, 1);
    
}

- (void)test7 {
    //    CALayer * layer = [[CALayer alloc] init];
    CALayer * layer = [CALayer layer];
    layer.backgroundColor = [UIColor redColor].CGColor;
    layer.bounds = CGRectMake(0, 0, 100, 100);
    layer.position = CGPointMake(250, 200);// 锚点 相当于view的center 默认 0.5 0.5（相对本身bounds）
    layer.borderWidth = 10;
    layer.cornerRadius = 10;
    [self.layer addSublayer:layer];
}

#pragma mark lazy
-(UIView *)customView {
    if (!_customView) {
        _customView = [[UIView alloc] init];
    }
    return _customView;
}

-(UIView *)customView1 {
    if (!_customView1) {
        _customView1 = [[UIView alloc] init];
    }
    return _customView1;
}

-(UIImageView *)imgView {
    if (!_imgView) {
        _imgView = [[UIImageView alloc] init];
    }
    return _imgView;
}

@end
