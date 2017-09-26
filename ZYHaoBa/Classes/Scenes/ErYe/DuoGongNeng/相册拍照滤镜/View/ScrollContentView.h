//
//  ScrollContentView.h
//  PhotoPicker
//
//  Created by Johnil .
//  Copyright (c) 2016 Johnil. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScrollContentView : UIView

- (void)addContentView:(UIView *)contentView;
- (void)setOffsetX:(float)x;
- (void)setOffsetY:(float)y;
- (UIView *)contentView;

@end
