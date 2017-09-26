//
//  ZYCommonCell.h
//  ZYHaoBa
//
//  Created by ylcf on 16/8/22.
//  Copyright © 2016年 正羽. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZYCommonItem;

@interface ZYCommonCell : UITableViewCell


+ (instancetype)cellWithTableView:(UITableView *)tableView;
- (void)setIndexPath:(NSIndexPath *)indexPath rowsInSection:(int)rows;

/** cell对应的item数据 */
@property (nonatomic, strong) ZYCommonItem *item;

@end
