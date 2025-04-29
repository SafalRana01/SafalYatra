import 'package:get/get.dart';

import '../modules/ForgetOtpValidate/bindings/forget_otp_validate_binding.dart';
import '../modules/ForgetOtpValidate/views/forget_otp_validate_view.dart';
import '../modules/OtpValidate/bindings/otp_validate_binding.dart';
import '../modules/OtpValidate/views/otp_validate_view.dart';
import '../modules/UserHome/bindings/user_home_binding.dart';
import '../modules/UserHome/views/user_home_view.dart';
import '../modules/add_admin/bindings/add_admin_binding.dart';
import '../modules/add_admin/views/add_admin_view.dart';
import '../modules/add_car/bindings/add_car_binding.dart';
import '../modules/add_car/views/add_car_view.dart';
import '../modules/add_driver/bindings/add_driver_binding.dart';
import '../modules/add_driver/views/add_driver_view.dart';
import '../modules/add_tour_package/bindings/add_tour_package_binding.dart';
import '../modules/add_tour_package/views/add_tour_package_view.dart';
import '../modules/admin_bookings/bindings/admin_bookings_binding.dart';
import '../modules/admin_bookings/views/admin_bookings_view.dart';
import '../modules/admin_cars/bindings/admin_cars_binding.dart';
import '../modules/admin_cars/views/admin_cars_view.dart';
import '../modules/admin_home/bindings/admin_home_binding.dart';
import '../modules/admin_home/views/admin_home_view.dart';
import '../modules/admin_main/bindings/admin_main_binding.dart';
import '../modules/admin_main/views/admin_main_view.dart';
import '../modules/admin_profile/bindings/admin_profile_binding.dart';
import '../modules/admin_profile/views/admin_profile_view.dart';
import '../modules/all_admins/bindings/all_admins_binding.dart';
import '../modules/all_admins/views/all_admins_view.dart';
import '../modules/available_cars/bindings/available_cars_binding.dart';
import '../modules/available_cars/views/available_cars_view.dart';
import '../modules/available_drivers/bindings/available_drivers_binding.dart';
import '../modules/available_drivers/views/available_drivers_view.dart';
import '../modules/boarding_screen/bindings/boarding_screen_binding.dart';
import '../modules/boarding_screen/views/boarding_screen_view.dart';
import '../modules/bookings/bindings/bookings_binding.dart';
import '../modules/bookings/views/bookings_view.dart';
import '../modules/categories/bindings/categories_binding.dart';
import '../modules/categories/views/categories_view.dart';
import '../modules/change_password/bindings/change_password_binding.dart';
import '../modules/change_password/views/change_password_view.dart';
import '../modules/driver_home/bindings/driver_home_binding.dart';
import '../modules/driver_home/views/driver_home_view.dart';
import '../modules/driver_main/bindings/driver_main_binding.dart';
import '../modules/driver_main/views/driver_main_view.dart';
import '../modules/driver_profile/bindings/driver_profile_binding.dart';
import '../modules/driver_profile/views/driver_profile_view.dart';
import '../modules/edit_admin/bindings/edit_admin_binding.dart';
import '../modules/edit_admin/views/edit_admin_view.dart';
import '../modules/edit_driver/bindings/edit_driver_binding.dart';
import '../modules/edit_driver/views/edit_driver_view.dart';
import '../modules/edit_operator/bindings/edit_operator_binding.dart';
import '../modules/edit_operator/views/edit_operator_view.dart';
import '../modules/edit_profile/bindings/edit_profile_binding.dart';
import '../modules/edit_profile/views/edit_profile_view.dart';
import '../modules/forgot_password/bindings/forgot_password_binding.dart';
import '../modules/forgot_password/views/forgot_password_view.dart';
import '../modules/login_page/bindings/login_page_binding.dart';
import '../modules/login_page/views/login_page_view.dart';
import '../modules/main_screen/bindings/main_screen_binding.dart';
import '../modules/main_screen/views/main_screen_view.dart';
import '../modules/operator_bookings/bindings/operator_bookings_binding.dart';
import '../modules/operator_bookings/views/operator_bookings_view.dart';
import '../modules/operator_cars/bindings/operator_cars_binding.dart';
import '../modules/operator_cars/views/operator_cars_view.dart';
import '../modules/operator_drivers/bindings/operator_drivers_binding.dart';
import '../modules/operator_drivers/views/operator_drivers_view.dart';
import '../modules/operator_home/bindings/operator_home_binding.dart';
import '../modules/operator_home/views/operator_home_view.dart';
import '../modules/operator_main/bindings/operator_main_binding.dart';
import '../modules/operator_main/views/operator_main_view.dart';
import '../modules/operator_profile/bindings/operator_profile_binding.dart';
import '../modules/operator_profile/views/operator_profile_view.dart';
import '../modules/operator_tour_booking/bindings/operator_tour_booking_binding.dart';
import '../modules/operator_tour_booking/views/operator_tour_booking_view.dart';
import '../modules/operator_tours/bindings/operator_tours_binding.dart';
import '../modules/operator_tours/views/operator_tours_view.dart';
import '../modules/payments/bindings/payments_binding.dart';
import '../modules/payments/views/payments_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/reset_password/bindings/reset_password_binding.dart';
import '../modules/reset_password/views/reset_password_view.dart';
import '../modules/select_city/bindings/select_city_binding.dart';
import '../modules/select_city/views/select_city_view.dart';
import '../modules/selected_car/bindings/selected_car_binding.dart';
import '../modules/selected_car/views/selected_car_view.dart';
import '../modules/signup_page/bindings/signup_page_binding.dart';
import '../modules/signup_page/views/signup_page_view.dart';
import '../modules/specific_tour_package/bindings/specific_tour_package_binding.dart';
import '../modules/specific_tour_package/views/specific_tour_package_view.dart';
import '../modules/splash_screen/bindings/splash_screen_binding.dart';
import '../modules/splash_screen/views/splash_screen_view.dart';
import '../modules/test_page/bindings/test_page_binding.dart';
import '../modules/test_page/views/test_page_view.dart';
import '../modules/tour_package/bindings/tour_package_binding.dart';
import '../modules/tour_package/views/tour_package_view.dart';
import '../modules/user_tour_booking/bindings/user_tour_booking_binding.dart';
import '../modules/user_tour_booking/views/user_tour_booking_view.dart';
import '../modules/users_view/bindings/users_view_binding.dart';
import '../modules/users_view/views/users_view_view.dart';

part 'app_routes.dart';

class AppPages {
  // Private constructor to prevent instantiation
  AppPages._();

  // Initial route of the application
  static const INITIAL = Routes.MAIN_SCREEN;

  // List of application routes using GetX's GetPage
  static final routes = [
    // Authentication and User Flow Routes
    GetPage(
      name: _Paths.LOGIN_PAGE,
      page: () => const LoginPageView(),
      binding: LoginPageBinding(),
    ),
    GetPage(
      name: _Paths.SIGNUP_PAGE,
      page: () => const SignupPageView(),
      binding: SignupPageBinding(),
    ),
    GetPage(
      name: _Paths.OTP_VALIDATE,
      page: () => const OtpValidateView(),
      binding: OtpValidateBinding(),
    ),
    GetPage(
      name: _Paths.FORGOT_PASSWORD,
      page: () => const ForgotPasswordView(),
      binding: ForgotPasswordBinding(),
    ),
    GetPage(
      name: _Paths.FORGET_OTP_VALIDATE,
      page: () => const ForgetOtpValidateView(),
      binding: ForgetOtpValidateBinding(),
    ),
    GetPage(
      name: _Paths.RESET_PASSWORD,
      page: () => const ResetPasswordView(),
      binding: ResetPasswordBinding(),
    ),

    // Main User Dashboard and Features
    GetPage(
      name: _Paths.MAIN_SCREEN,
      page: () => const MainScreenView(),
      binding: MainScreenBinding(),
    ),
    GetPage(
      name: _Paths.USER_HOME,
      page: () => const UserHomeView(),
      binding: UserHomeBinding(),
    ),
    GetPage(
      name: _Paths.TOUR_PACKAGE,
      page: () => const TourPackageView(),
      binding: TourPackageBinding(),
    ),
    GetPage(
      name: _Paths.BOOKINGS,
      page: () => BookingsView(),
      binding: BookingsBinding(),
    ),
    GetPage(
      name: _Paths.PAYMENTS,
      page: () => PaymentsView(),
      binding: PaymentsBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => ProfileView(),
      binding: ProfileBinding(),
    ),

    // Onboarding and Splash Screens
    GetPage(
      name: _Paths.SPLASH_SCREEN,
      page: () => const SplashScreenView(),
      binding: SplashScreenBinding(),
    ),
    GetPage(
      name: _Paths.BOARDING_SCREEN,
      page: () => BoardingScreenView(),
      binding: BoardingScreenBinding(),
    ),

    // Operator Dashboard and Management Features
    GetPage(
      name: _Paths.OPERATOR_MAIN,
      page: () => const OperatorMainView(),
      binding: OperatorMainBinding(),
    ),
    GetPage(
      name: _Paths.OPERATOR_HOME,
      page: () => const OperatorHomeView(),
      binding: OperatorHomeBinding(),
    ),
    GetPage(
      name: _Paths.OPERATOR_CARS,
      page: () => OperatorCarsView(),
      binding: OperatorCarsBinding(),
    ),
    GetPage(
      name: _Paths.OPERATOR_DRIVERS,
      page: () => OperatorDriversView(),
      binding: OperatorDriversBinding(),
    ),
    GetPage(
      name: _Paths.OPERATOR_TOURS,
      page: () => OperatorToursView(),
      binding: OperatorToursBinding(),
    ),
    GetPage(
      name: _Paths.OPERATOR_BOOKINGS,
      page: () => OperatorBookingsView(),
      binding: OperatorBookingsBinding(),
    ),
    GetPage(
      name: _Paths.OPERATOR_PROFILE,
      page: () => const OperatorProfileView(),
      binding: OperatorProfileBinding(),
    ),

    // Adding and Editing Operator Resources
    GetPage(
      name: _Paths.ADD_CAR,
      page: () => const AddCarView(),
      binding: AddCarBinding(),
    ),
    GetPage(
      name: _Paths.ADD_DRIVER,
      page: () => const AddDriverView(),
      binding: AddDriverBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_OPERATOR,
      page: () => EditOperatorView(),
      binding: EditOperatorBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_DRIVER,
      page: () => EditDriverView(),
      binding: EditDriverBinding(),
    ),

    // Driver Dashboard and Features
    GetPage(
      name: _Paths.DRIVER_MAIN,
      page: () => const DriverMainView(),
      binding: DriverMainBinding(),
    ),
    GetPage(
      name: _Paths.DRIVER_HOME,
      page: () => const DriverHomeView(),
      binding: DriverHomeBinding(),
    ),
    GetPage(
      name: _Paths.DRIVER_PROFILE,
      page: () => const DriverProfileView(),
      binding: DriverProfileBinding(),
    ),

    // Profile and Account Settings
    GetPage(
      name: _Paths.EDIT_PROFILE,
      page: () => EditProfileView(),
      binding: EditProfileBinding(),
    ),
    GetPage(
      name: _Paths.CHANGE_PASSWORD,
      page: () => const ChangePasswordView(),
      binding: ChangePasswordBinding(),
    ),

    // City and Car Selection for Users
    GetPage(
      name: _Paths.SELECT_CITY,
      page: () => SelectCityView(),
      binding: SelectCityBinding(),
    ),
    GetPage(
      name: _Paths.AVAILABLE_CARS,
      page: () => AvailableCarsView(),
      binding: AvailableCarsBinding(),
    ),
    GetPage(
      name: _Paths.SELECTED_CAR,
      page: () => SelectedCarView(),
      binding: SelectedCarBinding(),
    ),
    GetPage(
      name: _Paths.AVAILABLE_DRIVERS,
      page: () => const AvailableDriversView(),
      binding: AvailableDriversBinding(),
    ),
    GetPage(
      name: _Paths.ADMIN_MAIN,
      page: () => const AdminMainView(),
      binding: AdminMainBinding(),
    ),
    GetPage(
      name: _Paths.ADMIN_HOME,
      page: () => const AdminHomeView(),
      binding: AdminHomeBinding(),
    ),
    GetPage(
      name: _Paths.CATEGORIES,
      page: () => const CategoriesView(),
      binding: CategoriesBinding(),
    ),

    GetPage(
      name: _Paths.ALL_ADMINS,
      page: () => const AllAdminsView(),
      binding: AllAdminsBinding(),
    ),
    GetPage(
      name: _Paths.USERS_VIEW,
      page: () => const UsersViewView(),
      binding: UsersViewBinding(),
    ),
    GetPage(
      name: _Paths.ADMIN_PROFILE,
      page: () => const AdminProfileView(),
      binding: AdminProfileBinding(),
    ),
    GetPage(
      name: _Paths.ADD_ADMIN,
      page: () => const AddAdminView(),
      binding: AddAdminBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_ADMIN,
      page: () => EditAdminView(),
      binding: EditAdminBinding(),
    ),
    GetPage(
      name: _Paths.ADMIN_BOOKINGS,
      page: () => const AdminBookingsView(),
      binding: AdminBookingsBinding(),
    ),
    GetPage(
      name: _Paths.ADMIN_CARS,
      page: () => const AdminCarsView(),
      binding: AdminCarsBinding(),
    ),
    GetPage(
      name: _Paths.ADD_TOUR_PACKAGE,
      page: () => const AddTourPackageView(),
      binding: AddTourPackageBinding(),
    ),
    GetPage(
      name: _Paths.SPECIFIC_TOUR_PACKAGE,
      page: () => const SpecificTourPackageView(),
      binding: SpecificTourPackageBinding(),
    ),
    GetPage(
      name: _Paths.USER_TOUR_BOOKING,
      page: () => UserTourBookingView(),
      binding: UserTourBookingBinding(),
    ),
    GetPage(
      name: _Paths.OPERATOR_TOUR_BOOKING,
      page: () => const OperatorTourBookingView(),
      binding: OperatorTourBookingBinding(),
    ),
    GetPage(
      name: _Paths.TEST_PAGE,
      page: () => const TestPageView(),
      binding: TestPageBinding(),
    ),
  ];
}
