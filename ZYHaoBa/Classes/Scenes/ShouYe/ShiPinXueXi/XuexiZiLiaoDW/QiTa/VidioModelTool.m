//
//  VidioModelTool.m
//  02-黑酷(XML解析)
//
//  Created by apple on 14-6-27.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "VidioModelTool.h"
#import "VidioModel.h"
//#import "GDataXMLNode.h"

@interface VidioModelTool() <NSXMLParserDelegate>
@property (nonatomic, strong) NSMutableArray *videos;
@end

@implementation VidioModelTool

- (NSArray *)parseXMLData:(NSData *)data
{
    return [self DOMparseXMLWithData:data];
}

- (NSArray *)DOMparseXMLWithData:(NSData *)data{
    return nil;
}
/*
{
    // 1.加载文档
    GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:data options:0 error:nil];
    
    // 2.获得根元素
    GDataXMLElement *root = doc.rootElement;
    
    // 3.获得所有video元素
    NSArray *elements = [root elementsForName:@"video"];
    
    // 4.将GDataXMLElement对象转成VidioModel模型
    NSMutableArray *videos = [NSMutableArray array];
    for (GDataXMLElement *ele in elements) {
        VidioModel *video = [[VidioModel alloc] init];
        video.ID = [ele attributeForName:@"id"].stringValue.intValue;
        video.length = [ele attributeForName:@"length"].stringValue.intValue;
        video.name = [ele attributeForName:@"name"].stringValue;
        video.image = [ele attributeForName:@"image"].stringValue;
        video.url = [ele attributeForName:@"url"].stringValue;
        [videos addObject:video];
    }
    return videos;
}
*/
- (NSArray *)SAXparseXMLWithData:(NSData *)data
{
    // 1.创建解析器
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:data];
    
    // 2.设置代理
    parser.delegate = self;
    
    // 3.开始解析
    [parser parse]; // 卡住(解析完毕才会返回)
    
    return self.videos;
}

- (NSArray *)parseJSONData:(NSData *)data
{
    // 解析数据
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    NSArray *array = dict[@"videos"];
    
    NSMutableArray *videos = [NSMutableArray array];
    for (NSDictionary *videoDict in array) {
        VidioModel *video = [VidioModel videoWithDict:videoDict];
        [videos addObject:video];
    }
    return videos;
}

#pragma mark NSXMLParserDelegate
/**
 *  开始解析文档时调用
 */
- (void)parserDidStartDocument:(NSXMLParser *)parser
{
    //    xh(@"parserDidStartDocument----");
}
/**
 *  结束解析文档时调用(解析完毕)
 */
- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    //    xh(@"parserDidEndDocument----");
}

/**
 *  解析到一个元素的开头时调用 <videos>
 */
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    //    xh(@"didStartElement----%@", elementName);
    if ([@"videos" isEqualToString:elementName]) { // 解析到一个videos标签
        self.videos = [NSMutableArray array];
    } else if ([@"video" isEqualToString:elementName]) { // 解析到一个video标签, 创建一个模型
        VidioModel *video = [VidioModel videoWithDict:attributeDict];
        [self.videos addObject:video];
    }
}

/**
 *  解析到一个元素的结尾时调用 </videos>
 */
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    //    xh(@"didEndElement----%@", elementName);
}

@end
