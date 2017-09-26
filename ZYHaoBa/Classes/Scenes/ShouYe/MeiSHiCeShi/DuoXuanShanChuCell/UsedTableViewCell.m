//
//  UsedTableViewCell.m
//  shanchucel
//
//  Created by ylcf on 16/10/20.
//  Copyright © 2016年 sgx. All rights reserved.
//

#import "UsedTableViewCell.h"

@implementation UsedTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)chooseBtn:(UIButton *)sender {
    sender.selected = !sender.selected;
    self.chooseBlock(self.index,self.label1.text,sender.selected);
}
@end
