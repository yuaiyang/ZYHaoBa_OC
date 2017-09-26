//
//  NJKeyboardTool.h
//  32-键盘处理
//
//  Created by 李南江 on 14-2-9.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>
@class NJKeyboardTool;

typedef enum {
    NJKeyboardToolItemTypePrevious,
    NJKeyboardToolItemTypeNext,
    NJKeyboardToolItemTypeFinish
}NJKeyboardToolItemType;


@protocol NJKeyboardToolDelegate <NSObject>

@optional
- (void)keyboardTool:(NJKeyboardTool *)tool itemClick:(NJKeyboardToolItemType)type;

@end

@interface NJKeyboardTool : UIView

@property (weak, nonatomic) IBOutlet UIBarButtonItem *previousItem;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *nextItem;

//代理
@property (nonatomic, weak)id<NJKeyboardToolDelegate> delegate;
//点击上个按钮
- (IBAction)previousClick:(UIBarButtonItem *)sender;
//点击下一个按钮
- (IBAction)nextClick:(UIBarButtonItem *)sender;
//点击完成按钮
- (IBAction)finishClick:(UIBarButtonItem *)sender;
//创建实例工厂方法
+ (instancetype)keyboardTool;
@end
