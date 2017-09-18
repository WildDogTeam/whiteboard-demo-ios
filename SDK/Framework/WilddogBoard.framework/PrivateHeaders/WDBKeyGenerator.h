//
//  WBoardKeyGenerator.h
//
//
//  Created by  on 15/4/25.
//  Copyright (c) 2015年 wilddog. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WDBKeyGenerator : NSObject

+ (NSString *)keyWithSeed:(int64_t)seed;

+ (NSString *)creatKey;

@end
