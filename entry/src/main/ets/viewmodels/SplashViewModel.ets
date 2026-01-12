import { BaseViewModel } from 'core';

@ObservedV2
export class SplashViewModel extends BaseViewModel {
  //@Trace init: boolean = false; //You can manage parameters here so it will effect screen

  async splashStart() {

    const result: boolean = await new Promise((resolve: Function) => {
      setTimeout(() => {
        resolve(true);
      }, 3000);

    });

    // in upper method there can be inital operation like fetching device info from backend
    // when everything fetched successfully it will dashboard
    // So Its just a simulation
    if (result) {
      this.navigateToPage('Dashboard');
    }

  }
}