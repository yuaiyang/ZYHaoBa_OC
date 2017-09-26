//
//  WealthGestureUnlockView.h
//  Wealth
//
//  Created by yilu on 14-3-31.
//  Copyright (c) 2014年 许可. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBImageUnlockButton.h"

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@class MBGestureUnlockView;
//定义协议，进行对应手势结束时的对应代理处理，进行对应密码的操作
@protocol GestureUnlockViewDelegate <NSObject>

//定义函数，进行对应的手势结束时的对应调用处理操作，进行对应密码的保存或是重置操作
-(void)didFinishTouchesInView:(MBGestureUnlockView *)gestureUnlockView withCode:(NSString *)currentCodeString;

@end
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//暂不支持对应背景图片的更改及对应背景颜色的设置处理，对于其他的处理需要等到后面测试修改
@interface MBGestureUnlockView : UIView

//定义图片视图，进行对应的背景图片的设定处理操作
@property(nonatomic,strong)UIImageView *backGroundImageView;
//定义视图，进行对应的背景视图图片的保存处理操作
@property(nonatomic,strong)UIImage *backGroundImage;

//定义整型变量，进行对应的当前视图的对应横排按钮数目的获取与保存操作
@property(nonatomic,assign)int currentRowNumber;
//定义整型变量，进行对应的当前视图的对应竖排按钮数目的获取与保存操作
@property(nonatomic,assign)int currentCollumnNumber;

//定义布尔型变量，进行是否为初始化调用的判断，进而进行对应的按钮阵列的初始化操作,默认为假，当为真时减少进行按钮阵列创建的校验操作
@property(nonatomic,assign)BOOL isInit;

//定义字符串，进行当前对应的手势划过按钮组成的密码串的保存与处理操作(暂未进行加密操作，在加密后可以存储到对应的本地文件或是对应的服务端进行加密验证后进行对应的解锁或是其他处理操作)
@property(nonatomic,strong)NSString *currentCodeString;
//定义按钮，进行当前触摸的对应点的保存处理，用于将来的对应判断操作
@property(nonatomic,assign)CGPoint currentTouchesPoint;

//定义可变数组进行当前的对应按钮的存储与处理操作
@property(nonatomic,strong)NSMutableArray *buttonsArr;
//定义可变数组，进行对应的当前选中按钮的保存处理操作
@property(nonatomic,strong)NSMutableArray *selectedButtonsArr;

//定义图片，进行对应当前手势按钮未选中时对应图片的保存处理，可能根据情况为空
@property(nonatomic,strong)UIImage *buttonNormalImage;
//定义图片，进行对应当前手势按钮选中时对应图片的保存处理，可能根据情况为空
@property(nonatomic,strong)UIImage *buttonSelectImage;


//定义代理对象，进行对应的代理响应事件的调用处理
@property(nonatomic,assign)id<GestureUnlockViewDelegate>delegate;

//定义变量，进行是否能够进行手势的响应的判断处理，为假时不进行响应，为真时进行对应的响应处理,默认为真
@property(nonatomic,assign)BOOL isCanReceiveTouch;

//定义函数，进行对应视图本身的初始化操作处理
- (MBGestureUnlockView *)initWithFrame:(CGRect)frame backGroundImage:(UIImage *)backGroundImage buttonNormalImage:(UIImage *)buttonNormalImage buttonSelectImage:(UIImage *)buttonSelectImage rowNum:(int)rowNUM colNum:(int)collumnNUM;
//定义函数，进行对应的当前按钮视图的绘制显示操作
-(void)resetGestureUnlockViewWithRowNum:(int)rowNUM collumnNum:(int)collumnNum;
//定义函数，根据传入的对应密码值进行对应的按钮选中显示处理
-(void)setSelectedButtonWithCodeString:(NSString *)codeString;

@end
