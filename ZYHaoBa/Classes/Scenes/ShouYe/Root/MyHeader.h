//
//  MyHeader.h
//  01.QQ好友列表
//
//  Created by apple on 13-9-16.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MyHeader;



#pragma mark 定义协议
@protocol MyHeaderDelegate <NSObject>

- (void)myHeaderDidSelectedHeader:(MyHeader *)header;

@end

#pragma mark 定义接口
@interface MyHeader : UITableViewHeaderFooterView

// 定义代理
@property (weak, nonatomic) id <MyHeaderDelegate> delegate;

// 标题栏按钮
@property (weak, nonatomic) UIButton *button;
// 标题栏分组
@property (assign, nonatomic) NSInteger section;

// 是否展开折叠标记
@property (assign, nonatomic) BOOL isOpen;

@end
