//
//  ScrollContentView.m
//  PhotoPicker
//
//  Created by Johnil .
//  Copyright (c) 2016 Johnil. All rights reserved.
//

#import "ScrollContentView.h"

@implementation ScrollContentView {
    UIView *_contentView;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.clipsToBounds = YES;
    }
    return self;
}

- (void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    _contentView.frame = self.bounds;
}

- (void)setOffsetX:(float)x{
    _contentView.x = x-self.x;
}

- (void)setOffsetY:(float)y{
    _contentView.y = y-self.y;
}

- (void)addContentView:(UIView *)view{
    _contentView = view;
    _contentView.x = 0;
    [self addSubview:_contentView];
}

- (UIView *)contentView{
    return _contentView;
}

@end
