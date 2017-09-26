//
//  ZYAlertView.h
//  text
//
//  Created by ylcf on 16/6/20.
//  Copyright © 2016年 ylcf. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZYAlertViewDelegate <NSObject>

- (void)sendValueOfDidClickBtn:(NSString *)str;

@end

@interface ZYAlertView : UIView

@property (nonatomic, strong)NSString * titleStr;
@property (nonatomic, strong)NSString * contentStr;
@property (nonatomic, strong)NSString * buttonStr;
@property (nonatomic, strong)UIView * subBackView;
@property (nonatomic, strong)UIView * backView;


- (id)initWithFrame:(CGRect)frame withTitleStr:(NSString *)titleStr withContentStr:(NSString *)contentStr withButtonStr:(NSString *)buttonStr;
- (void)show;//警告框展示的方法

@property(nonatomic, assign) id<ZYAlertViewDelegate> delegate;

@end
