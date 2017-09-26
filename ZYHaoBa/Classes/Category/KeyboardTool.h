//
//  KeyboardTool.h
//  ZYHaoBa
//
//  Created by ylcf on 16/9/16.
//  Copyright © 2016年 正羽. All rights reserved.
//

#import <UIKit/UIKit.h>
@class KeyboardTool;

typedef enum
{
    kKeyboardToolButtonPrev = 0,
    kKeyboardToolButtonNext,
    kKeyboardToolButtonDone
} KeyboardToolButtonType;

#pragma mark 定义协议
@protocol KeyboardToolDelegate <NSObject>

- (void)KeyboardTool:(KeyboardTool *)keyboard buttonType:(KeyboardToolButtonType)buttonType;

@end

@interface KeyboardTool : UIToolbar

#pragma mark 定义代理
@property (weak, nonatomic) id<KeyboardToolDelegate> toolDelegate;

// 工厂方法，用于简化对象的实例化
// 工厂方法，通常与类名相同，首字母小写
// 工厂方法的参数可以使用WithXXX的格式传递
+ (id)KeyboardTool;

// 上一个按钮
@property (weak, nonatomic) IBOutlet UIBarButtonItem *prevButton;
// 下一个按钮
@property (weak, nonatomic) IBOutlet UIBarButtonItem *nextButton;

// 上一个
- (IBAction)clickPrev:(UIBarButtonItem *)sender;
// 下一个
- (IBAction)clickNext:(UIBarButtonItem *)sender;
// 完成
- (IBAction)clickDone:(UIBarButtonItem *)sender;

@end
