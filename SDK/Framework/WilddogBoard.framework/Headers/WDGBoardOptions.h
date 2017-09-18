//
//  WDGBoardOptions.h
//  WhiteBoardAPI
//
//  Created by problemchild on 2017/8/15.
//  Copyright © 2017年 FreakyYang. All rights reserved.
//

#import <UIKit/UIKit.h>

//白板设置
@interface WDGBoardOptions : NSObject

//读写权限
typedef NS_ENUM (NSInteger , WDGBoardOpthionsAuthorityMode){
    WDGBoardOpthionsAuthorityModeReadWrite,
    WDGBoardOpthionsAuthorityModeReadOnly
};
//读写权限
@property WDGBoardOpthionsAuthorityMode AuthorityMode;

//画布大小 - 会自适应填充显示
@property (nonatomic,assign) CGSize canvasSize;


/**
 *  默认设置
 */
+ (WDGBoardOptions *)defaultOptions;

@end
