一、 介绍屏幕适配的发展过程
1. 直接使用 frame
* iPhone3GS \ iPhone4 \ iPhone4S 屏幕的物理尺寸是一样的, 而且一个应用要么是横屏要么是竖屏, 不存在能同时进行横竖屏切换的应用

2. 使用 autoresizing
* 苹果发布 iPad 以后, 屏幕的物理大小发生了变化, 并且要求部分应用程序实现横竖屏切换
* 举例: 在竖屏下有一个按钮要占据整个屏幕宽度, 当切换到横屏下以后同样要占据整个屏幕的宽度
* autoresizing只能设置当前控件与父控件之间的相对关系



3. 使用 autolayout（从 iOS6开始）
* 随着 iPhone5 \ iPhone5s 等的发布苹果设备的屏幕变得越来越多, 不仅要求能根据控件父子关系来设置相对位置, 也要求能根据任意控件之间的关系来设置位置
* 因为 autoresizing只能设置当期控件与父控件之间的相对关系, 当遇到要设置兄弟控件之间的关系的时候 autoresizing就无能为力了
* 举例: 在竖屏下, 屏幕底部有两个按钮, 这两个按钮的间距为一个固定的值; 当切换为横屏的时候要求这两个按钮还显示在屏幕底部, 并且按钮间的间距不变, 按钮可以随之变宽。



4. 使用 size classes(看时间作为补充, 今天的内容是"Autolayout")
* 当 iPhone6发布以后, 苹果设备的屏幕越来越多(以后也可能出现更多不同大小的屏幕), 为了能更容易的适配不同的屏幕, 苹果推出了size classes 技术
* 通过 autolayout设置的约束, 约束一旦添加就会应用于各种屏幕（也就是说在各种不同的屏幕下都使用相同的约束）
* 通过 size classes + autolayout的方式, 可以为不同尺寸的屏幕设置不同的约束
举例: 在3.5 inch的屏幕下希望某个按钮紧贴屏幕上边显示, 但是当屏幕变成4.7 inch以后, 则希望该按钮显示到屏幕的正中央
* size classes技术主要解决的问题: 为不同屏幕, 通过 autolayout设置不同的约束。


5. 屏幕适配的发展总结:
通过代码计算 frame -> autoresizing(通过设置子控件与父控件的关系来决定如何显示控件) -> autolayout(通过设置某控件与任意其他控件间的关系来决定如何显示这个控件, 不仅仅局限与父子控件) -> size classes(通过 size classes + autolayout实现针对不同屏幕为控件设置不同的约束)






二、 介绍 autoresizing的使用(只是为了介绍, 以后不要用 autoresizing, 都用 autolayout)
** autoresizing 和 autolayout只能用其一
1. 案例演示(说明 autoresizing外面的四根线作用):
1> 选择3.5 inch的控制器, 在四角放四个 UIView, 设置宽高都是100, 并设置不同背景颜色
2> 分别演示在iPhone4S \ iPhone5s \ iPhone6 不同模拟器下的效果（同时演示横屏下效果也不正常）, 说明如果不做屏幕适配, 那么在不同的模拟器下效果不正常
3> 通过 autoresizing解决布局问题, 首先取消掉 autolayout。
** 特别提示: autoresizing 和 autolayout二者只能用其一。 若使用了 autoresizing则不能使用 autolayout, 若使用了 autolayout, 则不能使用 autoresizing。
4> 选中对应的子控件, 点击"工具箱"中的"Size Inspector(小尺子)"
5> 找到 autoresizing的属性框, 通过设置是否需要"外面的4根线"来实现屏幕适配
** 外面四根线的含义: 当前控件与父控件之间是否保持固定的距离。如果"选择"了外面的"线"则表示与父控件某一边的距离固定, 如果不勾选, 则表示当前控件与父控件的某一边距离是可拉伸的（不固定）。


2. 案例演示(说明 autoresizing里面的两根线的作用)
1> 在界面上放置两个 UIView
* 蓝色 UIView, 200*200
* 红色 UIView(放在蓝色 UIView的里面), 100*100

2> 要求当蓝色 UIView的宽高发生改变的时候, 要求红色 UIView的宽高也随着改变
** 里面两根线的作用: 表示子控件的宽和高是否随着父控件的宽高的变化而变化
* 通过修改属性中蓝色 UIView的大小来演示红色 UIView 跟随变化的效果


3. 通过代码来实现 autoresizing
* 目的: 为了在工作中遇到旧的项目是通过代码实现的 autoresizing时可以应付自如。旧的项目还有没 storyboard。
3.1 案例:
(注意: 这里一定要用纯代码的方式创建每一个控件, 拖上来的控件默认设置了一些属性, 会造成运行效果不正确)
1> 通过代码创建一个蓝色 UIView, 200*200
2> 在这个蓝色 UIView里创建一个红色 UIView, 200*50, 这个红色 UIView放在在蓝色 UIView的最底部: x = 0, y = 150
3> 要求: 当蓝色 UIView发生变化时（宽和高改变时）, 红色 UIView的宽随着蓝色 UIView的宽度变化（红色 UIView的高度始终保持不变）, 并且永远紧贴在蓝色UIView底部显示。
4> 为按钮注册单击事件, 点击按钮的时候动态改变蓝色 UIView的高度和宽度, 观察里面红色 UIView的变化
5> 为红色 UIView设置宽度随着父控件变化而变化、顶部自由伸缩（也就是底部紧贴父控件的底部）就可以了。
redVw.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;











三、 介绍 autolayout的使用
1. 演示案例(说明 autoresizing的局限性): 底部有两个 UIView, 永远保持这两个 UIView中间的间距.
1> 在4.7 inch的控制器下, 在底部放两个 UIView, 宽分别是185, 这样中间就能保持5的间距
2> 通过 autoresizing设置这两个 UIView分别位于左下角和右下角
3> 运行模拟器, 当横屏显示的时候, 两个 UIView的间距发生了变化
4> 要求: 当横屏的时候要始终保持两个按钮的间距, 可以通过放大或者缩小按钮的宽度来保持间距。
5> 此时, 无法通过 autoresizing来实现, 需要使用 autolayout。



2. 介绍 autolayout下面的菜单按钮的作用
* 说明 storyboard下面的按钮, 哪些是 autolayout用的, 哪些是 size classes用的
* 第一个按钮用来设置对齐方式的
* 第二个按钮用来固定控件的（固定控件的宽、高、距离父控件（兄弟控件等）的距离）
* 第三个按钮用来解决约束中遇到的一些问题的（删除约束、使用 xcode 建议的约束、使控件按照约束的方式显示等）
* 第四个按钮没用过


3. 案例1: 在控制器中放一个 UIView, 通过 frame设置 UIView距离四周的距离都是50.
* 此时的问题: 当屏幕变化的时候（屏幕大小发生变化, 或者横屏的时候）, 没有做屏幕适配
* 解决方案一: 使用 autoresizing（外面四根线勾上, 里面两根线也勾上）
* 解决方案二: 使用 autolayout
** 1> 通过设置红色 UIView距离四周（上下左右）的距离都50的约束来实现
** 2> 或者通过设置红色 UIView水平、垂直居中对齐来实现
** 注意问题: 只是设置完毕对齐方式还要设置高和宽否则提示约束不完整
** 设置水平、垂直居中的含义其实就是设置当前控件与父控件的中点一致（只设置了 x, y, 还要在设置高和宽）
** 总结无论是通过 autoresizing还是 autolayout最终其实还是通过设置控件的frame来实现的。所以一旦使用了 autolayout就不要再随便设置 frame 了, 可能造成混乱。
** 注意: 红色箭头表示: 缺少约束 或者 约束冲突



4. 通过 autolayout解决 autoresizing的局限性问题, 设置底部的两个 UIView之间始终保持相同间距。
* 始终关注4个值, x, y, height, width




四、 介绍 size classes 的使用
* 从 iOS8开始才支持 size classes
* size classes本质就是对所有的屏幕进行了分类, 我们可以为不同类型的屏幕设置不同的约束
* 仅仅是对屏幕进行了分类, 真正排布UI元素还得使用autolayout
* 不再有横竖屏的概念, 只有屏幕尺寸的概念
* 不再有具体尺寸的概念, 只有抽象尺寸的概念
* 把宽度和高度各分为3种情况
1> any(任意, 表示既可以是 compact, 也可以是 regular),         一般用 * 表示
2> compact(紧凑, 小),                                      一般用 - 表示
3> regular(正常, 大),                                      一般用 + 表示


4> ** 注意:
一般不要在 wAny 和 hAny下设置约束, 否则当在 wAny 和 hAny下设置约束后, 在其他尺寸的屏幕再设置约束会产生冲突。因为约束会被继承下来。

约束的继承关系（*符号就表示+ 或者 -）:
* * : 其它8种情况都会继承
* - : 会被- - \ + -继承
+ * : 会被+ - \ + +继承

所以当使用 Any设置约束的时候要特别注意。


5> sizeclass和autolayout关系
sizeclass:仅仅是对屏幕进行了分类
autolayout:对屏幕中各种元素进行约束(位置\尺寸)





案例1: 在所有竖屏的 iPhone上左上角有一个开关, 在所有 iPad 上, 右下角显示开关
步骤:
1> 先选中控件, 在右侧设置 Installed 属性, 告诉 xcode 在哪种屏幕下要显示这个控件
2> 选择底部菜单栏的size classes菜单项, 设置在特定的屏幕下如何显示(如何应用约束)
** 注意: 默认情况下 Installed表示 Any 和 Any, 也就意味着默认情况下在任何屏幕下都显示这个控件

案例2: 在所有横屏的 iPhone上右上角有一个开关。


案例3: 在所有屏幕下显示一张图片, 在iPad 下显示另外一张图片。


案例4: 设置某个图片, 默认（手机竖屏）显示一张图片（垂直、水平居中显示）, 当切换到手机横屏的时候显示另外一张图片（显示到右下角）。
步骤:
1> 添加一个 UIIamgeView, 并且设置 Installed属性, 在 所有 iPhone的竖屏下显示, 并设置约束；在所有手机的横屏下显示, 并设置约束。
2> 拖拽第一张图片到 Imagees.xcassets中。
3> 设置图片框要显示的图片
4> 在 Imagees.xcassets中选中对应的图片, 设置图片的属性。

案例5: 设置一个 Label 在不同屏幕下显示不同的字体。点击字体左边的+号来修改。



蓝色view

width:  距离左边30 +  距离右边30

height: 50

X: 距离左边30

Y: 距离顶部30





红色view

width:

height: 设置红色view与蓝色view的高相等

X: 设置红色view与蓝色view右对齐 + 红色view水平居中, 这两个约束共同决定了红色view的x和宽度。

Y: 距离蓝色view的间距是30











红色Width   ->   X



X =  (蓝色Width + 0 ) * 1



蓝色Top  X

X = (self.top + 30)  * 1











