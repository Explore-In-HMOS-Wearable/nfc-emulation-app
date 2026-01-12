import { SplashViewModel } from '../viewmodels/SplashViewModel';
import { CoreModule } from 'core';

@Component
export struct SplashPage {
  splashVm: SplashViewModel = new SplashViewModel();
  coreModule: CoreModule = new CoreModule();

  aboutToAppear(): void {
    this.splashVm.navigateToPage('PinEntry');
  }

  build() {
    Column() {
      Text('Loading...')
        .fontSize(14)
        .fontWeight(FontWeight.Bold)
        .alignRules({
          center: { anchor: '__container__', align: VerticalAlign.Center },
          middle: { anchor: '__container__', align: HorizontalAlign.Center }
        })
    }.justifyContent(FlexAlign.Center).height('100%').width('100%').linearGradient({
      direction: GradientDirection.Bottom,
      colors: [
        [this.coreModule.commonColors.baseBackgroundGradientStart, 0.0],
        [this.coreModule.commonColors.baseBackgroundGradientEnd, 1]
      ]
    })
  }
}