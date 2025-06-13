type DColor = 'default' | 'primary' | 'success' | 'warning' | 'danger' | string
type DFill = 'Solid' | 'Outline' | 'None'
type DMode = 'Mini' | 'Small' | 'Middle' | 'Large'

interface DCustomStyle {
  width?: string | number;
  height?: string | number;
  borderRadius?: number;
  padding?: Padding;
  fontSize?: number;
  fontColor?: string | Color;
  backgroundColor?: string | Color;
  border?: BorderOptions;
}

function getColor(color: DColor) {
  switch (color) {
    case 'default':
      return Color.White
    case 'primary':
      return '#ff4490f6'
    case 'success':
      return '#ff65ee78'
    case 'warning':
      return '#ffeacf48'
    case 'danger':
      return '#ffea3c3c'
    default:
      return color
  }
}

class DButtonModifier implements AttributeModifier<ButtonAttribute> {
  color: DColor = 'default'
  fill: DFill = 'Solid'
  mode: DMode = 'Small'
  customStyle?: DCustomStyle

  applyNormalAttribute(instance: ButtonAttribute): void {
    instance.backgroundColor(getColor(this.color))
    switch (this.fill) {
      case 'Solid':
        break;
      case 'Outline':
        instance.backgroundColor(Color.White)
          .border({ width: 1, color: getColor(this.color) })
          .fontColor(getColor(this.color))
        break
      case 'None':
        instance.backgroundColor(Color.White).border({ width: 0 }).fontColor(getColor(this.color))
    }
    instance.borderRadius(6)
    switch (this.mode) {
      case 'Mini':
        instance.fontSize(16).padding({ left: 15, right: 15 })
        break
      case 'Small':
        instance.fontSize(20).padding({ left: 22, right: 22 })
        break
      case 'Middle':
        instance.fontSize(24).padding({
          top: 8,
          bottom: 8,
          left: 28,
          right: 28
        })
        break
      case 'Large':
        instance.fontSize(28)
          .padding({
            top: 12,
            bottom: 12,
            left: 34,
            right: 34
          })
        break
    }
    //   ----
    // 应用自定义样式（覆盖默认样式）
    if (this.customStyle) {
      // 宽度
      if (this.customStyle.width !== undefined) {
        if (typeof this.customStyle.width === 'string') {
          instance.width(this.customStyle.width)
        } else {
          instance.width(this.customStyle.width)
        }
      }

      // 高度
      if (this.customStyle.height !== undefined) {
        if (typeof this.customStyle.height === 'string') {
          instance.height(this.customStyle.height)
        } else {
          instance.height(this.customStyle.height)
        }
      }

      // 圆角
      if (this.customStyle.borderRadius !== undefined) {
        instance.borderRadius(this.customStyle.borderRadius)
      }

      // 内边距
      if (this.customStyle.padding) {
        const padding = this.customStyle.padding
        instance.padding({
          top: padding.top !== undefined ? padding.top : undefined,
          bottom: padding.bottom !== undefined ? padding.bottom : undefined,
          left: padding.left !== undefined ? padding.left : undefined,
          right: padding.right !== undefined ? padding.right : undefined,
        })
      }

      // 字体大小
      if (this.customStyle.fontSize !== undefined) {
        instance.fontSize(this.customStyle.fontSize)
      }

      // 字体颜色
      if (this.customStyle.fontColor !== undefined) {
        instance.fontColor(this.customStyle.fontColor)
      }

      // 背景色
      if (this.customStyle.backgroundColor !== undefined) {
        instance.backgroundColor(this.customStyle.backgroundColor)
      }

      // 边框
      if (this.customStyle.border) {
        const border = this.customStyle.border
        instance.border({
          width: border.width !== undefined ? border.width : 1, // 默认边框宽度
          color: border.color !== undefined ? border.color : Color.Black // 默认边框颜色
        })
      }
    }
  }
}

@Component
export struct DButton {
  modifier = new DButtonModifier()
  @Prop text: string = '确认'
  @Prop color: DColor = "primary"
  @Prop fill: DFill = "Solid"
  @Prop mode: DMode = 'Small'
  @Prop customStyle: DCustomStyle // 新增自定义样式属性

  build() {
    Button(this.text).attributeModifier(this.modifier).type(ButtonType.Normal)
  }

  aboutToAppear(): void {
    this.modifier.color = this.color
    this.modifier.fill = this.fill
    this.modifier.mode = this.mode
    this.modifier.customStyle = this.customStyle
  }
}
