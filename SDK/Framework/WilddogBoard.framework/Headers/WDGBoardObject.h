//
//  WDGBoardObject.h
//  WhiteBoardAPI
//
//  Created by problemchild on 2017/8/15.
//  Copyright © 2017年 FreakyYang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WDGBoard.h"


@interface WDGBoardObject : NSObject

#pragma mark --------属性

//元素类型
typedef NS_ENUM(NSInteger, WDGBoardObjectType){
    WDGBoardObjectTypePen,
    WDGBoardObjectTypeLine,
    WDGBoardObjectTypeRect,
    WDGBoardObjectTypeTriangle,
    WDGBoardObjectTypeCricle,
    WDGBoardObjectTypeText,
    WDGBoardObjectTypeImage
};

//ID
@property (nonatomic,strong) NSString *ObjectID;

//创作者
@property (nonatomic,strong) NSString *userID;

//类型
@property (nonatomic,assign) WDGBoardObjectType ObjectType;

//颜色 - 包括透明度
@property (nonatomic,strong) UIColor *color;

//元素中心点离画板顶部的距离
@property (nonatomic,assign) double top;

//元素中心点离画板左边的距离
@property (nonatomic,assign) double left;

//元素宽度
@property (nonatomic,assign) double width;

//元素高度
@property (nonatomic,assign) double height;

//旋转角度-绕元素中心点旋转
@property (nonatomic,assign) double angle;

//画笔粗细、字体大小
@property (nonatomic,assign) double size;

//内容 -- url 或 text
@property (nonatomic,strong) NSString *data;

#pragma mark --------操作

/**
 *  添加到board上显示
 */
- (void)showOnBoard;

/**
 *  从board上移除显示
 */
- (void)RemoveFromBoard;

/**
 *  获取所有可调节参数，以及目当前的值
 *
 *  @param block 回调
 */
- (void)getAllPropertysWithBlock:(void(^)(NSDictionary *propertysDictionary))block;


/**
 *  设置更多可调节参数
 *
 *  @param settingDic 回调
 */
- (void)setPropertyWithDictionary:(NSDictionary *)settingDic;


#pragma mark --------生成

/**
 *  生成一个长方形元素
 *  @param board 画板
 *  @return 元素Object
 */
+ (WDGBoardObject *)creatRectObjectFromBoard:(WDGBoard *)board;

/**
 *  生成一个圆形元素
 *  @param board 画板
 *  @return 元素Object
 */
+ (WDGBoardObject *)creatCircleObjectFromBoard:(WDGBoard *)board;

/**
 *  生成一个文字元素
 *  @param board 画板
 *  @param string 文字内容
 *  @return 元素Object
 */
+ (WDGBoardObject *)creatTextFromBoard:(WDGBoard *)board
                            WithString:(NSString *)string;

/**
 *  生成一个三角形元素
 *  @param board 画板
 *  @return 元素Object
 */
+ (WDGBoardObject *)creatTriangleObjectFromBoard:(WDGBoard *)board;

/**
 *  生成一个图片元素 - 通过图片的URL地址
 *
 *  @param board 画板
 *  @param URL 图片的URL地址
 *  @return 元素Object
 */
+ (WDGBoardObject *)creatImageObjectFromBoard:(WDGBoard *)board
                                      WithURL:(NSString *)URL;

/**
 *  生成一个直线元素
 *
 *  @param board 画板
 *  @param pointA 起始点坐标
 *  @param pointB 结束点坐标
 *  @return 元素Object
 */
+ (WDGBoardObject *)creatLineObjectFromBoard:(WDGBoard *)board
                                  WithPointA:(CGPoint)pointA
                                      PointB:(CGPoint)pointB;

@end
