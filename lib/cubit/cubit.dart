// import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:geocoding/geocoding.dart' as geocodeing;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:green_bin/const/end_points.dart';
import 'package:green_bin/const/iconbroken.dart';
import 'package:green_bin/cubit/states.dart';
import 'package:green_bin/models/location_model.dart';
import 'package:green_bin/models/notification_model.dart';
import 'package:green_bin/models/user_facbook_model.dart';
import 'package:green_bin/models/user_model.dart';
import 'package:green_bin/screens/cart/cart_screen.dart';
import 'package:green_bin/screens/exchange_products/exchange_products_items.dart';
import 'package:green_bin/screens/layout_screen.dart';
import 'package:green_bin/screens/notifications_screen.dart';
import 'package:green_bin/shared/dio_helper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart' as location;

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppIntialState());

  static AppCubit get(context) => BlocProvider.of(context);

  List<Widget> screens = [
    const LayoutScreen(),
    const NotificationsScreen(),
    const CartScreen(),
  ];

  int currentIndex = 0;

  void changeBottomNAvBAr(int index) {
    currentIndex = index;
    if (index == 1) getNotif();
    emit(AppChangeNavBarState());
  }

  userModel? user;

  void register({
    required String name,
    required String email,
    required String mobile,
    required String password,
  }) {
    emit(AppRegisterLoadingState());
    DioHelper.postData(
      url: REGISTER,
      data: {
        'name': name,
        'email': email,
        'mobile': mobile,
        'password': password,
        'firebase_token': firebasetoken,
      },
    ).then((value) {
      user = userModel.FromJson(value.data);

      emit(AppRegisterSucsessState(user!));
    }).catchError((erorr) {
      print(erorr.toString());
      emit(AppRegisterErorrtate());
    });
  }

  void verfiySmsCode({
    required int? uId,
    required String smsCode,
  }) {
    emit(AppVerfiySmsCodeLoadingState());
    DioHelper.postData(
      url: SMSCODE,
      data: {
        'user_id': uId,
        'active_code': smsCode,
      },
    ).then((value) {
      print(value.data);
      user = userModel.FromJson(value.data);
      emit(AppVerfiySmsCodeSucsessState(user!));
    }).catchError((erorr) {
      print(erorr.toString());
      emit(AppVerfiySmsCodeErorrtate());
    });
  }

  void sendEmailForgetPassword({
    required String email,
  }) {
    emit(AppSendForgetCofeLoadingState());
    DioHelper.postData(
      url: FORGETPASSWORD,
      data: {
        'email': email,
      },
    ).then((value) {
      user = userModel.FromJson(value.data);
      print(user!.data.message);
      emit(AppSendForgetCofeSucsessState(user!));
    }).catchError((erorr) {
      print(erorr.toString());
      emit(AppSendForgetCofeErorrtate());
    });
  }

  void verfiyEmailCode({
    required int? uId,
    required String emailCode,
  }) {
    emit(AppVerfiyEmailCodeLoadingState());
    DioHelper.postData(
      url: EMAILCODE,
      data: {
        'user_id': uId,
        'forget_code': emailCode,
      },
    ).then((value) {
      print(value.data);
      user = userModel.FromJson(value.data);
      emit(AppVerfiEmailsCodeSucsessState(user!));
    }).catchError((erorr) {
      print(erorr.toString());
      emit(AppVerfiyEmailCodeErorrtate());
    });
  }

  void userLogin({
    required String email,
    required String password,
  }) {
    emit(AppLoginLoadingState());
    DioHelper.postData(
      url: LOGIN,
      data: {
        'email': email,
        'password': password,
        'firebase_token': firebasetoken,
      },
    ).then((value) {
      user = userModel.FromJson(value.data);
      print(user!.data.message);
      emit(AppLoginSucsessState(user!));
    }).catchError((erorr) {
      print(erorr.toString());
      emit(AppLoginErorrtate());
    });
  }

  void updateProfile({
    required String name,
    required String birth_date,
    required String mobile,
    required String email,
    required String gender,
    required String? image,
  }) {
    emit(AppUpdateProfileLoadingState());
    DioHelper.postData(
      url: UPDATEPROFIEL,
      token: apiToken,
      data: {
        'name': name,
        'mobile': mobile,
        'email': email,
        'birth_date': birth_date,
        'gender': gender,
        'image': image
      },
    ).then((value) {
      user = userModel.FromJson(value.data);
      //     print(value.data);
      emit(AppUpdateProfileSucsessState());
    }).catchError((erorr) {
      print(erorr.toString());
      emit(AppUpdateProfileErorrState());
    });
  }

  File? image;
  final ImagePicker picker = ImagePicker();

  Future<void> pickedProfileImage() async {
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      image = File(pickedImage.path);
      emit(AppPickedProfileImageSucsessState());
    } else {
      print('NOt Image Selceted');
      emit(AppPickedProfileImageErorrState());
    }
  }

  bool currentPassword = true;
  bool changePassword = true;
  bool secondchangePassword = true;
  bool loginPassword = true;

  bool restnewPassword = true;
  bool confirmNewPassword = true;

  bool registerPassword = true;

  IconData? sufixicon1 = IconBroken.Hide;
  IconData? sufixicon2 = IconBroken.Hide;
  IconData? sufixicon3 = IconBroken.Hide;
  IconData? loginSufixicon = IconBroken.Hide;
  IconData? restNewsufixicon = IconBroken.Hide;
  IconData? confirmrRestSufixicon = IconBroken.Hide;
  IconData? registerSufixicon = IconBroken.Hide;

  void visableEyeLoginPassword() {
    loginPassword = !loginPassword;
    loginSufixicon =
        loginPassword ? IconBroken.Hide : Icons.visibility_outlined;

    emit(AppChangePasswordState());
  }

  void visableEyeRegisterPassword() {
    registerPassword = !registerPassword;
    registerSufixicon =
        registerPassword ? IconBroken.Hide : Icons.visibility_outlined;

    emit(AppChangePasswordState());
  }

  void visableEyeRestNewPassword() {
    restnewPassword = !restnewPassword;
    restNewsufixicon =
        restnewPassword ? IconBroken.Hide : Icons.visibility_outlined;

    emit(AppChangePasswordState());
  }

  void visableEyeConfirmRestNewPassword() {
    confirmNewPassword = !confirmNewPassword;
    confirmrRestSufixicon =
        confirmNewPassword ? IconBroken.Hide : Icons.visibility_outlined;

    emit(AppChangePasswordState());
  }

  void visableEyeCurrentPassword() {
    currentPassword = !currentPassword;
    sufixicon1 = currentPassword ? IconBroken.Hide : Icons.visibility_outlined;

    emit(AppChangePasswordState());
  }

  void visableEyeChangePassword() {
    changePassword = !changePassword;
    sufixicon2 = changePassword ? IconBroken.Hide : Icons.visibility_outlined;

    emit(AppChangePasswordState());
  }

  void visableEyeSecondChangePassword() {
    secondchangePassword = !secondchangePassword;
    sufixicon3 =
        secondchangePassword ? IconBroken.Hide : Icons.visibility_outlined;

    emit(AppChangePasswordState());
  }

  void updatePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  }) {
    emit(AppUpdatePasswordLoadingState());
    DioHelper.postData(
      url: UPDATEPASSWORD,
      token: apiToken,
      data: {
        'current_password': currentPassword,
        'new_password': newPassword,
        'new_password_confirmation': confirmPassword,
      },
    ).then((value) {
      emit(AppUpdatePasswordSucsessState());
    }).catchError((erorr) {
      print(erorr.toString());
      emit(AppUpdatePasswordErorrState());
    });
  }

  void confirmPassword({
    required int? userId,
    required String newPassword,
    required String confirmPassword,
  }) {
    emit(AppConfirmPasswordLoadingState());
    DioHelper.postData(
      url: CONFIRMPASSWORD,
      token: apiToken,
      data: {
        'user_id': userId,
        'password': newPassword,
        'password_confirmation': confirmPassword,
      },
    ).then((value) {
      //  user = userModel.FromJson(value.data);
      //  print(value.data);
      emit(AppConfirmPasswordSucsessState());
    }).catchError((erorr) {
      print(erorr.toString());
      emit(AppConfirmPasswordErorrState());
    });
  }

  late NotificationModel notificationModel;

  void getNotif() {
    DioHelper.getData(
      url: NOTIFICATIONS,
      token: apiToken,
    ).then((value) {
      notificationModel = NotificationModel.FromJson(value.data);
    }).catchError((erorr) {
      print(erorr.toString());
    });
  }

  void deleteNotification({
    required String? Id,
  }) {
    emit(AppDeleteNotificationsLoadingState());
    DioHelper.postData(
      url: '$DELETENOTIFICATIONS$Id',
      token: apiToken,
    ).then((value) {
      getNotif();
      emit(AppDeleteNotificationsSucsessState());
    }).catchError((erorr) {
      print(erorr.toString());
      emit(AppDeleteNotificationsErorrtate());
    });
  }

  List<String> items = [
    'Company',
    'Home',
  ];
  List<String> reucleItem = [
    'Recycable ',
    'Not-Recycable ',
  ];

  bool selectedPlan1 = false;
  bool selectedPlan2 = false;
  bool selectedPlan3 = false;

  void selectPlan1() {
    selectedPlan1 = !selectedPlan1;
    selectedPlan2 = false;
    selectedPlan3 = false;

    if (selectedPlan1 == true) {
      monthsPlanone = true;
      daysperWeekPlanOne = true;
      gagggPlanOne = true;
      monthsPlanTwo = false;
      daysperWeekPlanTwo = false;
      gagggPlanTwo = false;
      monthsPlanThree = false;
      daysperWeekPlanThree = false;
      gagggPlanThree = false;
    }
    if (selectedPlan1 == false) {
      monthsPlanone = false;
      daysperWeekPlanOne = false;
      gagggPlanOne = false;
    }

    emit(AppSelectPlanSucsessState());
  }

  void selectPlan2() {
    selectedPlan2 = !selectedPlan2;
    selectedPlan1 = false;
    selectedPlan3 = false;

    if (selectedPlan2 == true) {
      monthsPlanTwo = true;
      daysperWeekPlanTwo = true;
      gagggPlanTwo = true;

      monthsPlanone = false;
      daysperWeekPlanOne = false;
      gagggPlanOne = false;
      monthsPlanThree = false;
      daysperWeekPlanThree = false;
      gagggPlanThree = false;
    }
    if (selectedPlan2 == false) {
      monthsPlanTwo = false;
      daysperWeekPlanTwo = false;
      gagggPlanTwo = false;
    }
    emit(AppSelectPlanSucsessState());
  }

  void selectPlan3() {
    selectedPlan3 = !selectedPlan3;
    selectedPlan2 = false;
    selectedPlan1 = false;
    if (selectedPlan3 == true) {
      monthsPlanThree = true;
      daysperWeekPlanThree = true;
      gagggPlanThree = true;

      monthsPlanone = false;
      daysperWeekPlanOne = false;
      gagggPlanOne = false;
      monthsPlanTwo = false;
      daysperWeekPlanTwo = false;
      gagggPlanTwo = false;
    }
    if (selectedPlan3 == false) {
      monthsPlanThree = false;
      daysperWeekPlanThree = false;
      gagggPlanThree = false;
    }
    emit(AppSelectPlanSucsessState());
  }

  String? recycleValue;
  String? placeValueCleaner;

  List<String> itemmoney = [
    '150 EGP/ Once',
  ];
  String? currentValuemoney;

  bool isChoosen1 = false;

  bool isChoosen2 = false;

  bool isChoosen3 = false;

  void selcetLocation1() {
    isChoosen1 = !isChoosen1;
    emit(AppSelectLocation1TrashSucsessState());
  }

  void selcetLocation2() {
    isChoosen2 = !isChoosen2;
    emit(AppSelectLocation2TrashSucsessState());
  }

  void selcetLocation3() {
    isChoosen3 = !isChoosen3;
    emit(AppSelectLocation3TrashSucsessState());
  }

  int trashcurrnetStep = 0;
  int cleanerCurrnetStep = 0;
  int buyOldCurrnetStep = 0;

  void onContinueTrash() {
    trashcurrnetStep += 1;
    emit(AppOnContinueTrashSucsessState());
  }

  void onContinueCleaner() {
    cleanerCurrnetStep += 1;
    emit(AppOnContinueCleanerSucsessState());
  }

  void onContinueOldData() {
    buyOldCurrnetStep += 1;
    emit(AppOnContinueBuyOldSucsessState());
  }

  void onStepTappedTrash(int value) {
    trashcurrnetStep = value;
    emit(AppOnStepTappedTrashSucsessState());
  }

  void onStepTappedCleaner(int value) {
    cleanerCurrnetStep = value;
    emit(AppOnStepTappedCleanerSucsessState());
  }

  void onStepTappedBuyOld(int value) {
    buyOldCurrnetStep = value;
    emit(AppOnStepTappedBuyOldSucsessState());
  }

  void returnToOrderTrash() {
    trashcurrnetStep = 0;
    emit(AppReturnOrderDataTrashSucsessState());
  }

  void returnToOrderCleaner() {
    cleanerCurrnetStep = 0;
    emit(AppReturnOrderDataCleanerSucsessState());
  }

  void returnToOrderBuyOld() {
    buyOldCurrnetStep = 0;
    emit(AppReturnOrderDataButOldSucsessState());
  }

  void returnToAvaliablePlan() {
    trashcurrnetStep = 1;
    emit(AppReturnAvilablePlanTrashSucsessState());
  }

  void postTrash({
    required String? location,
    required String? lat,
    required String? lng,
    required String? arrivalTime,
    required String? reminderTime,
    required String? place,
    required String? garbage,
    required String? planId,
    required String? cardNumber,
    required String? expireDate,
    required String? cvv,
    required String? holderName,
  }) {
    emit(AppPostTrashLoadingState());
    DioHelper.postData(
      url: TRASH,
      token: apiToken,
      data: {
        'location': location,
        'lat': lat,
        'lng': lng,
        'arrival_time': arrivalTime,
        'reminder_before_arrival': reminderTime,
        'place': place,
        'garbage': garbage,
        'plan_id': planId,
        'card_number': cardNumber,
        'expire_date': expireDate,
        'cvv': cvv,
        'holder_name': holderName,
      },
    ).then((value) {
      emit(AppPostTrashSucsessState());
    }).catchError((erorr) {
      print('object Erorr');
      print(erorr.toString());
      emit(AppPostTrashErorrtate());
    });
  }

  void postCleaner({
    required String? plcae,
    required String? location,
    required String? lat,
    required String? lng,
    required String? ordertype,
    required String? total,
    required String? card_number,
    required String? expire_date,
    required String? cvv,
    required String? holder_name,
  }) {
    emit(AppPostCleanerLoadingState());
    DioHelper.postData(
      url: CLEANER,
      token: apiToken,
      data: {
        'place': plcae,
        'location': location,
        'lat': lat,
        'lng': lng,
        'order_type': ordertype,
        'total': total,
        'card_number': card_number,
        'expire_date': expire_date,
        'cvv': cvv,
        'holder_name': holder_name,
      },
    ).then((value) {
      //  user = userModel.FromJson(value.data);
      print(value.data);
      emit(AppPostCleanerSucsessState());
    }).catchError((erorr) {
      print(erorr.toString());
      emit(AppPostCleanerErorrtate());
    });
  }

  location.LocationData? _locData;

  Future<void> locationService() async {
    location.Location locationn = location.Location();
    bool _serviceEnabled;
    location.PermissionStatus _permissionLocation;

    _serviceEnabled = await locationn.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await locationn.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionLocation = await locationn.hasPermission();
    if (_permissionLocation == location.PermissionStatus.denied) {
      _permissionLocation = await locationn.requestPermission();
      if (_permissionLocation != location.PermissionStatus.granted) {
        return;
      }
    }

    _locData = await locationn.getLocation();

    UserLocation.lat = _locData?.latitude;
    UserLocation.long = _locData?.longitude;
    print(UserLocation.lat);

    emit(AppConnectLoctionSucsessState());
  }

  geocodeing.Placemark? yourlocationSeleted;

  Future<void> getLocation() async {
    emit(AppGetLocationCleanerLoadingState());
    List<geocodeing.Placemark> placemark = await geocodeing
        .placemarkFromCoordinates(UserLocation.lat!, UserLocation.long!);

    yourlocationSeleted = placemark[0];

    print(placemark[0].administrativeArea);
    print(placemark[0].country);
    print(placemark[0].name);
    print(placemark[0].street);
    print(placemark[0].postalCode);
    print(placemark[0].isoCountryCode);
    print(placemark[0].locality);
    print(placemark[0].subAdministrativeArea);
    print(placemark[0].subLocality);
    print(placemark[0].subThoroughfare);
    print(placemark[0].thoroughfare);

    emit(AppGetLocationCleanerSucsessState());
    // locationCotroller.text =
    //     '${placemark[0].street},  ${placemark[0].administrativeArea!}';
  }

  bool paper = true;
  bool metals = false;
  bool elec = false;

  bool cleanproducts = true;
  bool housware = false;

  void selectPaper() {
    emit(AppInitailbottomtabBarBuyOldSucsessState());
    paper = true;
    metals = false;
    elec = false;
    emit(ChangeBottomTabBarBuyOldState(elec, metals, paper));
  }

  void selectMetals() {
    emit(AppInitailbottomtabBarBuyOldSucsessState());

    paper = false;
    metals = true;
    elec = false;
    emit(ChangeBottomTabBarBuyOldState(elec, metals, paper));
  }

  void selectElec() {
    emit(AppInitailbottomtabBarBuyOldSucsessState());

    paper = false;
    metals = false;
    elec = true;
    emit(ChangeBottomTabBarBuyOldState(elec, metals, paper));
  }

  void selectCleanProducts() {
    emit(AppInitailbottomtabBarExchangeProductsSucsessState());
    cleanproducts = true;
    housware = false;
    emit(ChangeBottomTabBaExchangeProductsState(cleanproducts, housware));
  }

  void selectHouseware() {
    emit(AppInitailbottomtabBarExchangeProductsSucsessState());
    cleanproducts = false;
    housware = true;
    emit(ChangeBottomTabBaExchangeProductsState(cleanproducts, housware));
  }

  void addCleanProducts() {
    numberofCleanProducts++;
    emit(AppAddCleanProductsSucsessState());
    emit(ChangeBottomTabBaExchangeProductsState(cleanproducts, housware));
  }

  void miunsCleanProducts() {
    numberofCleanProducts == 0 ? null : numberofCleanProducts--;

    emit(AppMiunsCleanProductsSucsessState());
    emit(ChangeBottomTabBaExchangeProductsState(cleanproducts, housware));
  }

  void addHouseWareProducts() {
    numberofHouseWareProducts++;
    emit(AppAddHouseWareSucsessState());
    emit(ChangeBottomTabBaExchangeProductsState(cleanproducts, housware));
  }

  void miunsHouseWareProducts() {
    numberofHouseWareProducts == 0 ? null : numberofHouseWareProducts--;

    emit(AppMiunsHouseWareSucsessState());
    emit(ChangeBottomTabBaExchangeProductsState(cleanproducts, housware));
  }

  void addPaperkillos() {
    numberofPaperKillos++;
    emit(AppAddKillosPaperBuyOldSucsessState());
    emit(ChangeBottomTabBarBuyOldState(elec, metals, paper));
  }

  void miunsPaperkillos() {
    numberofPaperKillos == 0 ? null : numberofPaperKillos--;

    emit(AppMiunsKillosPaperBuyOldSucsessState());
    emit(ChangeBottomTabBarBuyOldState(elec, metals, paper));
  }

  void addMetalskillos() {
    numberofMetalsrKillos++;
    emit(AppAddKillosMetalsBuyOldSucsessState());
    emit(ChangeBottomTabBarBuyOldState(elec, metals, paper));
  }

  void miunsMetalskillos() {
    numberofMetalsrKillos == 0 ? null : numberofMetalsrKillos--;

    emit(AppMiunsKillosMetalsBuyOldSucsessState());
    emit(ChangeBottomTabBarBuyOldState(elec, metals, paper));
  }

  void addEleckillos() {
    numberofElectronicsKillos++;
    emit(AppAddKillosElecBuyOldSucsessState());
    emit(ChangeBottomTabBarBuyOldState(elec, metals, paper));
  }

  void miunsEleckillos() {
    numberofElectronicsKillos == 0 ? null : numberofElectronicsKillos--;

    emit(AppMiunsKillosElecBuyOldSucsessState());
    emit(ChangeBottomTabBarBuyOldState(elec, metals, paper));
  }

  int numberofPaperKillos = 0;
  int numberofMetalsrKillos = 0;
  int numberofElectronicsKillos = 0;
  int totalMoneyofBuyOld = 0;

  int numberofCleanProducts = 0;
  int numberofHouseWareProducts = 0;

  int? paperKillos;
  int? metalKillos;
  int? elecKillos;
  int? cleanproductss;
  int? housewreroductss;

  void saveCleanPRoducts({
    required int? products,
  }) {
    cleanproductss = products;
  }

  void saveHouseWare({
    required int? products,
  }) {
    housewreroductss = products;
  }

  void savePaperKillos({
    required int? killos,
  }) {
    paperKillos = killos;
  }

  void saveMetalKillos({
    required int? killos,
  }) {
    metalKillos = killos;
  }

  void saveElectronicKillos({
    required int? killos,
  }) {
    elecKillos = killos;
  }

  void totalMoneyBuyOld({
    required int? papers,
    required int? metals,
    required int? elec,
  }) {
    totalMoneyofBuyOld = papers! * 5 + metals! * 5 + elec! * 5;
    emit(AppTotalMoneyBuyOldSucsessState());
  }

  void postBuyOld({
    required String? saleType,
    required String? location,
    required String? lat,
    required String? lng,
    required String? arrivalDate,
    required String? arrivalTime,
    required String? reminderTime,
    required String? total,
    required String? productid,
    required String? productweight,
    required String? productPoints,
    required String? productPrice,
    required String? productidd,
    required String? productweightt,
    required String? productPointss,
    required String? productPricee,
  }) {
    emit(AppPostBuyOldLoadingState());

    DioHelper.postData(
      url: BUYOLD,
      token: apiToken,
      data: {
        'sale_type': 'points',
        'location': 'Manso',
        'lat': '3.234234',
        'lng': '3.435',
        'arrival_date': '2022-05-20',
        'arrival_time': '22:10:00',
        'reminder_before_arrival': '21:10:00',
        'total': '1500',
        'products[0][old_product_id]': '2',
        'products[0][weight]': '2',
        'products[0][points]': '400',
        'products[0][total_price]': '150',
        'products[1][old_product_id]': '4',
        'products[1][weight]': '2',
        'products[1][points]': '400',
        'products[1][total_price]': '50',
      },
    ).then((value) {
      print(value.data);
      emit(AppPostBuyOldSucsessState());
    }).catchError((erorr) {
      print('object');
      print(erorr.toString());
      emit(AppPostBuyOldErorrtate());
    });
  }

  AccessToken? _accessToken;
  UserFacebookModel? currentUser;

  Future<void> loginWithFacebook() async {
    emit(AppLoginWithFacebookLoadingState());
    final LoginResult result = await FacebookAuth.i.login();

    if (result.status == LoginStatus.success) {
      _accessToken = result.accessToken;

      final data = await FacebookAuth.i.getUserData();
      UserFacebookModel model = UserFacebookModel.FromJson(data);

      currentUser = model;
      emit(AppLoginWithFacebookSucsessState());
    }
  }

  var googleSignIn = GoogleSignIn();
  GoogleSignInAccount? googleAccount;
  Future<void> loginWithGoogle() async {
    emit(AppLoginWithGoogleLoadingState());

    googleAccount = await googleSignIn.signIn();
    emit(AppLoginWithGoogleSucsessState());
  }

  bool rememberMe = false;

  void remmeberMeCheckBox(bool value) {
    rememberMe = value;
    emit(AppRemmbermeCheckBoxSucsessState());
  }

  bool acceptTerms = false;

  void acceptTermsCheckBox(bool value) {
    acceptTerms = value;
    emit(AppRemmbermeCheckBoxSucsessState());
  }

  bool monthsPlanone = false;
  bool daysperWeekPlanOne = false;
  bool gagggPlanOne = false;

  bool monthsPlanTwo = false;
  bool daysperWeekPlanTwo = false;
  bool gagggPlanTwo = false;

  bool monthsPlanThree = false;
  bool daysperWeekPlanThree = false;
  bool gagggPlanThree = false;

  void monthsPlanOneCheckBox(bool valueone) {
    monthsPlanone = valueone;

    emit(AppRemmbermeCheckBoxSucsessState());
  }

  void daysPlanOneCheckBox(bool valueTwo) {
    daysperWeekPlanOne = valueTwo;

    emit(AppRemmbermeCheckBoxSucsessState());
  }

  void gggplanOneCheckBox(bool valueThree) {
    gagggPlanOne = valueThree;

    emit(AppRemmbermeCheckBoxSucsessState());
  }

  void monthsPlanTwoCheckBox(bool valueone) {
    monthsPlanTwo = valueone;

    emit(AppRemmbermeCheckBoxSucsessState());
  }

  void daysPlanTwoCheckBox(bool valueTwo) {
    daysperWeekPlanTwo = valueTwo;

    emit(AppRemmbermeCheckBoxSucsessState());
  }

  void ggPlanTwoCheckBox(bool valueThree) {
    gagggPlanTwo = valueThree;

    emit(AppRemmbermeCheckBoxSucsessState());
  }

  void monthsPlanThreeCheckBox(bool valueone) {
    monthsPlanThree = valueone;

    emit(AppRemmbermeCheckBoxSucsessState());
  }

  void daysPlanThreeCheckBox(bool valueTwo) {
    daysperWeekPlanThree = valueTwo;

    emit(AppRemmbermeCheckBoxSucsessState());
  }

  void ggPlanThreeCheckBox(bool valueThree) {
    gagggPlanThree = valueThree;

    emit(AppRemmbermeCheckBoxSucsessState());
  }

  bool cash = false;
  bool points = false;
  bool donate = false;

  void selectCash() {
    cash = !cash;
    points = false;
    donate = false;

    emit(AppRemmbermeCheckBoxSucsessState());
  }

  void selectPoints() {
    points = !points;
    cash = false;
    donate = false;

    emit(AppRemmbermeCheckBoxSucsessState());
  }

  void selectDonate() {
    donate = !donate;
    cash = false;
    points = false;

    emit(AppRemmbermeCheckBoxSucsessState());
  }

  bool ismale = false;
  bool female = false;

  void selectMale() {
    ismale = !ismale;
    female = false;

    emit(AppRemmbermeCheckBoxSucsessState());
  }

  void selectFemale() {
    female = !female;
    ismale = false;

    emit(AppRemmbermeCheckBoxSucsessState());
  }

  String? namecartItem;
  String? imagecartItem;
  String? idcartItem;
  int? pointscartItem;
  int quantitnycartItem = 0;

  void saveCartItem({
    required String name,
    required String image,
    required String id,
    required int? point,
    required int quantity,
  }) {
    namecartItem = name;
    imagecartItem = image;
    idcartItem = id;
    pointscartItem = point;
    quantitnycartItem = quantity;
  }

  List<exchangeProduct> cartItems = [];

  // void plusquantityItem(int quantity, int index) {
  //   quantity++;
  //   emit(AppPlusQuantitySucsessState());
  //   emit(ChangeBottomTabBaExchangeProductsState(cleanproducts, housware));
  // }

  // void miunsquantityItem(int quantity, int index) {
  //   quantity == 0 ? null : quantity--;
  //   emit(AppMiunsQuantitySucsessState());
  //   emit(ChangeBottomTabBaExchangeProductsState(cleanproducts, housware));
  // }

  // void removelastAddItem() {
  //   cartItems.removeLast();
  //   emit(AppRemoveLastAddItemSucsessState());
  //   emit(ChangeBottomTabBaExchangeProductsState(cleanproducts, housware));
  // }

  void clearItemFormCart(int index) {
    cartItems.removeAt(index);
    emit(AppRemoveItemFromCartSucsessState());
  }

  int? allpoints = 0;
  num delevreypoints = 200;

  var totalll;

  // void totalPoint() {
  //   totalll =
  //       ((user?.data.data!.user_points)! - (allpoints! + delevreypoints))!;
  // }

  // void allCartItemPoints(int index) {
  //   allpoints = cartItems[index].points;
  //   emit(AppAllPointsItemCartSucsessState());
  //   emit(ChangeBottomTabBaExchangeProductsState(cleanproducts, housware));
  // }

  void addcartitem(int index) {
    cartItems[index].quantity++;
    emit(AppAddCartItemSucsessState());
  }

  void miunscartitem(int index) {
    cartItems[index].quantity == 1 ? null : cartItems[index].quantity--;
    emit(AppMiunsCartItemSucsessState());
  }

  void postExchangeProduct({
    required String? location,
    required String? lat,
    required String? lng,
    required String? allitems,
    required String? delivery,
    required String? avilablepoints,
    required String? requierdPay,
    required String? total,
    required String? productOneId,
    required String? productOneQuantity,
    required String? productOnePoints,
    required String? productTwoId,
    required String? productTwoQuantity,
    required String? productTwoPoints,
    required String? cardNumber,
    required String? expireDate,
    required String? cvv,
    required String? holderName,
  }) {
    emit(AppPostExchangeProductsLoadingState());
    DioHelper.postData(
      url: EXCHANGE,
      token: apiToken,
      data: {
        'location': location,
        'lat': lat,
        'lng': lng,
        'all_items': allitems,
        'delivery': delivery,
        'available_points': avilablepoints,
        'required_price': requierdPay,
        'total': total,
        'products[0][product_id]': productOneId,
        'products[0][quantity]': productOneQuantity,
        'products[0][points]': productOnePoints,
        'products[1][product_id]': productTwoId,
        'products[1][quantity]': productTwoQuantity,
        'products[1][points]': productTwoPoints,
        'card_number': cardNumber,
        'expire_date': expireDate,
        'cvv': cvv,
        'holder_name': holderName,
      },
    ).then((value) {
      emit(AppPostExchangeProductsSucsessState());
    }).catchError((erorr) {
      print('object Erorr');
      print(erorr.toString());
      emit(AppPostExchangeProductsErorrtate());
    });
  }
}
