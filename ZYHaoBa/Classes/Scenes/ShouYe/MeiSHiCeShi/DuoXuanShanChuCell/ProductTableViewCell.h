//
//  ProductTableViewCell.h
//  YIXiuEngineer
//
//  Created by 赵群涛 on 16/5/11.
//  Copyright © 2016年 赵群涛. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Product.h"


@interface ProductTableViewCell : UITableViewCell

@property (nonatomic,retain) UILabel *nameLabel;

@property (nonatomic, strong)UIButton *bigSelectBtn;

@property (nonatomic, strong)UILabel *lineLabel;

@property (nonatomic,assign)BOOL isSelected;


@property (nonatomic,copy)void(^cartBlock)(BOOL select);

-(void)reloadDataWith:(Product *)model;




@end
