//
//  MBImageUnlockButton.m
//  Wealth
//
//  Created by yilu on 14-3-19.
//  Copyright (c) 2014年 许可. All rights reserved.
//

#import "MBImageUnlockButton.h"

//定义宏定义，保存对应的按钮正常状态下的对应图片
#define ImageUnlockNormalImage [UIImage imageNamed:@"ic_unlock_unpressed"]
//定义宏定义，保存对应的按钮选中状态下的对应图片
#define ImageUnlockSelectImage [UIImage imageNamed:@"ic_unlock_pressed"]

@implementation MBImageUnlockButton
#pragma mark-ViewDealtActions
//定义函数，进行对应的当前按钮的显示状态刷新操作
-(void)reloadButtonShowView
{
    //根据对应的新的按钮状态进行对应的视图更新处理
    //选中
    if(self.selected)
    {
        //设置对应的按钮图片为选中图片
        [self.backGroundImageView setImage:self.selectImage];
        
    }
    //未选中
    else if(!self.selected)
    {
        //设置对应的按钮图片为未选中图片
        [self.backGroundImageView setImage:self.normalImage];
    }
    else
    {
        xh(@"当前按钮选中状态有误，请检查对应的按钮状态!");
    }
    
    //更新视图后，进行对应的界面刷新操作
    [self reloadInputViews];
}
#pragma mark-PropertyDealtActions
//定义函数，根据传入状态进行对应的按钮显示更新操作处理
-(void)updateButtonWithSelectSetatus:(BOOL)selected
{
    //如果当前的按钮状态与设置的对应当前状态相同则直接返回
    if(selected==self.selected)
    {
        return;
    }
    //当对应的状态不同时，进行对应的显示处理操作
    else
    {
        _selected=selected;
    }
    
    //根据状态进行对应的按钮显示更新操作
    [self reloadButtonShowView];
}

//设置对应的选中状态，并进行对应的更新后的对应视图显示更新操作
-(void)setSelected:(BOOL)selected
{
    //如果当前的按钮状态与设置的对应当前状态相同则直接返回
    if(selected==self.selected)
    {
        return;
    }
    //当对应的状态不同时，进行对应的显示处理操作
    else
    {
        _selected=selected;
    }
    
    //根据对应的新的按钮状态进行对应的视图更新处理
    if(self.selected)
    {
        //当当前按钮状态为选中按钮时，调用函数，进行对应的选中按钮时的对应界面显示处理操作
        [self doSelectButton];
        
    }
    else if(!self.selected)
    {
        //当当前按钮状态为未选中状态时，调用函数，进行对应的取消选中按钮时的对应界面显示处理操作
        [self doDeselectButton];
    }
    else
    {
        xh(@"当前按钮选中状态有误，请检查对应的按钮状态!");
    }
}

//设置对应的正常状态图片
-(void)setNormalImage:(UIImage *)normalImage
{
    _normalImage=normalImage;
    
    //调用函数，进行对应的界面刷新显示操作
    [self reloadButtonShowView];
}

//设置对应的选中状态图片
-(void)setSelectImage:(UIImage *)selectImage
{
    _selectImage=selectImage;
    
    //调用函数，进行对应的界面刷新显示操作
    [self reloadButtonShowView];
}

#pragma mark-ButtonSelectActions
//定义函数，进行对应的选中按钮时的对应界面显示处理操作
-(void)doSelectButton
{
    //设置对应的按钮图片为选中图片
    [self.backGroundImageView setImage:self.selectImage];
    
    //更新视图后，进行对应的界面刷新操作
    [self reloadInputViews];
    
    //当设定对应的代理后，进行对应的选中按钮时的对应代理操作
    if(self.delegate&&[self.delegate respondsToSelector:@selector(didSelectButton:withIndex:withSelectedStatus:)])
    {
        [self.delegate didSelectButton:self withIndex:self.currentIndex withSelectedStatus:self.selected];
    }
}

//定义函数，进行对应的未选中按钮的对应界面显示处理操作
-(void)doDeselectButton
{
    //设置对应的按钮图片为未选中图片
    [self.backGroundImageView setImage:self.normalImage];
    
    //更新视图后，进行对应的界面刷新操作
    [self reloadInputViews];
    
    //当设定对应的代理后，进行对应的取消选中按钮时的对应代理操作
    if(self.delegate&&[self.delegate respondsToSelector:@selector(didDeselectButton:withIndex:withSelectedStatus:)])
    {
        [self.delegate didDeselectButton:self withIndex:self.currentIndex withSelectedStatus:self.selected];
    }
    
}
#pragma mark-TapGRDelegate
//定义函数，进行对应点击按钮图片的对应手势响应操作，进行对应的点击与未点击操作处理
-(void)doTap:(UITapGestureRecognizer *)tapGR
{
    //当点击对应的按钮时，进行对应的选中状态更改
    _selected=!_selected;
    //根据对应的新的按钮状态进行对应的视图更新处理
    if(self.selected)
    {
        //当当前按钮状态为选中按钮时，调用函数，进行对应的选中按钮时的对应界面显示处理操作
        [self doSelectButton];
        
    }
    else if(!self.selected)
    {
        //当当前按钮状态为未选中状态时，调用函数，进行对应的取消选中按钮时的对应界面显示处理操作
        [self doDeselectButton];
    }
    else
    {
        xh(@"当前按钮选中状态有误，请检查对应的按钮状态!");
    }
    
}
#pragma mark-InitAction

//定义函数，进行对应的按钮初始化操作处理，默认状态下对应的选中状态为未选中，索引值为-1，对应图片应用为默认的给定图片
- (MBImageUnlockButton *)initWithFrame:(CGRect)frame
{
    //进行对应的按钮初始化，并将对应的尺寸值保存在对应的尺寸变量中
    self=(MBImageUnlockButton *)[super initWithFrame:frame];
    //将对应的frame赋值到对应的本地变量
    self.currentFrame=frame;
    if (self)
    {
        //将本按钮视图的交互打开
        self.userInteractionEnabled=YES;
        
        //初始化对应的按钮背景视图
        self.backGroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.currentFrame.size.width, self.currentFrame.size.height)];
        self.backGroundImageView.backgroundColor = [UIColor clearColor];
        self.backGroundImageView.userInteractionEnabled = YES;
        [self.backGroundImageView setImage:ImageUnlockNormalImage];
        
        //初始化对应的点击手势，并将其添加到对应的背景视图上
        self.tapButtonGR=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(doTap:)];
        [self.backGroundImageView addGestureRecognizer:self.tapButtonGR];
        
        //保存对应的按钮状态图片
        _normalImage = ImageUnlockNormalImage;
        _selectImage = ImageUnlockSelectImage;
        
        //初始时将对应的当前索引设置为-1
        self.currentIndex = -1;
        
        //初始时，设置对应的按钮选中状态为no，即不选中状态
        _selected = NO;
        
        //在界面显示后进行对应的界面刷新显示操作
        [self reloadButtonShowView];
        
        //将对应的背景视图添加到按钮视图上
        [self addSubview:self.backGroundImageView];
    }
    return self;
}

//定义函数，进行对应的按钮初始化操作，并在对应的初始化时设置对应的选中状态及其当前按钮的对应索引，其按钮选中状态为对应的默认选中图片
-(MBImageUnlockButton *)initWithFrame:(CGRect)frame currentTag:(int)index selectedStatus:(BOOL)isSelected
{
    //进行对应的按钮初始化，并将对应的尺寸值保存在对应的尺寸变量中
    self=[(MBImageUnlockButton *)[MBImageUnlockButton alloc]init];
    self.frame=frame;
    self.currentFrame=frame;

    if(self)
    {
        //将本按钮视图的交互打开
        self.userInteractionEnabled=YES;
        
        //初始化对应的按钮背景视图
        self.backGroundImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.currentFrame.size.width, self.currentFrame.size.height)];
        self.backGroundImageView.backgroundColor=[UIColor clearColor];
        self.backGroundImageView.userInteractionEnabled=YES;
        [self.backGroundImageView setImage:ImageUnlockNormalImage];
        
        //初始化对应的点击手势，并将其添加到对应的背景视图上
        self.tapButtonGR=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(doTap:)];
        [self.backGroundImageView addGestureRecognizer:self.tapButtonGR];
        
        //保存对应的按钮状态图片
        _normalImage=ImageUnlockNormalImage;
        _selectImage=ImageUnlockSelectImage;
        
        //初始时将对应的当前索引设置为传入参数
        self.currentIndex=index;
        
        //初始时，设置对应的按钮选中状态为传入参数
        _selected=isSelected;
        
        //在界面显示后进行对应的界面刷新显示操作
        [self reloadButtonShowView];
        
        //将对应的背景视图添加到按钮视图上
        [self addSubview:self.backGroundImageView];
    }
    return self;
}

//定义函数，进行对应的按钮初始化操作，并在对应的初始化时设置对应的选中状态及其当前按钮的对应索引，并设置对应的按钮状态图片
-(MBImageUnlockButton *)initWithFrame:(CGRect)frame normalImage:(UIImage *)normalImage selectImage:(UIImage*)selectImage currentTag:(int)index selectedStatus:(BOOL)isSelected
{
    //进行对应的按钮初始化，并将对应的尺寸值保存在对应的尺寸变量中
    self=[(MBImageUnlockButton *)[MBImageUnlockButton alloc]init];
    self.frame=frame;
    self.currentFrame=frame;
    
    if(self)
    {
        //进行当前图片的对应保存操作
        //未选中图片
        //当传入的按钮图片为空时进行对应默认图片的保存处理
        if(normalImage==nil)
        {
            _normalImage=ImageUnlockNormalImage;
        }
        //当不为空时进行对应图片的设置处理
        else
        {
            _normalImage=normalImage;
        }
        
        //选中图片
        //当传入的按钮图片为空时进行对应默认图片的保存处理
        if(selectImage==nil)
        {
            _selectImage=ImageUnlockSelectImage;
        }
        //当不为空时进行对应图片的设置处理
        else
        {
            _selectImage=selectImage;
        }
        
        //将本按钮视图的交互打开
        self.userInteractionEnabled=YES;
        
        //初始化对应的按钮背景视图
        self.backGroundImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.currentFrame.size.width, self.currentFrame.size.height)];
        self.backGroundImageView.backgroundColor=[UIColor clearColor];
        self.backGroundImageView.userInteractionEnabled=YES;
        [self.backGroundImageView setImage:self.normalImage];
        
        //初始化对应的点击手势，并将其添加到对应的背景视图上
        self.tapButtonGR=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(doTap:)];
        [self.backGroundImageView addGestureRecognizer:self.tapButtonGR];
        
        //初始时将对应的当前索引设置为传入参数
        self.currentIndex=index;
        
        //初始时，设置对应的按钮选中状态为传入参数
        _selected=isSelected;
        
        //在界面显示后进行对应的界面刷新显示操作
        [self reloadButtonShowView];
        
        //将对应的背景视图添加到按钮视图上
        [self addSubview:self.backGroundImageView];
    }
    return self;
}



@end
