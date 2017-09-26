//
//  JDTableViewCell3.m
//  allinone
//
//  Created by Johnil on 16/2/25.
//  Copyright © 2016年 Johnil. All rights reserved.
//

#import "JDTableViewCell3.h"

@implementation JDTableViewCell3 {
    UIImageView *_contentImageView;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _contentImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"jd_cell3"]];
        [self.contentView addSubview:_contentImageView];
    }
    return self;
}

@end
