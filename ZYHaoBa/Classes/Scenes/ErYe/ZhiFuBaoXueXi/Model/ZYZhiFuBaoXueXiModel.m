//
//  ZYZhiFuBaoXueXiModel.m
//  ZYHaoBa
//
//  Created by 一路财富 on 2017/9/26.
//  Copyright © 2017年 正羽. All rights reserved.
//

#import "ZYZhiFuBaoXueXiModel.h"

@implementation ZYZhiFuBaoXueXiModel

-(BOOL)isPushNewView {
    if ([self.isPushNewViewStr isEqualToString:@"0"] || self.isPushNewViewStr.length == 0) {
        return NO;
    }
    return YES;
}

@end
