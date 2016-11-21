//
//  ViewController.m
//  TestForAES
//
//  Created by wujian on 2016/11/21.
//  Copyright © 2016年 wujian. All rights reserved.
//

#import "ViewController.h"
#import "NSData+AES.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSString *key = @"asdfghjklqwertyuasdfghjklqwertyu"; //因为是例子是256位加密 秘钥长度32字节 如果是128位加密 密钥长度为16字节
    NSString *iv = @"asdfghjklqwertyu"; //初始向量 16位 AES分组密码 块的长度
    
    NSString *str1 = @"I just need you!";
    NSData *data1 = [str1 dataUsingEncoding:NSUTF8StringEncoding];
    //加密
    data1 = [data1 AESEncryptWithKey:key iv:iv padding:YES];
    //解密
    NSData *data2 = [data1 AESDecryptWithKey:key iv:iv padding:YES];
    NSString *str2 = [[NSString alloc] initWithData:data2 encoding:NSUTF8StringEncoding];
    NSLog(@"str2:%@", str2);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
