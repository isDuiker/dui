import { DButton, DNavBar, DialogUtil } from '@duiker/uil'

@Builder
function Custom() {
  Row() {
    Text('CUSTOM')
  }
}

@Entry
@Component
struct Index {
  @State message: string = 'Hello World';

  build() {
    Column() {
      DNavBar({ title: '我是导航栏' })
      DButton({ text: 'Hello!' })
      Button('基础弹框').onClick(() => {
        DialogUtil.open(this.getUIContext(), {
          title: "基础弹框",
          content: "支持函数调用和组件调用两种方式。",
          onCancel() {
            console.log('我关闭了')
          },
          onConfirm() {
            console.log('点击了确定')
          }
        })
      })
    }
    .height('100%')
    .width('100%')
    .backgroundColor('#f3f3f3')
  }
}