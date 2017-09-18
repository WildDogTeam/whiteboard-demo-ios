//
//  WDBQiNiuTokenGenerator.h
//  testQiNiu
//
//  Created by problemchild on 2017/8/25.
//  Copyright © 2017年 freakyyang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WDBQiNiuTokenGenerator : NSObject

+(NSString *)getTokenWithFileName:(NSString *)fileName
                         roomName:(NSString *)roomName
                        SecretKey:(NSString *)SecretKey
                        AccessKey:(NSString *)AccessKey;

@end
