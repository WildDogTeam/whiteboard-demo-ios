//
//  WDGBoard.h
//  WhiteBoardAPI
//
//  Created by problemchild on 2017/8/15.
//  Copyright © 2017年 FreakyYang. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "WDGBoardOptions.h"
#import "WDGBoardToolOptions.h"
@class WDGBoardObject;

typedef long WDGBoardObserveHandle;

/**
 *  白板控件
 */
@interface WDGBoard : UIView

@property (nonatomic,assign)long currentPage;

@property (nonatomic,strong,readonly) WDGBoardOptions *option;

@property (nonatomic,strong,readonly) NSString        *userID;

#pragma mark --------------------Board

/**
 *  创建白板
 *
 *  @param appID 野狗AppID
 *  @param path  数据储存路径
 *  @param userID  用户ID
 *
 *  @return 白板对象
 */
+ (WDGBoard *)creatBoardWithAppID:(NSString *)appID
                             Path:(NSString *)path
                           userID:(NSString *)userID;

/**
 *  创建白板-带option
 *
 *  @param appid   野狗AppID
 *  @param path    数据储存路径
 *  @param userID  用户ID
 *  @param options 白板设置
 *
 *  @return 白板对象
 */
+ (WDGBoard *)creatBoardWithAppID:(NSString *)appid
                             Path:(NSString *)path
                           userID:(NSString *)userID
                         opthions:(WDGBoardOptions *)options;

/**
 *  如果是拖拽布局，或其它没有使用类方法的形式创建的白板，需要用此方法初始化
 *
 *  @param appid   野狗AppID
 *  @param path    数据储存路径
 *  @param userID  用户ID
 *  @param options 白板设置
 */
- (void)setUpBoardWithWithAppID:(NSString *)appid
                           Path:(NSString *)path
                         userID:(NSString *)userID
                       opthions:(WDGBoardOptions *)options;

/**
 *  更新设置
 *
 *  @param options 设置
 */
- (void)updateOption:(WDGBoardOptions *)options;

/**
 *  翻页，如果不输入页码，则翻到默认页
 *
 *  @param pageNumber 页码
 */
- (void)changePage:(long)pageNumber;

/**
 *  清空当前页面
 */
- (void)clearPage;

/**
 *  撤销
 */
- (void)undo;

/**
 *  重做
 */
- (void)redo;

/**
 *  设置背景颜色
 *
 *  @param backgroundColor 背景颜色
 */
- (void)setBackgroundColor:(UIColor *)backgroundColor;

/**
 *  设置图片背景 - 使用图片URL
 *
 *  @param URL 图片的URL
 */
- (void)setBackgroundImageWithURL:(NSString *)URL;


#pragma mark --------------------Event

/**
 *  设置一个页面内有元素被添加的监听
 *
 *  @param block 监听的回调
 *
 *  @return 监听的handle
 */
- (WDGBoardObserveHandle)ObserveObjectAddedWithBlock:(void(^)(WDGBoardObject *object,NSDictionary *allProperty))block;

/**
 *  设置一个页面内有元素被删除的监听
 *
 *  @param block 监听的回调
 *
 *  @return 监听的handle
 */
- (WDGBoardObserveHandle)ObserveObjectRemovedWithBlock:(void(^)(WDGBoardObject *object,NSDictionary *allProperty))block;

/**
 *  设置一个页面内有元素被修改的监听
 *
 *  @param block 监听的回调
 *
 *  @return 监听的handle
 */
- (WDGBoardObserveHandle)ObserveObjectModifiedWithBlock:(void(^)(WDGBoardObject *object,NSDictionary *allProperty))block;

/**
 *  设置一个页面有元素被选中的监听
 *
 *  @param block 监听的回调
 *
 *  @return 监听的handle
 */
- (WDGBoardObserveHandle)ObserveObjectSeletedWithBlock:(void(^)(WDGBoardObject *object,NSDictionary *allProperty))block;

/**
 *  设置一个页面有元素被取消选中的监听
 *
 *  @param block 监听的回调
 *
 *  @return 监听的handle
 */
- (WDGBoardObserveHandle)ObserveObjectDeseletedWithBlock:(void(^)(WDGBoardObject *object,NSDictionary *allProperty))block;

///**
// *  设置一个页面缩放的监听
// *
// *  @param block 主人页面缩放后会触发此监听
// *
// *  @return 监听的回调
// */
//- (WDGBoardObserveHandle)ObservePageZoomedWithBlock:(void(^)(CGPoint centerPoint,
//                                                             double zoomScale))block;

/**
 *  移除监听
 *
 *  @param handle 监听的Handle
 */
- (void)removeObserveWithHandle:(WDGBoardObserveHandle)handle;

/**
 *  移除所有监听
 */
- (void)removeAllObserves;

#pragma mark --------------------Tool

//工具类型
typedef NS_ENUM(NSInteger, WDGBoardToolType){
    //默认工具，只有选择此工具的时候，可以在画板上选中元素
    WDGBoardToolTypeDefault,
    //画笔工具
    WDGBoardToolTypePen,
    //画笔工具-每笔画完之后再做数据同步
    WDGBoardToolTypeSingleSyncPen,
    //直线工具
    WDGBoardToolTypeLine,
    //文字工具
    WDGBoardToolTypeText,
    //长方形工具
    WDGBoardToolTypeRect,
    //空心长方形工具，注：使用此工具创建出的元素依然是“Rect”类型的元素。
    WDGBoardToolTypeEmptyRect,
    //三角形工具
    WDGBoardToolTypeTriangle,
    //圆形工具
    WDGBoardToolTypeCricle,
    //空心圆工具，注：使用此工具创建出的元素依然是“Circle”类型的元素。
    WDGBoardToolTypeEmptyCricle,
    //箭头工具，注：使用此工具创建出的，实际是“Pen”类型的元素，但是对拖拽编辑有所优化。
    WDGBoardToolTypeArrow
};

/**
 *  设置当前工具
 *
 *  @param ToolType 工具类型
 *  @param options  相关设置
 */
- (void)setToolWithType:(WDGBoardToolType)ToolType
                options:(WDGBoardToolOptions *)options;


#pragma mark --------------------Object

/**
 *  向画布添加显示一个元素
 *
 *  @param object 需要显示的元素
 */
- (void)addObject:(WDGBoardObject *)object;

/**
 *  从画布上删除一个元素 - 通过objectID
 *
 *  @param objectID 需要删除的元素的objectID
 */
- (void)removeObjectWithObjectID:(NSString *)objectID;

/**
 *  从画布上删除一个元素 - 通过object
 *
 *  @param object 需要删除的元素的object
 */
- (void)removeObjectWithObject:(WDGBoardObject *)object;

/**
 *  生成一个长方形元素
 *
 *  @return 元素Object
 */
- (WDGBoardObject *)creatRectObject;

/**
 *  生成一个圆形元素
 *
 *  @return 元素Object
 */
- (WDGBoardObject *)creatCircleObject;

/**
 *  生成一个三角形元素
 *
 *  @return 元素Object
 */
- (WDGBoardObject *)creatTriangleObject;

/**
 *  生成一个文字元素
 *
 *  @param string 文字内容
 *  @return 元素Object
 */
- (WDGBoardObject *)creatTextObjectOfString:(NSString *)string;

/**
 *  生成一个直线元素
 *
 *  @param pointA 直线起点
 *  @param pointB 直线终点
 *  @return 元素Object
 */
- (WDGBoardObject *)creatLineObjectWithPointA:(CGPoint)pointA pointB:(CGPoint)pointB;

/**
 *  生成一个图片元素 - 通过图片的URL地址
 *
 *  @param URL 图片的URL地址
 *
 *  @return 元素Object
 */
- (WDGBoardObject *)creatImageObjectWithURL:(NSString *)URL;

/**
 *  获取所有展示到画板上去了的元素
 *
 *  @param block 获取的回调
 */
- (void)getAllShowingObjectWithBlock:(void(^)(NSArray<WDGBoardObject *>* objects,NSError *error))block;

- (void)destroy;
@end


