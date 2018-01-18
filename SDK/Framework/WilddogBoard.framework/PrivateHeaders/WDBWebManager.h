//
//  WDBoardWebManager.h
//  WilddogBoardDemo
//
//  Created by problemchild on 2017/8/16.
//  Copyright © 2017年 FreakyYang. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "WDBJSManager.h"

@interface WDBWebManager : NSObject

@property (nonatomic,strong) WKWebView *webview;

@property (nonatomic,strong) WDBJSManager *JSManager;

@property (nonatomic,assign) BOOL allowUserScroll;

- (void)setUpWithSize:(CGSize)Size;

- (void)changeSize:(CGSize)Size;

- (void)setUpJSBoardWithAppID:(NSString *)AppID
                         path:(NSString *)path
                       userID:(NSString *)userID
                       Option:(WDGBoardOptions *)option;

- (void)updateBoardOptions:(WDGBoardOptions *)option;

- (void)changeBackGroundColor:(UIColor *)color;


//internal
@property (nonatomic,strong) UIScrollView *mainSCRV;
@property (nonatomic,strong) UIActivityIndicatorView *activeView;
@property (nonatomic,strong) UILabel *activeLab;

@end

