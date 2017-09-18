# WDGBoardOptions
* 白板的相关设置

## 读写权限
```objc
@property WDGBoardOpthionsAuthorityMode AuthorityMode;
```
##### 权限定义枚举
```objc
typedef NS_ENUM (NSInteger , WDGBoardOpthionsAuthorityMode){
    //可读可写（默认）
    WDGBoardOpthionsAuthorityModeReadWrite,
    //只读
    WDGBoardOpthionsAuthorityModeReadOnly
};
``` 

## 画布大小
```objc
@property (nonatomic,assign) CGSize canvasSize;
```
* 设置的画布大小，会自动适应填充显示。类似于UIImage的UIViewContentModeScaleAspectFill。
* 所以建议画布大小和其它端保持一致。
* 在画布大小的长宽比例和白板控件的显示长宽比例相同的时候，显示不会有任何裁剪。


## 默认设置

* 得到一个默认设置的Option对象

```objc
+ (WDGBoardOptions *)defaultOptions;
```



