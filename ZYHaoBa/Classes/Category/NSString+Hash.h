//
//  NSString+Hash.h
//
//  Created by Tom Corwine on 5/30/12..
//

#import <Foundation/Foundation.h>

@interface NSString (Hash)

#pragma mark - 加密
@property (readonly) NSString *md5String;
@property (readonly) NSString *sha1String;
@property (readonly) NSString *sha256String;
@property (readonly) NSString *sha512String;
#pragma mark - 解密
- (NSString *)hmacSHA1StringWithKey:(NSString *)key;
- (NSString *)hmacSHA256StringWithKey:(NSString *)key;
- (NSString *)hmacSHA512StringWithKey:(NSString *)key;

@end
