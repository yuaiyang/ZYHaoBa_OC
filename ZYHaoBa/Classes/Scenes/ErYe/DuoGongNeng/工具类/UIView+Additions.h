//
//  UIView+Additions.h
//  Additions
//
//  Created by Johnil on 13-6-7.
//  Copyright (c) 2013年 Johnil. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Additions)

- (void)becomeUnionResponder;
- (void)becomeUnionResponderWithViewController:(UIViewController *)vc;
- (void)becomeUnionResponderWithNavigationViewController:(UINavigationController *)navi;


// Frame
@property (nonatomic) CGPoint viewOrigin;
@property (nonatomic) CGSize viewSize;

// Frame Origin
@property (nonatomic) CGFloat x;
@property (nonatomic) CGFloat y;

// Frame Size
@property (nonatomic) CGFloat width;
@property (nonatomic) CGFloat height;

// Frame Borders
@property (nonatomic) CGFloat top;
@property (nonatomic) CGFloat left;
@property (nonatomic) CGFloat bottom;
@property (nonatomic) CGFloat right;

// Center Point
#if !IS_IOS_DEVICE
@property (nonatomic) CGPoint center;
#endif
@property (nonatomic) CGFloat centerX;
@property (nonatomic) CGFloat centerY;

// Middle Point
@property (nonatomic, readonly) CGPoint middlePoint;
@property (nonatomic, readonly) CGFloat middleX;
@property (nonatomic, readonly) CGFloat middleY;

- (UIImage *)toRetinaImage;
- (void)removeAllSubviews;
- (void)removeSubviewWithTag:(NSInteger)tag;
- (void)removeSubviewExceptTag:(NSInteger)tag;
- (void)removeSubviewExceptClass:(Class)class1;
- (void)shakeX:(float)range;
- (UIView *)subviewWithTag:(NSInteger)tag;
- (UIView *)findFirstResponder;

@end
