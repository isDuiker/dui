import { ComponentContent, PromptAction } from "@kit.ArkUI";
import { DButton } from './DButton'

interface DialogOption {
  title: string;
  content: string
  onCancel?: () => void
  onConfirm?: () => void
  contentBuilder?: WrappedBuilder<[]>
}

@Builder
function ComponentContentBuilder(dialogOption: DialogOption) {
  Column() {
    Text(dialogOption.title).fontSize(22).fontWeight(700)
    Row() {
      if (dialogOption.contentBuilder) {
        dialogOption.contentBuilder?.builder()
      } else {
        Text(dialogOption.content).fontSize(16)
      }
    }.width('100%').margin({ top: "30lpx", bottom: "30lpx" })

    Row() {
      DButton({
        text: '取消',
        color: '#c2c4cc',
        fill: 'Outline',
        customStyle: { width: '47%', fontColor: Color.Black }
      }).onClick(() => {
        DialogUtil.dismiss()
        dialogOption.onCancel?.()
      })
      DButton({ text: '确认', color: 'danger', customStyle: { width: '47%' } }).onClick(() => {
        DialogUtil.dismiss()
        dialogOption.onConfirm?.()
      })
    }.width('100%').justifyContent(FlexAlign.SpaceBetween)
  }
  .width('80%')
  .backgroundColor(Color.White)
  .padding(25)
  .borderRadius(10)
}

export class DialogUtil {
  private static promptAction: PromptAction;
  private static componentContent: ComponentContent<object>

  static open(uiContext: UIContext, config: DialogOption) {
    DialogUtil.componentContent =
      new ComponentContent(uiContext, wrapBuilder(ComponentContentBuilder), config)
    DialogUtil.promptAction = uiContext.getPromptAction()
    DialogUtil.promptAction.openCustomDialog(DialogUtil.componentContent, {
      autoCancel: false
    })
  }

  static dismiss() {
    DialogUtil.promptAction.closeCustomDialog(DialogUtil.componentContent)
  }
}