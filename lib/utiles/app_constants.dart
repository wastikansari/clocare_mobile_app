class AppConstants {
  static const String APP_NAME = "Clocare";
  static const int APP_VERSION = 1;

  static String TOKEN = 'token';

  static const String BASE_URL = "http://192.168.29.178:30002";
  static const String OTP_VERIFICATION_URL = "/api/send-otp";
  static const String NUMBER_CHECK_URL = "/api/check-mobile";
  static const String REGISTRATION_URL = "/api/register";
  static const String LOGIN_URL = "/api/login";

  static const String PROFILE_UPDATE_URL = "/api/customer/profile/update";
  static const String PROFILE_DATA_URL = "/api/customer/profile";
  static const String EMAIL_UPDATE_URL = "/api/customer/profile/email/update";

  // wallet
  static const String TRANSACTION_URL = "/api/customer/wallet/transaction";
  static const String WALLET_AMOUNT_URL = "/api/customer/wallet/balance";

  // address url
  static const String ADDRESS_LIST_URL = '/api/address/list';
  static const String ADDRESS_CREATE_URL = '/api/address/add';
  static const String ADDRESS_UPDATE_URL = '/api/address/update';
  static const String ADDRESS_DELETE_URL = '/api/address/delete';

  // order place
  static const String SERVICE_ORDER_PLACE_URL = '/api/customer/service/order/create';
  static const String BASKET_ORDER_PLACE_URL = '/api/customer/basket/order/create';

  // package url
  static const String PACKAGE_LIST_URL = '/api/dashboard/package/list';

  // php yii api
  static const String BASE_URL1 = "https://cc.vcantech.biz";
  static const String HEADER_TOKEN = 'Bearer 466fdac7291ffb284856e6a25a15cbad';
  static const String GARMENT_URL = '/pdapi/v1/price-list/forallservicesnew';
}
