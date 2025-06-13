import { router } from "@kit.ArkUI"

@Component
export struct DNavBar {
  //------------------- 必传属性 -------------------
  @Require title: string = ''     // 导航栏标题（必传）

  //------------------- 可选属性 -------------------
  @Prop showBack: boolean         // 是否显示返回按钮（默认：true）
  @Prop statusBarHeight: number   // 状态栏高度（默认：0）

  //------------------- 事件回调 -------------------
  @Prop onBackClick: () => void   // 返回按钮点击回调
  @Prop onMoreClick: () => void   // 右侧按钮点击回调

  // 设置默认值
  safeStatusBarHeight = this.statusBarHeight ?? 0
  safeShowBack = this.showBack ?? true
  build() {

    Column() {
      // 1. 状态栏占位
      Blank()
        .height(this.safeStatusBarHeight)
        .width('100%')
        .backgroundColor(Color.Transparent)

      // 2. 导航主体
      Row() {
        // 左侧：返回按钮/占位
        if (this.safeShowBack) {
          Image($r('app.media.uil_icon_back'))
            .width(16)
            .height(16)
            .margin({ left: 16 })
            .onClick(() => {
              // 优先执行自定义回调
              if(this.onBackClick!==undefined){
                this.onBackClick()
              }else{
                router.back()
              }
            })
        } else {
          Blank().width(24).margin({ left: 16 })
        }

        // 中间：标题 (flex布局撑满剩余空间)
        Text(this.title)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .maxLines(1)
          .margin({ left: 12, right: 12 })
          .layoutWeight(1)       // 关键：自动填充中间区域
          .textAlign(TextAlign.Center)

        // 右侧：操作按钮/占位
        if (this.onMoreClick) {
          Image($r('app.media.uil_icon_back')) // 建议更换为更多图标
            .width(24)
            .height(24)
            .margin({ right: 16 })
            .onClick(() => this.onMoreClick!())
        } else {
          Blank().width(24).margin({ right: 16 })
        }
      }
      .width('100%')
      .height(48)
      .backgroundColor(Color.Transparent)

      // 3. 底部分割线
      Divider()
        .strokeWidth(0.5)
        .color('#F0F0F0')
    }
  }
}