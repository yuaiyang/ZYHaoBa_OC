//
//  VidioTableViewCell.m
//  ZYHaoBa
//
//  Created by ylcf on 16/10/14.
//  Copyright © 2016年 正羽. All rights reserved.
//

#import "VidioTableViewCell.h"
#import "VidioModel.h"
#import "UIImageView+WebCache.h"
#import "UIView+Extension.h"

@interface VidioTableViewCell()
@property (nonatomic, weak) UIView *divider;
@end

@implementation VidioTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"video_Cell";
    VidioTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[VidioTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIView *divider = [[UIView alloc] init];
        divider.backgroundColor = [UIColor lightGrayColor];
        divider.alpha = 0.2;
        [self.contentView addSubview:divider];
        self.divider = divider;
    }
    return self;
}

- (void)setVideo:(VidioModel *)video
{
    _video = video;
    
    self.textLabel.text = video.name;
    self.detailTextLabel.text = [NSString stringWithFormat:@"时长:%d分钟", video.length];
    
    // video.image == resources/images/minion_01.png
    NSString *imageUrl = [NSString stringWithFormat:@"http://192.168.1.200:8080/MJServer/%@", video.image];
    [self.imageView setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"placeholder"]];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 调整子控件的frame
    CGFloat imageX = 10;
    CGFloat imageY = 10;
    CGFloat imageH = self.height - 2 * imageY;
    CGFloat imageW = imageH * 200 / 112;
    self.imageView.frame = CGRectMake(imageX, imageY, imageW, imageH);
    
    //    CGRect textF = self.textLabel.frame;
    //    textF.origin.x = CGRectGetMaxX(self.imageView.frame) + 10;
    //    self.textLabel.frame = textF;
    self.textLabel.x = CGRectGetMaxX(self.imageView.frame) + 10;
    
    //    CGRect detailTextF = self.detailTextLabel.frame;
    //    detailTextF.origin.x = textF.origin.x;
    //    self.detailTextLabel.frame = detailTextF;
    self.detailTextLabel.x = self.textLabel.x;
    
    CGFloat dividerH = 1;
    CGFloat dividerY = self.height - dividerH;
    CGFloat dividerW = self.width;
    self.divider.frame = CGRectMake(0, dividerY, dividerW, dividerH);
}


@end
