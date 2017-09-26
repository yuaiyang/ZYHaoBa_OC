//
//  HighPerformanceTableViewCell.m
//  NavigationBarTranslation
//
//  Created by Johnil on 16/2/19.
//  Copyright © 2016年 Johnil. All rights reserved.
//

#import "HighPerformanceTableViewCell.h"

static float kGap = 5.0;
static float kAvatarSize = 40;

@implementation HighPerformanceTableViewCell {
    UIImageView *_avatarView;
}

+ (float)calcHeighWithString:(NSString *)str{
    float widht = [UIScreen mainScreen].bounds.size.width-(kGap+kAvatarSize+kGap);
    float height = [str boundingRectWithSize:CGSizeMake(widht, CGFLOAT_MAX)
                                     options:NSStringDrawingUsesLineFragmentOrigin| NSStringDrawingUsesFontLeading
                                  attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:16]} context:nil].size.height+kGap*2;
    return height;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _avatarView = [[UIImageView alloc] initWithFrame:CGRectMake(kGap, kGap, kAvatarSize, kAvatarSize)];
        _avatarView.layer.cornerRadius = kAvatarSize/2;
        _avatarView.clipsToBounds = YES;
        _avatarView.layer.shouldRasterize = YES;
        _avatarView.layer.rasterizationScale = [UIScreen mainScreen].scale;
        [self.contentView addSubview:_avatarView];
        
        _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(kGap+kAvatarSize+kGap, kGap, [UIScreen mainScreen].bounds.size.width-(kGap+kAvatarSize+kGap), 0)];
        _contentLabel.textColor = [UIColor blackColor];
        _contentLabel.numberOfLines = NSUIntegerMax;
        _contentLabel.font = [UIFont systemFontOfSize:16];
        [self.contentView addSubview:_contentLabel];
    }
    return self;
}

- (void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    _contentLabel.height = self.height-kGap*2;
}

- (void)setModel:(HighPerformanceModel *)model{
    _contentLabel.text = model.text;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        UIImage *image = [[DemoCache cache] objectForKey:model.avatarUrl];
        if (!image) {
            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:model.avatarUrl]];
            image = [UIImage imageWithData:data];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            _avatarView.image = image;
        });
    });
}

@end
