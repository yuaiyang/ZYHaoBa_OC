//
//  HighPerformanceTableViewCell.h
//  NavigationBarTranslation
//
//  Created by Johnil on 16/2/19.
//  Copyright © 2016年 Johnil. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HighPerformanceModel.h"

@interface HighPerformanceTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, weak) HighPerformanceModel *model;
+ (float)calcHeighWithString:(NSString *)str;

@end
