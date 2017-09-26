//
//  FSBaselineTableViewCell.m
//  FSScrollViewNestTableViewDemo
//
//  Created by huim on 2017/9/25.
//  Copyright © 2017年 fengshun. All rights reserved.
//

#import "FSBaselineTableViewCell.h"
#import "FSLoopScrollView.h"

@implementation FSBaselineTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        FSLoopScrollView *loopView = [FSLoopScrollView loopTitleViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50) isTitleView:YES titleImgArr:@[@"avatar_vgirl",@"avatar_enterprise_vip",@"avatar_vgirl",@"avatar_vgirl",@"avatar_enterprise_vip"]];
        loopView.titlesArr = @[@"这是一个简易的文字轮播1",
                               @"This is a simple text rotation2",
                               @"นี่คือการหมุนข้อความที่เรียบง่าย3",
                               @"Это простое вращение текста4",
                               @"이것은 간단한 텍스트 회전 인5"];
        loopView.tapClickBlock = ^(FSLoopScrollView *loopView){
            NSString *message = [NSString stringWithFormat:@"老%ld被点啦",(long)loopView.currentIndex+1];
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"娃啊" message:message delegate:self cancelButtonTitle:@"love you" otherButtonTitles:nil, nil];
            [alert show];
        };
        [self addSubview:loopView];
    }
    return self;
}

@end
