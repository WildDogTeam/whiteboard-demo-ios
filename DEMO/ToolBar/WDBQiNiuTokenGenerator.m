//
//  WDBQiNiuTokenGenerator.m
//  testQiNiu
//
//  Created by problemchild on 2017/8/25.
//  Copyright © 2017年 freakyyang. All rights reserved.
//

#import "WDBQiNiuTokenGenerator.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonHMAC.h>
#import "QNUrlSafeBase64.h"
#import "QN_GTM_Base64.h"

@implementation WDBQiNiuTokenGenerator

+(NSString *)getTokenWithFileName:(NSString *)fileName
                         roomName:(NSString *)roomName
                        SecretKey:(NSString *)SecretKey
                        AccessKey:(NSString *)AccessKey;
{
    NSString *jsonStr  = [NSString stringWithFormat:@"{\"scope\":\"%@:%@\",\"deadline\":%ld,\"returnBody\":\"{\\\"name\\\":$(fname),\\\"size\\\":$(fsize),\\\"w\\\":$(imageInfo.width),\\\"h\\\":$(imageInfo.height),\\\"hash\\\":$(etag)}\"}",
                          roomName,fileName,(long)[[[NSDate date] dateByAddingTimeInterval:60*60*100] timeIntervalSince1970]];
    
    NSLog(@"%@",jsonStr);
    
    NSString *base64Str2 = [QNUrlSafeBase64 encodeString:jsonStr];
    
    NSString *sha1Str = [WDBQiNiuTokenGenerator Base_HmacSha1:SecretKey data:base64Str2];
    
    return [NSString stringWithFormat:@"%@:%@:%@",AccessKey,sha1Str,base64Str2];
}

//HmacSHA1加密
+(NSString *)Base_HmacSha1:(NSString *)key data:(NSString *)data{
    const char *cKey  = [key cStringUsingEncoding:NSUTF8StringEncoding];
    const char *cData = [data cStringUsingEncoding:NSUTF8StringEncoding];
    //Sha256:
    // unsigned char cHMAC[CC_SHA256_DIGEST_LENGTH];
    //CCHmac(kCCHmacAlgSHA256, cKey, strlen(cKey), cData, strlen(cData), cHMAC);
    
    //sha1
    unsigned char cHMAC[CC_SHA1_DIGEST_LENGTH];
    CCHmac(kCCHmacAlgSHA1, cKey, strlen(cKey), cData, strlen(cData), cHMAC);
    
    NSData *HMAC = [[NSData alloc] initWithBytes:cHMAC
                                          length:sizeof(cHMAC)];
    
    //将加密结果进行一次BASE64编码。
    NSString *hash = [QNUrlSafeBase64 encodeData:HMAC];
    
    return hash;
}


@end
