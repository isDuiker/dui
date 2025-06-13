<p align="center">
    <img src="https://cdn.jsdelivr.net/gh/eueuueeueu/blogImage@main/img/logo.png" width="100">
</p>

<p align="center">uil</p>

<p align="center">提供常用的UI组件，帮助开发者快速构建鸿蒙应用</p>

<p align="center">
    <a style="color:#0366d6;" href="https://github.com/isDuiker/dui">文档</a>
    &nbsp;
    ·
    &nbsp;
    <a style="color:#0366d6;" onclick="openPage('https://github.com/isDuiker/dui')">Github</a>
</p>

---

# @duiker/uil

## 介绍

uil 是一款功能丰富、高效易用的 UI 库，旨在帮助开发者快速构建美观、交互流畅的用户界面。该库提供常用的UI组件，帮助开发者快速构建鸿蒙应用。

## 下载安装

`ohpm install @duiker/uil`

## 基础组件

### DButton 按钮

#### 介绍

增强型按钮组件，提供预定义颜色、大小和填充模式，同时支持自定义样式。适用于表单提交、操作触发等场景。

#### 参数

| 参数          | 类型                                                                                         | 必填 | 默认值       | 描述               |
|-------------|--------------------------------------------------------------------------------------------|----|-----------|------------------|
| text        | string                                                                                     | 是  | '确认'      | 按钮显示的文本          |
| color       | `'default'`&#124;`'primary'`&#124;`'success'`&#124;`'warning'`&#124;`'danger'`&#124;string | 否  | 'primary' | 按钮颜色主题，支持自定义颜色值  |
| fill        | `'Solid'`&#124;`'Outline'`&#124;`'None'`                                                   | 否  | 'Solid'   | 按钮填充模式           |
| mode        | `'Mini'`&#124;`'Small'`&#124;`'Middle'`&#124;`'Large'`                                     | 否  | 'Small'   | 按钮尺寸大小           |
| customStyle | [DCustomStyle](#dcustomstyle-自定义样式)                                                        | 否  | 无         | 自定义按钮样式（会覆盖默认样式） |

#### 事件

| 事件名称  | 事件描述       | 参数 |
|-------|------------|----|
| click | 点击按钮时触发的事件 | 无  |

#### 使用示例

```ts
// 基本使用
DButton({
  text: '提交'
})

// 带自定义样式的按钮
DButton({
  text: '自定义按钮',
  color: 'danger',
  fill: 'Outline',
  mode: 'Middle',
  customStyle: {
    width: '80%',
    borderRadius: 20,
    backgroundColor: '#FFF0F0',
    border: { width: 2, color: '#FF0000' }
  }
})
```

### Dialog 对话框

#### 介绍

模态对话框组件，用于确认用户操作或显示重要信息。支持自定义内容和操作按钮。

#### 方法

| 方法名     | 描述    | 参数                                          |
|---------|-------|---------------------------------------------|
| open    | 打开对话框 | UIContext, [DialogOption](#dialogoption-参数) |
| dismiss | 关闭对话框 | 无                                           |

#### DialogOption 参数

| 参数             | 类型                                | 必填 | 默认值 | 描述                          |
|----------------|-----------------------------------|----|-----|-----------------------------|
| title          | string                            | 是  | 无   | 对话框标题                       |
| content        | string                            | 否  | 无   | 对话框内容文本（与contentBuilder二选一） |
| contentBuilder | [WrappedBuilder](#wrappedbuilder) | 否  | 无   | 自定义内容构建函数（与content二选一）      |
| onCancel       | () => void                        | 否  | 无   | 点击取消按钮时的回调函数                |
| onConfirm      | () => void                        | 否  | 无   | 点击确认按钮时的回调函数                |

#### WrappedBuilder

用于自定义对话框内容的构建器类型：

```ts
type WrappedBuilder = {
  builder: (...args: any[]) => void;
};
```

#### 使用示例

```ts
// 基本对话框
DialogUtil.open(uiContext, {
  title: "确认操作",
  content: "确定要删除该项吗？",
  onConfirm: () => { /* 确认操作 */ },
  onCancel: () => { /* 取消操作 */ }
})

// 自定义内容对话框
@Builder
function CustomDialogContent() {
  Row() {
    Image($r('app.media.warning'))
      .width(40)
      .height(40)
    Text("自定义内容警告").fontColor(Color.Red)
  }
}

DialogUtil.open(uiContext, {
  title: "自定义对话框",
  contentBuilder: wrapBuilder(CustomDialogContent),
  onConfirm: () => { /* 处理确认 */ }
})
```

### DNavBar 导航栏

#### 介绍

通用导航栏组件，提供标题、返回按钮和右侧操作按钮功能。适配状态栏高度，无缝融入应用界面。

#### 参数

| 参数              | 类型         | 必填 | 默认值  | 描述                          |
|-----------------|------------|----|------|-----------------------------|
| title           | string     | 是  | 无    | 导航栏标题（必传）                   |
| showBack        | boolean    | 否  | true | 是否显示返回按钮                    |
| statusBarHeight | number     | 否  | 0    | 状态栏高度（主要用于适配不同设备）           |
| onBackClick     | () => void | 否  | 无    | 返回按钮点击回调（默认执行router.back()） |
| onMoreClick     | () => void | 否  | 无    | 右侧按钮点击回调（设置此参数才会显示右侧按钮）     |

#### 事件

| 事件名称        | 事件描述           | 参数 |
|-------------|----------------|----|
| onBackClick | 返回按钮点击时触发的事件   | 无  |
| onMoreClick | 右侧操作按钮点击时触发的事件 | 无  |

#### 使用示例

```ts
// 基础导航栏
DNavBar({ title: "个人中心" })

// 带自定义操作的导航栏
DNavBar({
  title: "设置",
  statusBarHeight: 40,
  onBackClick: () => { console.log("自定义返回操作") },
  onMoreClick: () => { console.log("更多操作") }
})
```

### 通用类型

#### DCustomStyle 自定义样式

用于自定义组件样式的对象：

```ts
interface DCustomStyle {
  width?: string | number;               // 宽度
  height?: string | number;              // 高度
  borderRadius?: number;                 // 圆角半径
  padding?: {                            // 内边距
    top?: number; 
    bottom?: number; 
    left?: number; 
    right?: number 
  };
  fontSize?: number;                     // 字体大小
  fontColor?: string | Color;            // 字体颜色
  backgroundColor?: string | Color;       // 背景颜色
  border?: {                             // 边框样式
    width?: number; 
    color?: string | Color 
  };
}
```

## 第三方库

没有引入第三方插件