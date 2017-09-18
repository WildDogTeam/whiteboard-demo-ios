#WDGBoard
* WDBoard 即为白板控件，是UIView的子类。

***

- [1, 画板设置、操作部分](## 1, 画板设置、操作部分)
- [2, Tool 画板工具部分](## 2, Tool 画板工具部分)
- [3, Object 元素部分](## 3, Object 元素部分)
- [4, Event事件部分](## 4, Event事件部分)

***

## 1, 画板设置、操作部分
### 创建白板
* 创建白板的类方法

```objc
+ (WDGBoard *)creatBoardWithAppID:(NSString *)appID
                             Path:(NSString *)path
                           userID:(NSString *)userID;
```

 *  @param appid   野狗AppID
 *  @param path  白板数据储存路径 - 可以用户自定义
 *  @param userID  用户ID - 需要用户自己定义&维护
 *  @return 白板对象

 ***

### 创建白板，带option

* 带option的创建白板的类方法，option里可以设置读写权限和画布尺寸

```objc
+ (WDGBoard *)creatBoardWithAppID:(NSString *)appid
                             Path:(NSString *)path
                           userID:(NSString *)userID
                         opthions:(WDGBoardOptions *)options;
```

 *  @param appid   野狗AppID
 *  @param path  白板数据储存路径 - 可以用户自定义。
 *  @param userID  用户ID - 需要用户自己定义&维护
 *  @param options 白板设置
 *  @return 白板对象

***

### 初始化白板
* 如果是拖拽布局，或其它没有使用类方法的形式创建的白板，需要用此方法初始化

```objc
- (void)setUpBoardWithWithAppID:(NSString *)appid
                           Path:(NSString *)path
                         userID:(NSString *)userID
                       opthions:(WDGBoardOptions *)options;
```

 *  @param appid   野狗AppID
 *  @param path  白板数据储存路径 - 可以用户自定义。
 *  @param userID  用户ID - 需要用户自己定义&维护
 *  @param options 白板设置

 ***

### 更新Option设置
```objc
- (void)updateOption:(WDGBoardOptions *)options;
```

 *  @param options 设置

 ***
 
### 翻页
*  翻页，如果不输入页码，则翻到默认页
*  **翻页离开本页后，操作记录将会被清空，无法执行撤销操作。**

```objc
- (void)changePage:(long)pageNumber;
```
 
  *  @param pageNumber 页码

  ***
  
### 清空当前页面

```objc
- (void)clearPage;
```

  *  清空当前页面
  
 ***
  
### 撤销

```objc
- (void)undo;
```

*  撤销

    ***

### 重做

```objc
- (void)redo;
```

*  重做

    ***

### 设置背景颜色

```objc
- (void)setBackgroundColor:(UIColor *)backgroundColor;
```

*  @param backgroundColor 背景颜色

    ***

### 设置背景图片
 *  设置图片背景 - 使用图片URL
 
```objc
- (void)setBackgroundImageWithURL:(NSString *)URL;
```

 *  @param URL 图片的URL

***
 


## 2, Tool 画板工具部分
### 工具类型
```objc
typedef NS_ENUM(NSInteger, WDGBoardToolType){
    //默认工具，只有选择此工具的时候，可以在画板上选中元素
    WDGBoardToolTypeDefault,
    //画笔工具
    WDGBoardToolTypePen,
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
```

* 工具类型枚举

 ***

###  设置当前工具

 *  设置当前工具

```objc
- (void)setToolWithType:(WDGBoardToolType)ToolType
                options:(WDGBoardToolOptions *)options;
```
 
*  @param ToolType 工具类型
*  @param options  相关设置(颜色、粗细/大小)

***


 
## 3, Object 元素部分

### 向画布添加显示一个元素

 *  向画布添加显示一个元素

```objc
- (void)addObject:(WDGBoardObject *)object;
```

 *  @param object 需要显示的元素

    ***

### 从画布上删除一个元素 - 通过objectID
 *  从画布上删除一个元素 - 通过objectID
 
```objc
- (void)removeObjectWithObjectID:(NSString *)objectID;
```
 
 *  @param objectID 需要删除的元素的objectID

 ***
 
### 生成一个长方形元素
 
 *  生成一个长方形元素
 
```objc
- (WDGBoardObject *)creatRectObject;
```
 
 *  @return 元素Object

 ***
 
### 生成一个圆形元素
 *  生成一个圆形元素

```objc
- (WDGBoardObject *)creatCircleObject;
```

 *  @return 元素Object

 ***

### 生成一个三角形元素
 *  生成一个三角形元素

```objc
- (WDGBoardObject *)creatTriangleObject;
```

 *  @return 元素Object

 ***
 
### 生成一个文字元素
 * 通过文字内容，生成一个文字元素

```objc
- (WDGBoardObject *)creatTextObjectOfString:(NSString *)string;
```

 *  @param string 文字内容
 *  @return 元素Object

 ***
 
### 生成一个直线元素
 * 通过两个端点，生成一个直线元素

```objc
- (WDGBoardObject *)creatLineObjectWithPointA:(CGPoint)pointA pointB:(CGPoint)pointB;
```

 *  @param pointA 直线起点
 *  @param pointB 直线终点
 *  @return 元素Object

 ***
 
### 生成一个图片元素
 * 通过图片的URL地址，生成一个图片元素

```objc
- (WDGBoardObject *)creatImageObjectWithURL:(NSString *)URL;
```

 *  @param URL 图片的URL地址
 *  @return 元素Object

 ***
 
### 获取画板上所有元素
 * 获取所有展示到画板上去了的元素

```objc
- (void)getAllShowingObjectWithBlock:(void(^)(NSArray<WDGBoardObject *>* objects,NSError *error))block;
```

* @param block 获取的回调

 ***

## 4, Event事件部分

### 元素被添加的监听
*  设置一个页面内有元素被添加的监听

```objc
- (WDGBoardObserveHandle)ObserveObjectAddedWithBlock:(void(^)(WDGBoardObject *object,NSDictionary *allProperty))block;
```

 *  @param block 监听的回调
 *  block - object 元素对象 - 请使用ObjectID判断元素的唯一性
 *  block - allProperty 元素的所有样式属性
 *  @return 监听的handle

 ***
 
### 元素被删除的监听
*  设置一个页面内有元素被删除的监听

```objc
- (WDGBoardObserveHandle)ObserveObjectRemovedWithBlock:(void(^)(WDGBoardObject *object,NSDictionary *allProperty))block;
```

 *  @param block 监听的回调
 *  block - object 元素对象 - 请使用ObjectID判断元素的唯一性
 *  block - allProperty 元素的所有样式属性
 *  @return 监听的handle

 ***

### 元素被修改的监听
*  设置一个页面内有元素被修改的监听

```objc
- (WDGBoardObserveHandle)ObserveObjectModifiedWithBlock:(void(^)(WDGBoardObject *object,NSDictionary *allProperty))block;
```

 *  @param block 监听的回调
 *  block - object 元素对象 - 请使用ObjectID判断元素的唯一性
 *  block - allProperty 元素的所有样式属性
 *  @return 监听的handle

 ***
 
### 元素被选中的监听
*  设置一个页面内有元素被选中的监听

```objc
- (WDGBoardObserveHandle)ObserveObjectSeletedWithBlock:(void(^)(WDGBoardObject *object,NSDictionary *allProperty))block;
```

 *  @param block 监听的回调
 *  block - object 元素对象 - 请使用ObjectID判断元素的唯一性
 *  block - allProperty 元素的所有样式属性
 *  @return 监听的handle

 ***
 
### 元素被取消选中的监听
*  设置一个页面内有元素被取消选中的监听

```objc
- (WDGBoardObserveHandle)ObserveObjectDeseletedWithBlock:(void(^)(WDGBoardObject *object,NSDictionary *allProperty))block;
```

 *  @param block 监听的回调
 *  block - object 元素对象 - 请使用ObjectID判断元素的唯一性
 *  block - allProperty 元素的所有样式属性
 *  @return 监听的handle

 ***

