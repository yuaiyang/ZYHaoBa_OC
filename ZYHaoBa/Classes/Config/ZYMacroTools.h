//
//  ZYMacroTools.h
//  ZYHaoBa
//
//  Created by ylcf on 16/9/29.
//  Copyright © 2016年 正羽. All rights reserved.
//  正羽宏定义工具类

#ifndef ZYMacroTools_h
#define ZYMacroTools_h

//推出下级页面VC名字 数据数组
#define PUSHVIEW_ZY(VCName) \
ZY##VCName * view = [[ZY##VCName alloc] init]; \
view.hidesBottomBarWhenPushed = YES; \
[self.navigationController pushViewController:view animated:YES];




#endif /* ZYMacroTools_h */
