@ObservedV2
export class NavigationService {
  private static _instance: NavigationService;
  @Trace public stack: NavPathStack = new NavPathStack();

  private constructor() {}
  static getInstance(): NavigationService {
    if (!NavigationService._instance) {
      NavigationService._instance = new NavigationService();
    }
    return NavigationService._instance;
  }

  push(name: string, params?: Object, clearStack = false): void {
    if (clearStack) {
      this.stack.clear();
    }

    this.stack.pushPathByName(name, params);
  }

  pushWithCallback(
    name: string,
    params?: Object,
    onPop?: (info: PopInfo) => void,
    animated = true
  ): void {
    this.stack.pushPathByName(name, params, onPop, animated);
  }

  replace(name: string, params?: Object): void {
    this.stack.replacePathByName(name, params);
  }

  pop(): void {
    this.stack.pop();
  }

  // Additional utilities as needed
  getCurrentRoute(): string | undefined {
    const routes = this.stack.getAllPathName();
    return routes[routes.length - 1];
  }
}