import { hilog } from '@kit.PerformanceAnalysisKit';
import { promptAction } from '@kit.ArkUI';
import { CommonFloats } from 'core/src/main/ets/constants/CommonFloats';

@Component
export struct HCEPage {
  @State status: string = 'NFC HCE not supported';
  @State isEmulating: boolean = false;
  @State cardName: string = 'Access Card';
  @State lastTransaction: string = '';
  @State showWarning: boolean = true;

  private floats: CommonFloats = new CommonFloats();

  aboutToAppear() {
    this.checkNFCSupport();
  }

  private checkNFCSupport(): void {
    try {
      hilog.info(0x0000, 'HCE', 'Checking NFC support on wearable device');
      this.status = 'NFC HCE not available';
      this.showWarning = true;
    } catch (error) {
      hilog.error(0x0000, 'HCE', `Error checking NFC support: ${error}`);
    }
  }

  private simulateEmulation(): void {
    if (this.isEmulating) return;
    this.isEmulating = true;
    this.status = 'Simulating...';
    this.showWarning = false;
    hilog.info(0x0000, 'HCE', 'Starting simulated card emulation');
    this.simulateTransactions();
    promptAction.showToast({ message: 'Simulation started' });
  }

  private simulateTransactions(): void {
    const transactions = ['SELECT application', 'Auth request', 'Read data', 'Complete'];
    let index = 0;
    const interval = setInterval(() => {
      if (!this.isEmulating || index >= transactions.length) {
        clearInterval(interval);
        return;
      }
      this.lastTransaction = transactions[index];
      this.status = `Sim: ${transactions[index]}`;
      hilog.info(0x0000, 'HCE', `Simulated transaction: ${transactions[index]}`);
      index++;
    }, 2000);
  }

  private stopSimulation(): void {
    this.isEmulating = false;
    this.status = 'Stopped';
    this.lastTransaction = '';
    hilog.info(0x0000, 'HCE', 'Stopped simulated card emulation');
    promptAction.showToast({ message: 'Simulation stopped' });
  }

  build() {
    Stack({ alignContent: Alignment.Top }) {
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor('#121212')
        .clip(new Circle({ width: '100%', height: '100%' }))

      Scroll() {
        Column({ space: this.floats.smallMargin }) {
          Column({ space: this.floats.smallMargin }) {
            Text('NFC Emulator')
              .fontSize(this.floats.titleFontSize)
              .fontWeight(FontWeight.Bold)
              .fontColor(Color.White)
              .textAlign(TextAlign.Center)
              .width('90%')
              .maxLines(1)
              .textShadow({ radius: 5, color: '#00B8D4' })

            Text(this.cardName)
              .fontSize(this.floats.headerFontSize)
              .fontColor('#4CAF50')
              .textAlign(TextAlign.Center)
              .width('90%')
              .maxLines(1)
          }
          .margin({ top: this.floats.mediumMargin })
          .width('100%')
          .alignItems(HorizontalAlign.Center)

          Column({ space: this.floats.smallMargin }) {
            Row() {
              Circle({ width: 8, height: 8 })
                .fill(this.isEmulating ? '#4CAF50' : '#757575')
                .margin({ right: 4 })

              Text(this.isEmulating ? 'ACTIVE' : 'INACTIVE')
                .fontSize(this.floats.normalFontSize)
                .fontColor(this.isEmulating ? '#4CAF50' : '#757575')
                .fontWeight(FontWeight.Medium)
            }
            .justifyContent(FlexAlign.Center)
            .padding({ top: 4, bottom: 4, left: 8, right: 8 })
            .backgroundColor('#1A1A1A')
            .borderRadius(1)

            Text(this.status)
              .fontSize(this.floats.normalFontSize)
              .fontColor('#E0E0E0')
              .textAlign(TextAlign.Center)
              .maxLines(2)
              .textOverflow({ overflow: TextOverflow.Ellipsis })
              .width('90%')
          }
          .justifyContent(FlexAlign.Center)
          .width('100%')
          .margin({ bottom: this.floats.smallMargin })

          Column({ space: this.floats.smallMargin }) {
            if (this.showWarning) {
              Column({ space: this.floats.smallMargin }) {
                Text('⚠️ Notice')
                  .fontSize(this.floats.headerFontSize)
                  .fontColor('#FFC107')
                  .fontWeight(FontWeight.Medium)
                  .textAlign(TextAlign.Center)

                Text(
                  "Wearables don't support full NFC HCE APIs."
                )
                  .fontSize(this.floats.normalFontSize)
                  .fontColor('#FFAB00')
                  .textAlign(TextAlign.Center)
                  .maxLines(3)
                  .textOverflow({ overflow: TextOverflow.Ellipsis })
              }
              .backgroundColor('#1A1A00')
              .borderRadius(6)
              .padding(this.floats.smallMargin)
              .width('85%')
              .margin({ top: this.floats.smallMargin })
              .border({ width: 1, color: '#4CAF50' })
            }

            if (this.lastTransaction) {
              Column({ space: 4 }) {
                Text('Last Action:')
                  .fontSize(this.floats.normalFontSize)
                  .fontColor('#BDBDBD')
                  .textAlign(TextAlign.Center)

                Text(this.lastTransaction)
                  .fontSize(this.floats.normalFontSize)
                  .fontColor('#FFC107')
                  .textAlign(TextAlign.Center)
                  .maxLines(1)
                  .textOverflow({ overflow: TextOverflow.Ellipsis })
              }
              .width('90%')
              .margin({ top: this.floats.smallMargin })
              .padding(this.floats.smallMargin)
              .backgroundColor('#0A0A0A')
              .borderRadius(6)
            }

            Column({ space: this.floats.smallMargin }) {
              Text('NFC on Wearables:')
                .fontSize(this.floats.normalFontSize)
                .fontColor('#BDBDBD')
                .fontWeight(FontWeight.Medium)
                .textAlign(TextAlign.Center)

              Text(
                '• Payment apps (Huawei Pay)\n• System-level services\n• Limited to approved apps\n• No public HCE API access\n• Requires special permissions'
              )
                .fontSize(this.floats.normalFontSize)
                .fontColor('#9E9E9E')
                .textAlign(TextAlign.Center)
                .lineHeight(14)
            }
            .alignItems(HorizontalAlign.Center)
            .width('85%')
            .backgroundColor('#0A0A0A')
            .borderRadius(6)
            .padding(this.floats.smallMargin)
            .margin({ top: this.floats.smallMargin, bottom: this.floats.mediumMargin })
            .shadow({ radius: 8, color: '#000000', offsetX: 0, offsetY: 4 })
          }
          .width('100%')
          .alignItems(HorizontalAlign.Center)

          Column({ space: this.floats.smallMargin }) {
            Button(this.isEmulating ? 'Simulating...' : 'Start', { type: ButtonType.Capsule })
              .width(this.floats.buttonWidth)
              .height(this.floats.buttonHeight)
              .backgroundColor(this.isEmulating ? '#2E7D32' : '#4CAF50')
              .fontSize(this.floats.normalFontSize)
              .enabled(!this.isEmulating)
              .opacity(this.isEmulating ? 0.7 : 1.0)
              .onClick(() => this.simulateEmulation())
              // .transition({ type: TransitionType.All, curve: Curve.EaseInOut, duration: 200 })

            Button('Stop', { type: ButtonType.Capsule })
              .width(this.floats.buttonWidth)
              .height(this.floats.buttonHeight)
              .backgroundColor('#E53935')
              .fontSize(this.floats.normalFontSize)
              .enabled(this.isEmulating)
              .opacity(this.isEmulating ? 1.0 : 0.5)
              .onClick(() => this.stopSimulation())
              // .transition({ type: TransitionType.All, curve: Curve.EaseInOut, duration: 200 })
          }
          .justifyContent(FlexAlign.End)
          .margin({ bottom: this.floats.mediumMargin, top: this.floats.smallMargin })
          .width('100%')
          .alignItems(HorizontalAlign.Center)
        }
        .width('100%')
        .padding({ left: this.floats.smallMargin, right: this.floats.smallMargin })
      }
      .scrollable(ScrollDirection.Vertical)
      .scrollBar(BarState.Off)
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('transparent')
  }
}