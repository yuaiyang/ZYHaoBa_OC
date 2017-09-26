//
//  FSBaseTopTableViewCell.m
//  FSScrollViewNestTableViewDemo
//
//  Created by huim on 2017/9/25.
//  Copyright © 2017年 fengshun. All rights reserved.
//

#import "FSBaseTopTableViewCell.h"
#import "FSLoopScrollView.h"

@interface FSBaseTopTableViewCell ()

@end
@implementation FSBaseTopTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        FSLoopScrollView *loopView = [FSLoopScrollView loopImageViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200) isHorizontal:YES];
        // 这里可以直接放网络图片
        loopView.imgResourceArr = @[@"Yosemite00.jpg",
                                    @"Yosemite01.jpg",
                                    @"Yosemite02.jpg",
                                    @"Yosemite03.jpg",
                                    @"http://img02.tooopen.com/images/20160316/tooopen_sy_156105468631.jpg"];
        loopView.tapClickBlock = ^(FSLoopScrollView *loopView){
            NSString *message = [NSString stringWithFormat:@"老%ld被点啦",(long)loopView.currentIndex+1];
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"娃啊" message:message delegate:self cancelButtonTitle:@"love you" otherButtonTitles:nil, nil];
            [alert show];
        };
        [self addSubview:loopView];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
}

@end
