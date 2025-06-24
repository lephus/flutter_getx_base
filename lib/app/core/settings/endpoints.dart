abstract class Endpoints {
  static String masterHost = 'ssmart.vnv.io.vn';
  static String apiUrl = 'https://ssmart-api.vnv.io.vn/api';
  // static String apiUrl = 'https://1287-58-186-28-77.ngrok-free.app/api';

  // AUTH
  static String authMe = '$apiUrl/v1/auth/me';
  static String login = '$apiUrl/auth/login';
  static String googleLogin = '$apiUrl/auth/login/google';
  static String appleLogin = '$apiUrl/auth/login/apple';
  static String appleLoginWithUserIdentifier =
      '$apiUrl/auth/login/apple/user-identifier';
  static String register = '$apiUrl/auth/register';
  static String refreshToken = '$apiUrl/auth/refresh-token';
  static String updateProfile = '$apiUrl/auth/profile';
  static String getOtp = '$apiUrl/auth/forgot-password/otp/';
  static String verifyOtp = '$apiUrl/auth/';
  static String resetPassword = '$apiUrl/auth/reset-password';
  static String resetPasswordWithOtp =
      '$apiUrl/auth/forgot-password/reset-with-otp';
  static String deleteAccount = '$apiUrl/auth/';
  static String pushFirebaseToken = '$apiUrl/firebase-fcms';

  static String getUserById = '$apiUrl/users';
  static String getUsers = '$apiUrl/users?';

  // STORE
  static String getStore = '$apiUrl/stores?';
  static String getStoresInIds = '$apiUrl/stores/in-ids';
  static String getSingleStore = '$apiUrl/stores/';
  static String createStore = '$apiUrl/stores';
  static String updateStore = '$apiUrl/stores/';
  static String deleteStore = '$apiUrl/stores/';
  static String countStore = '$apiUrl/stores/counter';
  static String getAllCustomerInStore = '$apiUrl/stores/';

  // UPLOAD FILES
  static String uploadFile = '$apiUrl/upload/bucket/';
  static String deleteFile = '$apiUrl/upload/bucket/';

  // APP NOTIFICATION
  static String getNotification = '$apiUrl/notifications?';
  static String updateNotificationStatus = '$apiUrl/notifications/';
  static String pushNotification = '$apiUrl/notifications';
  static String vnsHotMessage = '$apiUrl/notifications/vns/hot-messages';
  static String deleteNotification = '$apiUrl/notifications/';

  // EMPLOYMENT
  static String getEmployment = '$apiUrl/users?';
  static String getSingleEmployment = '$apiUrl/users/';
  static String createEmployment = '$apiUrl/users/employment/by-admin';
  static String updateEmploymentByAdmin = '$apiUrl/users/employment/';
  static String changePasswordEmploymentByAdmin = '$apiUrl/users/employment/';
  static String deleteEmployment = '$apiUrl/users/';

  //
  // VOUCHERS
  static String getVouchers = '$apiUrl/vouchers?';
  static String getVouchersByAdmin = '$apiUrl/vouchers/by-admin?';
  static String getVouchersCustomers = '$apiUrl/vouchers/by-customer?';
  static String getSingleVoucher = '$apiUrl/vouchers/';
  static String createVoucher = '$apiUrl/vouchers';
  static String updateVoucher = '$apiUrl/vouchers/';
  static String deleteVoucher = '$apiUrl/vouchers/';
  static String temporaryCode = '$apiUrl/vouchers/temporary-code';
  static String getSuggestUserInVoucher = '$apiUrl/vouchers/suggestion?';

  static String getSingleVoucherSubscription =
      '$apiUrl/user-vouchers/subscription/';
  static String getPointInVoucher = '$apiUrl/user-vouchers/points?';
  static String getMembershipVouchers = '$apiUrl/user-vouchers?';
  static String updateUserVouchers = '$apiUrl/user-vouchers/';
  static String getAllStoreUserSubscripted =
      '$apiUrl/user-vouchers/subscription/stores';

  static String createSubscriberVoucherPoint = '$apiUrl/user-vouchers/points';

  // SERVICES
  static String getStoreServices = '$apiUrl/store-services?';
  static String getSingleStoreServices = '$apiUrl/store-services/';
  static String createStoreServices = '$apiUrl/store-services';
  static String updateStoreServices = '$apiUrl/store-services/';
  static String deleteStoreServices = '$apiUrl/store-services/';

  // BOOKINGS
  static String getBookings = '$apiUrl/bookings?';
  static String getSingleBookings = '$apiUrl/bookings/';
  static String createBookings = '$apiUrl/bookings';
  static String updateBookings = '$apiUrl/bookings/';
  static String deleteBookings = '$apiUrl/bookings/';

  // DASHBOARD
  static String getUserDashboardOverview =
      '$apiUrl/app-reports/dashboard/overview/user';
  static String getDashboardOverview = '$apiUrl/app-reports/dashboard/overview';
  static String getDashboardVoucher = '$apiUrl/app-reports/dashboard/voucher';
  static String getDashboardTracking = '$apiUrl/app-reports/dashboard/tracking';

  // MEMBERSHIP CARD
  static String getFormMemberCardStore = '$apiUrl/form-member-cards/by-store/';
  static String getFormMemberCard = '$apiUrl/form-member-cards/';
  static String updateFormMemberCard = '$apiUrl/form-member-cards/';

  static String createMemberCardPoint = '$apiUrl/membership-cards';
  static String getMemberCardHistories = '$apiUrl/membership-cards/histories';
  static String getAllMembership = '$apiUrl/membership-cards';
  static String getMemberCardByUser = '$apiUrl/membership-cards/user/';
  static String getMemberCardById = '$apiUrl/membership-cards/';
}
