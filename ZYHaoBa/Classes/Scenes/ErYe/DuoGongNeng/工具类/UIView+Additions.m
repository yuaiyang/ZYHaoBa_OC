//
//  UIView+Additions.m
//  Additions
//
//  Created by Johnil on 13-6-7.
//  Copyright (c) 2013年 Johnil. All rights reserved.
//

#import "UIView+Additions.h"

@implementation UIView (Additions)

- (void)becomeUnionResponderWithViewController:(UIViewController *)vc{
    if (![self isKindOfClass:[UIScrollView class]]) {
        return;
    }
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        UIView *view = vc.view;
        [self findAndSetUnoinResponder:view];
        [(UIScrollView *)self setScrollsToTop:YES];
        NSLog(@"设置%@的scrollsToTop为YES", self);
    });
}

- (void)becomeUnionResponderWithNavigationViewController:(UINavigationController *)navi{
    [self becomeUnionResponderWithViewController:navi.visibleViewController];
}

- (void)becomeUnionResponder{
    [self becomeUnionResponderWithViewController:[UIApplication visibleViewController]];
}

- (void)findAndSetUnoinResponder:(UIView *)view{
    for (UIScrollView *tempView in view.subviews) {
        if ([tempView isKindOfClass:[UIScrollView class]]) {
            NSLog(@"找到ScrollView:%@，并设置scrollsToTop为NO", tempView);
            tempView.scrollsToTop = NO;
        }
        [self findAndSetUnoinResponder:tempView];
    }
}

#pragma mark Frame

- (CGPoint)viewOrigin
{
    return self.frame.origin;
}

- (void)setViewOrigin:(CGPoint)newOrigin
{
    CGRect newFrame = self.frame;
    newFrame.origin = newOrigin;
    self.frame = newFrame;
}

- (CGSize)viewSize
{
    return self.frame.size;
}

- (void)setViewSize:(CGSize)newSize
{
    CGRect newFrame = self.frame;
    newFrame.size = newSize;
    self.frame = newFrame;
}


#pragma mark Frame Origin

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (void)setX:(CGFloat)newX
{
    CGRect newFrame = self.frame;
    newFrame.origin.x = newX;
    self.frame = newFrame;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (void)setY:(CGFloat)newY
{
    CGRect newFrame = self.frame;
    newFrame.origin.y = newY;
    self.frame = newFrame;
}


#pragma mark Frame Size

- (CGFloat)height
{
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)newHeight
{
    CGRect newFrame = self.frame;
    newFrame.size.height = newHeight;
    self.frame = newFrame;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)newWidth
{
    CGRect newFrame = self.frame;
    newFrame.size.width = newWidth;
    self.frame = newFrame;
}


#pragma mark Frame Borders

- (CGFloat)left
{
    return self.x;
}

- (void)setLeft:(CGFloat)left
{
    self.x = left;
}

- (CGFloat)right
{
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setRight:(CGFloat)right
{
    self.x = right - self.width;
}

- (CGFloat)top
{
    return self.y;
}

- (void)setTop:(CGFloat)top
{
    self.y = top;
}

- (CGFloat)bottom
{
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setBottom:(CGFloat)bottom
{
    self.y = bottom - self.height;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (void)setCenterX:(CGFloat)newCenterX
{
    self.center = CGPointMake(newCenterX, self.center.y);
}

- (CGFloat)centerY
{
    return self.center.y;
}

- (void)setCenterY:(CGFloat)newCenterY
{
    self.center = CGPointMake(self.center.x, newCenterY);
}


#pragma mark Middle Point

- (CGPoint)middlePoint
{
    return CGPointMake(self.middleX, self.middleY);
}

- (CGFloat)middleX
{
    return self.width / 2;
}

- (CGFloat)middleY
{
    return self.height / 2;
}

- (UIImage *)toRetinaImage{
    CGSize size = self.bounds.size;
    UIGraphicsBeginImageContextWithOptions(size, YES, 0);
    UIImage *screenShotimage;
    [self drawViewHierarchyInRect:CGRectMake(0, 0, size.width, size.height)
                   afterScreenUpdates:NO];
    screenShotimage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return screenShotimage;
}

- (void)removeAllSubviews{
    for (UIView *temp in self.subviews) {
        [temp removeFromSuperview];
    }
}

- (void)shakeX:(float)range{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    animation.duration = 0.6;
    animation.values = @[ @(-range), @(range), @(-range/2), @(range/2), @(-range/5), @(range/5), @(0) ];
    [self.layer addAnimation:animation forKey:@"shake"];
}

- (void)removeSubviewWithTag:(NSInteger)tag{
    for (UIView *temp in self.subviews) {
        if (temp.tag==tag) {
            [temp removeFromSuperview];
        }
    }
}

- (void)removeSubviewExceptTag:(NSInteger)tag{
    for (UIView *temp in self.subviews) {
        if (temp.tag!=tag) {
			if ([temp isKindOfClass:[UIImageView class]]) {
				[(UIImageView *)temp setImage:nil];
			}
            [temp removeFromSuperview];
        }
    }
}

- (void)removeSubviewExceptClass:(Class)class{
    for (UIView *temp in self.subviews) {
        if (![temp isKindOfClass:class]) {
            [temp removeFromSuperview];
        }
    }
}

- (UIView *)subviewWithTag:(NSInteger)tag{
    for (UIView *temp in self.subviews) {
        if (temp.tag==tag) {
            return temp;
        }
    }
    return nil;
}

- (UIView *)findFirstResponder{
    if (self.isFirstResponder) {
        return self;
    }
    for (UIView *subView in self.subviews) {
        UIView *temp = [subView findFirstResponder];
        if (temp!=nil) {
            return temp;
        }
    }
    return nil;
}

@end
