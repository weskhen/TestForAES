//
//  NSData+AES.h
//  TestForAES
//
//  Created by wujian on 2016/11/21.
//  Copyright © 2016年 wujian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (AES)

//加密
- (NSData *)AESEncryptWithKey:(NSString *)key iv:(NSString *)iv padding:(BOOL)padding;
//解密
- (NSData *)AESDecryptWithKey:(NSString *)key iv:(NSString *)iv padding:(BOOL)padding;

@end
