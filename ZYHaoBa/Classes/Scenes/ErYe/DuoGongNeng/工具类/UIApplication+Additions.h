//
//  UIApplication+Additions.h
//  Additions
//
//  Created by Johnil on 13-6-15.
//  Copyright (c) 2013年 Johnil. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "DuoGongNengVC.h"

@interface UIApplication (Additions)

+ (AppDelegate *)appDelegate;
+ (DuoGongNengVC *)rootViewController;
+ (UIViewController *)visibleViewController;
+ (UIViewController *)presentedViewController;

@end
