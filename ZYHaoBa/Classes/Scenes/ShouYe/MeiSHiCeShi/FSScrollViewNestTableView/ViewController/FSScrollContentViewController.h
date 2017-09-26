//
//  FSScrollContentViewController.h
//  FSScrollViewNestTableViewDemo
//
//  Created by huim on 2017/9/25.
//  Copyright © 2017年 fengshun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FSScrollContentViewController : UIViewController
@property (nonatomic, assign) BOOL vcCanScroll;
@property (nonatomic, strong) UITableView *tableView;
@end
