//
//  NSData+AES.m
//  TestForAES
//
//  Created by wujian on 2016/11/21.
//  Copyright © 2016年 wujian. All rights reserved.
//

#import "NSData+AES.h"
#import <CommonCrypto/CommonCryptor.h>

@implementation NSData (AES)

//加密
- (NSData *)AESEncryptWithKey:(NSString *)key iv:(NSString *)iv padding:(BOOL)padding
{
    return [self AESOperation:kCCEncrypt key:key iv:iv padding:padding];
}

//解密
- (NSData *)AESDecryptWithKey:(NSString *)key iv:(NSString *)iv padding:(BOOL)padding
{
    return [self AESOperation:kCCDecrypt key:key iv:iv padding:padding];
}

- (NSData *)AESOperation:(CCOperation)operation key:(NSString *)key iv:(NSString *)iv padding:(BOOL)padding
{
    //kCCKeySizeAES256 32位加密  kCCKeySizeAES128 16位加密 kCCKeySizeAES192 24位加密 这边测试的CBC模式
    char keyPtr[kCCKeySizeAES256 + 1];
    bzero(keyPtr, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    // IV
    const char *ivValue = [iv UTF8String];

    
    NSUInteger dataLength = [self length];
    const char* rawbytes=[self bytes];
    if (dataLength % kCCBlockSizeAES128 !=0 && !padding && operation == kCCEncrypt)
    {
        //padding 加密时候需要补充不完整的块
        NSMutableData*  selfdata=[self mutableCopy];
        int leftlen=kCCBlockSizeAES128-dataLength%kCCBlockSizeAES128;
        char padddata[kCCBlockSizeAES128];
        memset(padddata,0,kCCBlockSizeAES128);
        [selfdata appendBytes:padddata length:leftlen];
        rawbytes=[selfdata bytes];
        dataLength +=leftlen;
    }
    size_t bufferSize = dataLength + (padding?kCCBlockSizeAES128:0);
    void *buffer = malloc(bufferSize);

    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptorStatus = CCCrypt(operation, kCCAlgorithmAES128, padding?kCCOptionPKCS7Padding:0,
                                            keyPtr, kCCKeySizeAES256,
                                            ivValue, //初始向量
                                            rawbytes, dataLength, //输入
                                            buffer, bufferSize, //输出
                                            &numBytesEncrypted);
    
    if(cryptorStatus == kCCSuccess){
        NSLog(@"%@ Success",operation ==kCCEncrypt?@"加密":@"解密");
        return [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
    }else{
        NSLog(@"%@ Error",operation ==kCCEncrypt?@"加密":@"解密");
    }
    
    free(buffer);
    return nil;
}

@end
