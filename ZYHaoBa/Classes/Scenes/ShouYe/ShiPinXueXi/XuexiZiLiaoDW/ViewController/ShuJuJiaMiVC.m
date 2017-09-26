//
//  ShuJuJiaMiVC.m
//  ZYHaoBa
//
//  Created by ylcf on 16/10/14.
//  Copyright © 2016年 正羽. All rights reserved.
//

#import "ShuJuJiaMiVC.h"
//加密文件
#import "NSString+Hash.h"

@interface ShuJuJiaMiVC ()

@end

@implementation ShuJuJiaMiVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *str1 = @"123";
    NSString *str2 = @"456";
    NSString *str3 = @"qwe";
    
//    202cb962ac59075b964b07152d234b70
    [self MD5JiaMi:str1];
    [self MD5JiaMi:str2];
    [self MD5JiaMi:str3];
    
//    40bd001563085fc35165329ea1ff5c5ecbdbbeef
    [self sha1StringJiaMi:str1];
    [self sha1StringJiaMi:str2];
    [self sha1StringJiaMi:str3];
    
//    a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3
    [self sha256StringJiaMi:str1];
    [self sha256StringJiaMi:str2];
    [self sha256StringJiaMi:str3];
    
//    3c9909afec25354d551dae21590bb26e38d53f2173b8d3dc3eee4c047e7ab1c1eb8b85103e3be7ba613b31bb5c9c36214dc9f14a42fd7a2fdb84856bca5c44c2
    [self sha512StringJiaMi:str1];
    [self sha512StringJiaMi:str2];
    [self sha512StringJiaMi:str3];
    
    
    NSString *str = @"3c9909afec25354d551dae21590bb26e38d53f2173b8d3dc3eee4c047e7ab1c1eb8b85103e3be7ba613b31bb5c9c36214dc9f14a42fd7a2fdb84856bca5c44c2";
    NSString *jieMi512Str = [str hmacSHA512StringWithKey:@""];
    xh(@"jieMi512Str = %@",jieMi512Str);
}



#pragma mark 加密
- (void)MD5JiaMi:(NSString *)str {
    NSString *jiaMiStr = [str md5String];
    xh(@"MD5JiaMi: str = %@,jiaMiStr = %@",str,jiaMiStr);
}

- (void)sha1StringJiaMi:(NSString *)str {
    NSString *jiaMiStr = [str sha1String];
    xh(@"sha1StringJiaMi: str = %@,jiaMiStr = %@",str,jiaMiStr);
}

- (void)sha256StringJiaMi:(NSString *)str {
    NSString *jiaMiStr = [str sha256String];
    xh(@"sha256StringJiaMi: str = %@,jiaMiStr = %@",str,jiaMiStr);
}

- (void)sha512StringJiaMi:(NSString *)str {
    NSString *jiaMiStr = [str sha512String];
    xh(@"sha512StringJiaMi: str = %@,jiaMiStr = %@",str,jiaMiStr);
}

#pragma mark 解密
- (void)MD5JieMi:(NSString *)str {
    xh(@"使用网站http://www.cmd5.com解密");
}

- (NSString *)sha1StringJieMi:(NSString *)str {
    NSString *jieMiStr = [str hmacSHA1StringWithKey:str];
    return jieMiStr;
}

- (NSString *)sha256StringJieMi:(NSString *)str {
    NSString *jieMiStr = [str hmacSHA256StringWithKey:str];
    return jieMiStr;
}

- (NSString *)sha512StringJieMi:(NSString *)str {
    NSString *jieMiStr = [str hmacSHA512StringWithKey:str];
    return jieMiStr;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
