//
//  UsedTableViewCell.h
//  shanchucel
//
//  Created by ylcf on 16/10/20.
//  Copyright © 2016年 sgx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UsedTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *cellBtn;

@property (weak, nonatomic) IBOutlet UILabel *label1;

@property (nonatomic, copy) void(^chooseBlock)(NSIndexPath * indexPath,NSString * ID,BOOL isSelected);

@property (nonatomic, strong)NSIndexPath * index;
@property (nonatomic, strong)NSString * ID;

@end
