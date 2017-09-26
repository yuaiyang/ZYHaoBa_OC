//
//  GesLoginViewController.h
//  ZYHaoBa
//
//  Created by ylcf on 16/8/12.
//  Copyright © 2016年 正羽. All rights reserved.
//

#import "ZYViewController.h"

@interface GesLoginViewController : ZYViewController


//**************传值
//当数据同步失败时，需要重新登录
@property (nonatomic, assign) BOOL isSynError;
//右侧是否需要关闭页面按钮，关闭视为退出
@property (nonatomic, assign) BOOL isNeedExit;
//登录后 是否需要Ges页面设置(用其他账号登录时，不需要设置)
@property (nonatomic, assign) BOOL isNeedGes;


@end
