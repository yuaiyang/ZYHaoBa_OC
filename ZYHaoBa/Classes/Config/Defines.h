
//
//  Defines.h
//  ZYHaoBa
//
//  Created by ylcf on 16/8/11.
//  Copyright © 2016年 正羽. All rights reserved.
//  正羽使用全部接口链接

#ifndef Defines_h
#define Defines_h

#pragma mark 临时使用接口




#pragma mark 以下为正式使用接口
//接口文件
#define KURLSTRING @"https://www.tmall.com"
#define KWEBVIEWURL @"https://www.baidu.com"

#define KTTTTT @"http://open.yilucaifu.com/insurance/sdk/productList.html?customkey=ylcf"



#define KIMGURL1 @"http://b162.photo.store.qq.com/psb?/V12pbjHo2CfjEK/wdAQ.ruAI5r86ajzuUWV1usZefJBuqbwU4aQBGCl07M!/b/dOrpkGCAIgAA&bo=IANYAgAAAAABB1k!&rf=viewer_4"
#define KIMGURL2 @"http://b232.photo.store.qq.com/psb?/V12pbjHo1W6Zwo/GGME5rMV6tLGAMoB0saEAAubOQqiz6MLPB1pIHKBcSY!/b/dFCBS4qVHwAA&bo=IAMVAgAAAAABABM!&rf=viewer_4"
#define KIMGURL3 @"http://b229.photo.store.qq.com/psb?/V12pbjHo1W6Zwo/Ub.Fd6M3UT.Wt4C56J.e0xn8JW75MFNXXtMfzSrpaKQ!/b/dPhpjIgEBQAA&bo=IANYAgAAAAABAF4!&rf=viewer_4"
#define KIMGURL4 @"http://b232.photo.store.qq.com/psb?/V12pbjHo1W6Zwo/Ie8D97tl1suG4yBpJzPHUoaGmJa88uJGhkXYDypRV.E!/b/dIeJToqiHwAA&bo=IANYAgAAAAABAF4!&rf=viewer_4"

#define KDOWNLOADURL @"https://pan.baidu.com/s/1miO202G"

#pragma mark  测试网路请求必须数据（不可删）
//正式线上
//#define BASE_URL @"http://m.yilucaifu.com/YiLuCaiFuMobile/"
//测试
#define BASE_URL @"http://192.168.193.217:8680/"
// 科
//#define BASE_URL @"http://192.168.30.124:4040/YiLuCaiFuMobile/"

//* 更换手机号图形验证码（姚科）
#define ZY_NEWPHONENUMSENDIMGCODE [NSString stringWithFormat:@"%@%@",BASE_URL,@"mapi/imgCode.do"]

//* 更换手机号新手机验证码（姚科）
#define ZY_NEWPHONENUMSENDCODE [NSString stringWithFormat:@"%@%@",BASE_URL,@"mapi/reg/sendCode436.do"]


#endif /* Defines_h */
