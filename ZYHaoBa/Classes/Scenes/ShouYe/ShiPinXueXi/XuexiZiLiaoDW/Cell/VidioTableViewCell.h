//
//  VidioTableViewCell.h
//  ZYHaoBa
//
//  Created by ylcf on 16/10/14.
//  Copyright © 2016年 正羽. All rights reserved.
//

#import <UIKit/UIKit.h>
@class VidioModel;

@interface VidioTableViewCell : UITableViewCell

@property (nonatomic, strong) VidioModel *video;
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
