//
//  ZYZhiFuBaoXueXiModel.h
//  ZYHaoBa
//
//  Created by 一路财富 on 2017/9/26.
//  Copyright © 2017年 正羽. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZYZhiFuBaoXueXiModel : NSObject

@property (nonatomic, copy)NSString* titleName;
@property (nonatomic, copy)NSString* pushViewName;
// 是否会push新页面
@property (nonatomic, strong)NSString* isPushNewViewStr;
@property (nonatomic, assign)BOOL isPushNewView;
//@property (nonatomic, copy)NSArray* pushDataArr;

@end
