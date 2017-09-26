//
//  UIApplication+Additions.m
//  Additions
//
//  Created by Johnil on 13-6-15.
//  Copyright (c) 2013年 Johnil. All rights reserved.
//

#import "UIApplication+Additions.h"

@implementation UIApplication (Additions)

+ (AppDelegate *)appDelegate{
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}

+ (DuoGongNengVC *)rootViewController{
    return (DuoGongNengVC *)((AppDelegate *)[[UIApplication sharedApplication] delegate]).window.rootViewController;
}

+ (UIViewController *)visibleViewController{
	UINavigationController *navi = (UINavigationController *)[UIApplication rootViewController];
	return navi.visibleViewController;
}

+ (UIViewController *)presentedViewController{
    id temp = [UIApplication rootViewController];
    if ([temp presentedViewController]) {
        return [temp presentedViewController];
    } else {
        return temp;
    }
}

@end
