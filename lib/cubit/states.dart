import 'package:green_bin/models/user_model.dart';

abstract class AppStates {}

class AppIntialState extends AppStates {}

class AppChangeNavBarState extends AppStates {}

class AppRegisterLoadingState extends AppStates {}

class AppRegisterSucsessState extends AppStates {
  final userModel model;
  AppRegisterSucsessState(this.model);
}

class AppRegisterErorrtate extends AppStates {}

class AppLoginLoadingState extends AppStates {}

class AppLoginSucsessState extends AppStates {
  final userModel model;
  AppLoginSucsessState(this.model);
}

class AppLoginErorrtate extends AppStates {}

class AppUpdateProfileLoadingState extends AppStates {}

class AppUpdateProfileSucsessState extends AppStates {}

class AppUpdateProfileErorrState extends AppStates {}

class AppChangePasswordState extends AppStates {}

//for update  password
class AppUpdatePasswordLoadingState extends AppStates {}

class AppUpdatePasswordSucsessState extends AppStates {}

class AppUpdatePasswordErorrState extends AppStates {}

//for confirm new password from forget

class AppConfirmPasswordLoadingState extends AppStates {}

class AppConfirmPasswordSucsessState extends AppStates {}

class AppConfirmPasswordErorrState extends AppStates {}

class AppPickedProfileImageSucsessState extends AppStates {}

class AppPickedProfileImageErorrState extends AppStates {}

class AppVerfiySmsCodeLoadingState extends AppStates {}

class AppVerfiySmsCodeSucsessState extends AppStates {
  final userModel model;
  AppVerfiySmsCodeSucsessState(this.model);
}

class AppVerfiySmsCodeErorrtate extends AppStates {}

class AppSendForgetCofeLoadingState extends AppStates {}

class AppSendForgetCofeSucsessState extends AppStates {
  final userModel model;
  AppSendForgetCofeSucsessState(this.model);
}

class AppSendForgetCofeErorrtate extends AppStates {}

class AppVerfiyEmailCodeLoadingState extends AppStates {}

class AppVerfiEmailsCodeSucsessState extends AppStates {
  final userModel model;
  AppVerfiEmailsCodeSucsessState(this.model);
}

class AppVerfiyEmailCodeErorrtate extends AppStates {}

class AppPostTrashLoadingState extends AppStates {}

class AppPostTrashSucsessState extends AppStates {}

class AppPostTrashErorrtate extends AppStates {}

class AppPostExchangeProductsLoadingState extends AppStates {}

class AppPostExchangeProductsSucsessState extends AppStates {}

class AppPostExchangeProductsErorrtate extends AppStates {}

class AppPostBuyOldLoadingState extends AppStates {}

class AppPostBuyOldSucsessState extends AppStates {}

class AppPostBuyOldErorrtate extends AppStates {}

class AppOnStepTappedTrashSucsessState extends AppStates {}

class AppOnStepTappedBuyOldSucsessState extends AppStates {}

class AppOnStepTappedCleanerSucsessState extends AppStates {}

class AppOnContinueTrashSucsessState extends AppStates {}

class AppOnContinueBuyOldSucsessState extends AppStates {}

class AppOnContinueCleanerSucsessState extends AppStates {}

class AppSelectLocation1TrashSucsessState extends AppStates {}

class AppSelectLocation2TrashSucsessState extends AppStates {}

class AppSelectLocation3TrashSucsessState extends AppStates {}

class AppReturnOrderDataTrashSucsessState extends AppStates {}

class AppReturnOrderDataCleanerSucsessState extends AppStates {}

class AppReturnOrderDataButOldSucsessState extends AppStates {}

class AppReturnAvilablePlanTrashSucsessState extends AppStates {}

class AppPostCleanerLoadingState extends AppStates {}

class AppPostCleanerSucsessState extends AppStates {}

class AppPostCleanerErorrtate extends AppStates {}

class AppDeleteNotificationsLoadingState extends AppStates {}

class AppDeleteNotificationsSucsessState extends AppStates {}

class AppDeleteNotificationsErorrtate extends AppStates {}

class AppConnectLoctionSucsessState extends AppStates {}

class AppGetLocationCleanerLoadingState extends AppStates {}

class AppGetLocationCleanerSucsessState extends AppStates {}

class AppInitailbottomtabBarExchangeProductsSucsessState extends AppStates {}

class ChangeBottomTabBaExchangeProductsState extends AppStates {
  final bool cleanProducts;
  final bool houseWare;

  ChangeBottomTabBaExchangeProductsState(this.cleanProducts, this.houseWare);
}

class AppInitailbottomtabBarBuyOldSucsessState extends AppStates {}

class ChangeBottomTabBarBuyOldState extends AppStates {
  final bool paper;
  final bool metal;
  final bool elec;
  ChangeBottomTabBarBuyOldState(this.elec, this.metal, this.paper);
}

class AppAddKillosPaperBuyOldSucsessState extends AppStates {}

class AppMiunsKillosPaperBuyOldSucsessState extends AppStates {}

class AppAddKillosMetalsBuyOldSucsessState extends AppStates {}

class AppMiunsKillosMetalsBuyOldSucsessState extends AppStates {}

class AppAddKillosElecBuyOldSucsessState extends AppStates {}

class AppMiunsKillosElecBuyOldSucsessState extends AppStates {}

class AppSelectPlanSucsessState extends AppStates {}

class AppTotalMoneyBuyOldSucsessState extends AppStates {}

class AppAddCleanProductsSucsessState extends AppStates {}

class AppMiunsCleanProductsSucsessState extends AppStates {}

class AppAddHouseWareSucsessState extends AppStates {}

class AppMiunsHouseWareSucsessState extends AppStates {}

class AppLoginWithFacebookLoadingState extends AppStates {}

class AppLoginWithFacebookSucsessState extends AppStates {}

class AppLoginWithGoogleLoadingState extends AppStates {}

class AppLoginWithGoogleSucsessState extends AppStates {}

class AppRemmbermeCheckBoxSucsessState extends AppStates {}

class AppAddCartItemSucsessState extends AppStates {}

class AppMiunsCartItemSucsessState extends AppStates {}

class AppRemoveItemFromCartSucsessState extends AppStates {}

class AppRemoveLastAddItemSucsessState extends AppStates {}

class AppAllPointsItemCartSucsessState extends AppStates {}
