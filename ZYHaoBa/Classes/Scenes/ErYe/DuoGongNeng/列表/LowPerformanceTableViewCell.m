//
//  LowPerformanceTableViewCell.m
//  NavigationBarTranslation
//
//  Created by Johnil on 16/2/16.
//  Copyright © 2016年 Johnil. All rights reserved.
//

#import "LowPerformanceTableViewCell.h"

static float kGap = 5.0;
static float kAvatarSize = 40;

@implementation LowPerformanceTableViewCell {
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

- (void)setContent:(NSString *)content{
    _contentLabel.text = content;
    [ZYHttpsTool GET:@"https://www.bing.com/HPImageArchive.aspx?format=js&idx=0&n=1&mkt=zh-CN" parameters:nil success:^(id responseObject) {
        NSArray *images = responseObject[@"images"];
        if (images&&images.count>0) {
            NSDictionary *imageDic = [images firstObject];
            NSString *url = [NSString stringWithFormat:@"https://www.bing.com/%@", imageDic[@"url"]];
            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
            UIImage *image = [UIImage imageWithData:data];
            _avatarView.image = image;
        }
    } failure:^(NSError *error) {

    }];
}

@end
