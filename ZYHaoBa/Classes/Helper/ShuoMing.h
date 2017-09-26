//
//  ShuoMing.h
//  ZYHaoBa
//
//  Created by ylcf on 16/8/12.
//  Copyright © 2016年 正羽. All rights reserved.
//

#ifndef ShuoMing_h
#define ShuoMing_h

/*
 1.视频页将tabView设置为导航栏 主要第一页 第二页逻辑处理 可跳转二级页面 后三页类似 空白忽略
    注意：共用一个视图，跳转也是同一个视图 那么需要重新初始化
    视频，囧图跳转：网页视图
 2.图书页将tabView设置为下部滑动视图 第一页加载网页H5  第三页 可跳转请求数据 再跳转三级页面  其他页类似忽略 空白忽略
    注意：当设置有透明的地方，那么需要处理相应的frame
    备注：加载webView会出现第一次不会好好加载 出现一段空白，点击后恢复效果，貌似和navigationBar为透明有关
    主要测试一些功能：
 3.目录页
 4.我的页
    主要是框架cell重用处理，以及cell自定义模型方便维护的封装处理
 */


#endif /* ShuoMing_h */
