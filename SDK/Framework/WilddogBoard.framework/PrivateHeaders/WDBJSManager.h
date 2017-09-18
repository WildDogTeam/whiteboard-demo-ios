//
//  WDBJSManager.h
//  WilddogBoardDemo
//
//  Created by problemchild on 2017/8/16.
//  Copyright © 2017年 FreakyYang. All rights reserved.
//

#define kWDBObjectJSTypeDes_Pen      @"Path"
#define kWDBObjectJSTypeDes_Rect     @"Rect"
#define kWDBObjectJSTypeDes_Circle   @"Circle"
#define kWDBObjectJSTypeDes_Triangle @"Triangle"
#define kWDBObjectJSTypeDes_Text     @"IText"
#define kWDBObjectJSTypeDes_Image    @"Image"
#define kWDBObjectJSTypeDes_Line     @"Line"


#import <Foundation/Foundation.h>
@import WebKit;


#import "WDBCallBack.h"
#import "WDBColor.h"
#import "WDGBoardObject.h"


@interface WDBJSManager : NSObject

@property (nonatomic,strong) WKWebView *webview;

- (WKWebViewConfiguration *)setUpWebViewConfig:(WKWebViewConfiguration *)webviewConfig;

//让JS初始化画板
- (void)SetUpTheBoardWithAppID:(NSString *)appid
                          path:(NSString *)path
                        userID:(NSString *)userID
                      writeble:(BOOL)write
                    canvasWith:(CGFloat)conwidth
                  canvasHeight:(CGFloat)conheight;

//更新boardOpthion
- (void)updateBoardOptionWithcanvasWidth:(CGFloat)conwidth
                            canvasHeight:(CGFloat)conheight
                                weiteble:(BOOL)write;

//修改画布背景颜色
- (void)changeBackGroundColorWithWDColor:(WDBColor *)WDColor;

//修改画布背景图片
- (void)changeBackImageWithURL:(NSString *)url;


//清空当前页
- (void)clearCurrentPage;
//撤销
- (void)undo;
//重做
- (void)redo;

//翻页
- (void)changePage:(long)number;

#pragma mark -------tool

- (void)setToolDefault;

- (void)setToolPenWithWDColor:(WDBColor *)color Size:(float)size;

- (void)setToolLineWithWDColor:(WDBColor *)color Size:(float)size;

- (void)setToolTextWithWDColor:(WDBColor *)color Size:(float)size;

- (void)setToolRectWithWDColor:(WDBColor *)color;

- (void)setToolEmptyRectWithWDColor:(WDBColor *)color Size:(float)size;

- (void)setToolCircleWithWDColor:(WDBColor *)color;

- (void)setToolEmptyCircleWithWDColor:(WDBColor *)color Size:(float)size;

- (void)setToolTriangleWithWDColor:(WDBColor *)color;

- (void)setToolArrowWithWDColor:(WDBColor *)color Size:(float)size;


#pragma mark -------object

- (void)creatShapeWithTypeDes:(NSString *)TypeDes
                          key:(NSString *)key
                        color:(WDBColor *)color
                          Top:(double)top
                         Left:(double)left
                        Width:(double)width
                       Height:(double)height
                        Angle:(double)angle;

- (void)creatImageWithurl:(NSString *)url
                      key:(NSString *)key
                      Top:(double)top
                     Left:(double)left
                    Angle:(double)angle;

- (void)creatTextWithString:(NSString *)String
                        key:(NSString *)key
                        Top:(double)top
                       Left:(double)left
                      Angle:(double)angle;

- (void)creatLineWithPoint1:(CGPoint)point1
                     Point2:(CGPoint)point2
                        key:(NSString *)key;

- (void)updateObjectWithObjectID:(NSString *)objectID
                     jsonSetting:(NSString *)setting;

- (void)ShowObjectOnBoardWithObjectID:(NSString *)objectID;

- (void)removeObjectFromBoardWithObjectID:(NSString *)objectID;

- (void)getObjectAllPropertysWithObjectID:(NSString *)objectID
                                    Block:(void(^)(NSDictionary *allPropertys))block;

- (void)getAllShowingObjectWithBlock:(void(^)(NSArray<WDGBoardObject *>* objects,NSError *error))block;

- (void)destroyObjectFromJS:(NSString *)objectID;


#pragma mark -------event

//添加一个监听
- (void)AddObjectObserveWithKey:(NSString *)key
                        TypeDes:(NSString *)typeDes
                          block:(void(^)(WDGBoardObject *object,NSDictionary *allProperty))block;

//移除一个监听
- (void)RemoveObserveWithKey:(NSString *)key;

//移除所有监听
- (void)RemoveAllCalbacks;

@end
