//
//  MBImageUnlockButton.h
//  Wealth
//
//  Created by yilu on 14-3-19.
//  Copyright (c) 2014年 许可. All rights reserved.
//

#import <UIKit/UIKit.h>

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@class MBImageUnlockButton;
//定义协议，进行对应的点击与取消对应按钮时的对应操作处理
@protocol MBImageUnlockButtonDelegate <NSObject>
//定义函数，响应对应的点击按钮时的对应外部操作处理
-(void)didSelectButton:(MBImageUnlockButton *)currentButton withIndex:(int)currentIndex withSelectedStatus:(BOOL)isSelected;
//定义函数，响应对应的取消点击按钮时的对应外部操作处理
-(void)didDeselectButton:(MBImageUnlockButton *)currentButton withIndex:(int)currentIndex withSelectedStatus:(BOOL)isSelected;
@end
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface MBImageUnlockButton : UIView

//定义图片视图，进行对应的背景视图的显示处理操作
@property(nonatomic,strong)UIImageView *backGroundImageView;
//定义图片变量，进行对应的按钮未选中时对应的图片保存操作
@property(nonatomic,strong)UIImage *normalImage;
//定义图片变量，进行对应的按钮选中时对应的图片保存操作
@property(nonatomic,strong)UIImage *selectImage;
//定义尺寸变量，进行当前的对应按钮尺寸的设置处理操作，并根据对应的尺寸处理进行对应的显示更新操作
@property(nonatomic,assign)CGRect currentFrame;

//定义布尔型变量，进行对应的当前选中状态的对应保存操作，默认为假，即未选中状态，为真时为选中状态
@property(nonatomic,assign)BOOL selected;
//定义整型变量，进行当前按钮的对应索引的保存操作，进行对应的位置定位及对应的密码生成操作，默认初始值为-1
@property(nonatomic,assign)int currentIndex;
//定义手势，进行对应的点击视图时的手势，进行对应的按钮点击操作处理
@property(nonatomic,strong)UITapGestureRecognizer *tapButtonGR;
//定义代理变量，进行对应的点击与取消点击按钮时的对应操作处理
@property(nonatomic,assign)id<MBImageUnlockButtonDelegate>delegate;

//定义函数，进行对应的当前按钮的显示状态刷新操作
-(void)reloadButtonShowView;
//定义函数，进行对应的选中按钮时的对应界面显示处理操作
-(void)doSelectButton;
//定义函数，进行对应的未选中按钮的对应界面显示处理操作
-(void)doDeselectButton;
//定义函数，根据传入状态进行对应的按钮显示更新操作处理
-(void)updateButtonWithSelectSetatus:(BOOL)selected;

//定义函数，进行对应的按钮初始化操作处理，默认状态下对应的选中状态为未选中，索引值为-1，对应图片应用为默认的给定图片
- (MBImageUnlockButton *)initWithFrame:(CGRect)frame;
//定义函数，进行对应的按钮初始化操作，并在对应的初始化时设置对应的选中状态及其当前按钮的对应索引，其按钮选中状态为对应的默认选中图片
-(MBImageUnlockButton *)initWithFrame:(CGRect)frame currentTag:(int)index selectedStatus:(BOOL)isSelected;
//定义函数，进行对应的按钮初始化操作，并在对应的初始化时设置对应的选中状态及其当前按钮的对应索引，并设置对应的按钮状态图片
-(MBImageUnlockButton *)initWithFrame:(CGRect)frame normalImage:(UIImage *)normalImage selectImage:(UIImage*)selectImage currentTag:(int)index selectedStatus:(BOOL)isSelected;

@end
