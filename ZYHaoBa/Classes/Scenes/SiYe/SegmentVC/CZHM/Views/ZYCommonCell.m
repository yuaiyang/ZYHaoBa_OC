//
//  ZYCommonCell.m
//  ZYHaoBa
//
//  Created by ylcf on 16/8/22.
//  Copyright © 2016年 正羽. All rights reserved.
//

#import "ZYCommonCell.h"
#import "ZYCommonItem.h"
#import "ZYCommonArrowItem.h"
#import "ZYCommonSwitchItem.h"
#import "ZYCommonLabelItem.h"
#import "ZYCommonCenterItem.h"
#import "ZYBadgeView.h"

@interface ZYCommonCell()


/**
 *  箭头
 */
@property (strong, nonatomic) UIImageView *rightArrow;
/**
 *  开关
 */
@property (strong, nonatomic) UISwitch *rightSwitch;
/**
 *  标签
 */
@property (strong, nonatomic) UILabel *rightLabel;
/**
 *  提醒数字
 */
@property (strong, nonatomic) ZYBadgeView *bageView;

@end

@implementation ZYCommonCell


#pragma mark 懒加载右边的view
- (UIImageView *)rightArrow
{
    if (_rightArrow == nil) {
        self.rightArrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"common_icon_arrow"]];
    }
    return _rightArrow;
}

- (UISwitch *)rightSwitch
{
    if (_rightSwitch == nil) {
        self.rightSwitch = [[UISwitch alloc] init];
    }
    return _rightSwitch;
}

- (UILabel *)rightLabel
{
    if (_rightLabel == nil) {
        self.rightLabel = [[UILabel alloc] init];
        self.rightLabel.textColor = [UIColor lightGrayColor];
        self.rightLabel.font = [UIFont systemFontOfSize:13];
    }
    return _rightLabel;
}

- (ZYBadgeView *)bageView
{
    if (_bageView == nil) {
        self.bageView = [[ZYBadgeView alloc] init];
    }
    return _bageView;
}

#pragma mark 初始化
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"common_cell";
    ZYCommonCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[ZYCommonCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // 设置标题的字体
        self.textLabel.font = [UIFont boldSystemFontOfSize:15];
        self.detailTextLabel.font = [UIFont systemFontOfSize:11];
        
        // 去除cell的默认背景色
        self.backgroundColor = [UIColor clearColor];
        
        // 设置背景view
        self.backgroundView = [[UIImageView alloc] init];
        self.selectedBackgroundView = [[UIImageView alloc] init];
    }
    return self;
}

#pragma mark 调整子控件的位置
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //    if ([self.item isKindOfClass:[HMCommonCenterItem class]]) {
    //        self.textLabel.centerX = self.width * 0.5;
    //        self.textLabel.centerY = self.height * 0.5;
    //    } else {
    //        self.textLabel.x = 10;
    // 调整子标题的x
    self.detailTextLabel.x = CGRectGetMaxX(self.textLabel.frame) + 5;
    //    }
}
#pragma mark setter
- (void)setIndexPath:(NSIndexPath *)indexPath rowsInSection:(int)rows
{
    // 1.取出背景view
    UIImageView *bgView = (UIImageView *)self.backgroundView;
    UIImageView *selectedBgView = (UIImageView *)self.selectedBackgroundView;
    
    // 2.设置背景图片
    if (rows == 1) {
        bgView.image = [UIImage resizedImage:@"common_card_background"];
        selectedBgView.image = [UIImage resizedImage:@"common_card_background_highlighted"];
    } else if (indexPath.row == 0) { // 首行
        bgView.image = [UIImage resizedImage:@"common_card_top_background"];
        selectedBgView.image = [UIImage resizedImage:@"common_card_top_background_highlighted"];
    } else if (indexPath.row == rows - 1) { // 末行
        bgView.image = [UIImage resizedImage:@"common_card_bottom_background"];
        selectedBgView.image = [UIImage resizedImage:@"common_card_bottom_background_highlighted"];
    } else { // 中间
        bgView.image = [UIImage resizedImage:@"common_card_middle_background"];
        selectedBgView.image = [UIImage resizedImage:@"common_card_middle_background_highlighted"];
    }
}

- (void)setItem:(ZYCommonItem *)item
{
    _item = item;
    
    // 1.设置基本数据
    self.imageView.image = [UIImage imageNamed:item.icon];
    self.textLabel.text = item.title;
    self.detailTextLabel.text = item.subtitle;
    
    // 2.设置右边的内容
    if (item.badgeValue) { // 紧急情况：右边有提醒数字
        self.bageView.badgeValue = item.badgeValue;
        self.accessoryView = self.bageView;
    } else if ([item isKindOfClass:[ZYCommonArrowItem class]]) {
        self.accessoryView = self.rightArrow;
    } else if ([item isKindOfClass:[ZYCommonSwitchItem class]]) {
        self.accessoryView = self.rightSwitch;
    } else if ([item isKindOfClass:[ZYCommonLabelItem class]]) {
        ZYCommonLabelItem *labelItem = (ZYCommonLabelItem *)item;
        // 设置文字
        self.rightLabel.text = labelItem.text;
        // 根据文字计算尺寸
        NSDictionary *attribute = @{NSFontAttributeName:self.rightLabel.font};
        self.rightLabel.size = [labelItem.text sizeWithAttributes:attribute];
        self.accessoryView = self.rightLabel;
    } else { // 取消右边的内容
        self.accessoryView = nil;
    }
}

#pragma mark 原有方法暂不用重写
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
