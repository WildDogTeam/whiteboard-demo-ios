# WDGBoardToolOptions

* 画图工具的属性

## 颜色

* 可以设置透明度

```objc
@property (nonatomic,strong) UIColor *color;
```

## 大小

* 可用于代表粗细，字号

```objc
@property (nonatomic,assign) float size;
```

## 快捷生成方法

* 快速得到一个option

```objc
+ (WDGBoardToolOptions *)optionWithColor:(UIColor *)color;

+ (WDGBoardToolOptions *)optionWithColor:(UIColor *)color size:(float)size;
```



