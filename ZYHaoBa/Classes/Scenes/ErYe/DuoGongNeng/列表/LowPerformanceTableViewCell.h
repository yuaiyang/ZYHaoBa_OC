//
//  LowPerformanceTableViewCell.h
//  NavigationBarTranslation
//
//  Created by Johnil on 16/2/16.
//  Copyright © 2016年 Johnil. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LowPerformanceTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *contentLabel;

+ (float)calcHeighWithString:(NSString *)str;
- (void)setContent:(NSString *)content;

@end
