import { CommonColors } from '../constants/CommonColors';
import { CommonFloats } from '../constants/CommonFloats';
import { CommonMedia } from '../constants/CommonMedia';
import { CommonStrings } from '../constants/CommonStrings';
import { NavigationService } from '../services/NavigationService';


export class CoreModule {
  static _instance: CoreModule;

  static getInstance() {
    if (!CoreModule._instance) {
      CoreModule._instance = new CoreModule();
    }
    return CoreModule._instance;
  }


  commonColors: CommonColors = new CommonColors();
  commonMedia: CommonMedia = new CommonMedia();
  commonStrings: CommonStrings = new CommonStrings();
  commonFloats: CommonFloats = new CommonFloats();


  private _navigationService?: NavigationService;

  get navigationService(): NavigationService {
    if (!this._navigationService) {
      this._navigationService = NavigationService.getInstance();
    }
    return this._navigationService;
  }
}
