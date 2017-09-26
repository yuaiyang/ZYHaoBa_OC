//
//  ZYErYeOneView.h
//  ZYHaoBa
//
//  Created by ylcf on 16/8/12.
//  Copyright © 2016年 正羽. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ErYeOneBlock) (NSString * string);

@interface ZYErYeOneView : UIView

@property (nonatomic, copy)ErYeOneBlock block;
@property (nonatomic, strong)NSString * urlString;


@end
