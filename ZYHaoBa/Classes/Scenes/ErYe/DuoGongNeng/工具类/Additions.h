//
//  Additions.h
//  allinone
//
//  Created by Johnil on 16/2/25.
//  Copyright © 2016年 Johnil. All rights reserved.
//

#import "DemoCache.h"

#import "UIView+Additions.h"
#import "UIApplication+Additions.h"
#import "UIImage+Additions.h"
#import "UINavigationController+Additions.h"

#import "AFNetworking.h"

#define FONT(f) [UIFont systemFontOfSize:f]
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
