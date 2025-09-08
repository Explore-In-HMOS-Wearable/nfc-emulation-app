import { CoreModule } from 'core';
import { SplashPage } from './SplashPage';
import {HCEPage} from './HCEPage'

@Entry
@Component
struct Index {
  coreModule: CoreModule = new CoreModule();

  @Builder
  routeMap(name: string) {
    NavDestination() {

      if (name === 'Splash') {
        SplashPage();
      } else {
        HCEPage();
      }

    }
    .hideTitleBar(true)
  }

  build() {
    Navigation(this.coreModule.navigationService.stack) {
      SplashPage();
    }
    .linearGradient({
      direction: GradientDirection.Bottom,
      colors: [[this.coreModule.commonColors.baseBackgroundGradientStart, 0.0],
        [this.coreModule.commonColors.baseBackgroundGradientEnd, 1],]
    })
    .navDestination(this.routeMap)
    .ignoreLayoutSafeArea()
    .hideTitleBar(true)
    .width('100%')
    .height('100%')
  }
}