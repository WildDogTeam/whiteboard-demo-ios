//
//  WDGBoardToolOpthions.h
//  WhiteBoardAPI
//
//  Created by problemchild on 2017/8/15.
//  Copyright © 2017年 FreakyYang. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 *  画图工具的属性
 */
@interface WDGBoardToolOptions : NSObject

//颜色 - 包括透明度
@property (nonatomic,strong) UIColor *color;

//大小 - 可用于代表粗细，字号，圆角大小
@property (nonatomic,assign) float size;

+ (WDGBoardToolOptions *)optionWithColor:(UIColor *)color;

+ (WDGBoardToolOptions *)optionWithColor:(UIColor *)color size:(float)size;


@end


