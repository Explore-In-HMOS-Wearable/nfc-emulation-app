import { NavigationService } from '../services/NavigationService';

@ObservedV2
export class BaseViewModel {
  protected nav: NavigationService = NavigationService.getInstance();

  navigateToPage(route: string, params?: Object): void {
    this.nav.push(route, params);
  }

  navigateAndClearStack(route: string, params?: Object): void {
    this.nav.push(route, params, true);
  }

  get navigation(): NavigationService {
    return this.nav;
  }
}