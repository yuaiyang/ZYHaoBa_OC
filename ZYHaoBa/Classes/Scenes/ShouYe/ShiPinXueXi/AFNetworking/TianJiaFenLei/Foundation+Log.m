
/*
 * 1.所有文件的.h实际都是没用的，到项目打包编译时实际是用.m文件进行编译
 * 2.以下 load 类方法可以验证 程序一启动就加载分类 所以不需要导入头文件
 * 3.以下- (NSString *)descriptionWithLocale:(id)locale 这个方法是，一旦使用字典或者数组就会调用的方法
 */

#import <Foundation/Foundation.h>

@implementation NSDictionary (Log)


// 验证 程序一启动就加载分类
+(void)load {
    xh(@"添加分类");
}

- (NSString *)descriptionWithLocale:(id)locale
{
    NSMutableString *str = [NSMutableString string];
    
    [str appendString:@"{\n"];
    
    // 遍历字典的所有键值对
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [str appendFormat:@"\t%@ = %@,\n", key, obj];
    }];
    
    [str appendString:@"}"];
    
    // 查出最后一个,的范围
    /*
     *NSBackwardsSearch 反向查找
     */
    NSRange range = [str rangeOfString:@"," options:NSBackwardsSearch];
    // 删掉最后一个,
    [str deleteCharactersInRange:range];
    
    return str;
}
@end

@implementation NSArray (Log)
- (NSString *)descriptionWithLocale:(id)locale
{
    NSMutableString *str = [NSMutableString string];
    
    [str appendString:@"[\n"];
    
    // 遍历数组的所有元素
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [str appendFormat:@"%@,\n", obj];
    }];
    
    [str appendString:@"]"];
    
    // 查出最后一个,的范围
    NSRange range = [str rangeOfString:@"," options:NSBackwardsSearch];
    // 删掉最后一个,
    [str deleteCharactersInRange:range];
    
    return str;
}
@end
