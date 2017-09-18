//
//  WDBColor.h
//  WilddogBoardDemo
//
//  Created by problemchild on 2017/8/16.
//  Copyright © 2017年 FreakyYang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WDBColor : NSObject

+ (WDBColor *)colorFromUIColor:(UIColor *)color;

@property (nonatomic,assign) int      red;
@property (nonatomic,assign) int      green;
@property (nonatomic,assign) int      blue;
@property (nonatomic,assign) double   alpha;

@property (nonatomic,strong) UIColor  *UIColor;
@property (nonatomic,strong) NSString *JSColor;

@end
