# WDGBoardObject
* 白板上显示的元素

## 属性部分

- 元素唯一标识

```objc
@property (nonatomic,strong) NSString *ObjectID;
```

- 创作者标识

```objc
@property (nonatomic,strong) NSString *userID;
```

- 元素类型

```objc
@property (nonatomic,assign) WDGBoardObjectType ObjectType;
```

- 元素类型定义

```objc
//元素类型
typedef NS_ENUM(NSInteger, WDGBoardObjectType){
    //画笔
    WDGBoardObjectTypePen,
    //直线
    WDGBoardObjectTypeLine,
    //长方形
    WDGBoardObjectTypeRect,
    //三角形
    WDGBoardObjectTypeTriangle,
    //圆形
    WDGBoardObjectTypeCricle,
    //文字
    WDGBoardObjectTypeText,
    //图片
    WDGBoardObjectTypeImage
};
```

- 颜色 - 包括透明度

```objc
@property (nonatomic,strong) UIColor *color;
```


- 元素中心点离画板顶部的距离

```objc
@property (nonatomic,assign) double top;
```

- 元素中心点离画板左边的距离

```objc
@property (nonatomic,assign) double left;
```

- 元素宽度

```objc
@property (nonatomic,assign) double width;
```

- 元素高度

```objc
@property (nonatomic,assign) double height;
```

- 旋转角度-绕元素中心点旋转

```objc
@property (nonatomic,assign) double angle;
```

- 画笔粗细、字体大小

```objc
@property (nonatomic,assign) double size;
```

- 内容 -- url 或 text

```objc
@property (nonatomic,strong) NSString *data;
```


## 操作部分

### 添加到画板上显示
``` objc
- (void)showOnBoard;
```

### 从画板上移除
``` objc
- (void)RemoveFromBoard;
```

### 获取所有可调节参数，以及目当前的值

* 元素有更多可设置的参数，并不在元素的属性中，可以通过此方法查看

```objc
- (void)getAllPropertysWithBlock:(void(^)(NSDictionary *propertysDictionary))block;
```

 *  @param block 回调

### 设置更多可调节参数

* 元素有更多可设置的参数，并不在元素的属性中，可以通过此方法设置

```objc
- (void)getAllPropertysWithBlock:(void(^)(NSDictionary *propertysDictionary))block;
```

 *  @param block 回调

## 生成部分
### 生成一个长方形元素
 
 *  生成一个长方形元素
 
```objc
+ (WDGBoardObject *)creatRectObjectFromBoard:(WDGBoard *)board;
```
 
 *  @param board 画板
 *  @return 元素Object

 ***
 
### 生成一个圆形元素
 *  生成一个圆形元素

```objc
+ (WDGBoardObject *)creatCircleObjectFromBoard:(WDGBoard *)board;
```

 *  @param board 画板
 *  @return 元素Objectt

 ***

### 生成一个三角形元素
 *  生成一个三角形元素

```objc
+ (WDGBoardObject *)creatTriangleObjectFromBoard:(WDGBoard *)board;
```

 *  @param board 画板
 *  @return 元素Objectt

 ***
 
### 生成一个文字元素
 * 通过文字内容，生成一个文字元素

```objc
+ (WDGBoardObject *)creatTextFromBoard:(WDGBoard *)board
                            WithString:(NSString *)string;
```

 *  @param board 画板
 *  @param string 文字内容
 *  @return 元素Object

 ***
 
### 生成一个直线元素
 * 通过两个端点，生成一个直线元素

```objc
+ (WDGBoardObject *)creatLineObjectFromBoard:(WDGBoard *)board
                                  WithPointA:(CGPoint)pointA
                                      PointB:(CGPoint)pointB;
```

 *  @param board 画板
 *  @param pointA 起始点坐标
 *  @param pointB 结束点坐标
 *  @return 元素Object

 ***
 
### 生成一个图片元素
 * 通过图片的URL地址，生成一个图片元素

```objc
+ (WDGBoardObject *)creatImageObjectFromBoard:(WDGBoard *)board
                                      WithURL:(NSString *)URL;
```

 *  @param board 画板
 *  @param URL 图片的URL地址
 *  @return 元素Object

 ***


