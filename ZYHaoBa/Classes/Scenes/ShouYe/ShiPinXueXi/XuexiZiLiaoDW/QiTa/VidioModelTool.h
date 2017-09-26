//
//  VidioModelTool.h
//  02-黑酷(XML解析)
//
//  Created by apple on 14-6-27.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VidioModelTool : NSObject
- (NSArray *)parseXMLData:(NSData *)data;
- (NSArray *)parseJSONData:(NSData *)data;
@end
