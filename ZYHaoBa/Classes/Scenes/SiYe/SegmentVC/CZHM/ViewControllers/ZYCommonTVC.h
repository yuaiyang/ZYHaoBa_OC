//
//  ZYCommonTVC.h
//  ZYHaoBa
//
//  Created by ylcf on 16/8/22.
//  Copyright © 2016年 正羽. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma mark 继承自UITableViewController的基类视图
@interface ZYCommonTVC : UITableViewController


/** 创建一个可变数组作为数据源*/
- (NSMutableArray *)groups;

@end
