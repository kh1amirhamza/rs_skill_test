import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:rs_skill_test/features/branch/presentation/pages/branch_page.dart';
import 'package:rs_skill_test/features/sign_in/bindings/sign_in_bindings.dart';
import '../../features/forgot_password/presentation/forgot_password_screen.dart';
import '../../features/main_page/bindings/main_page_bindings.dart';
import '../../features/main_page/presentation/pages/main_page.dart';
import '../../features/profile/bindings/profile_bindings.dart';
import '../../features/profile/presentation/pages/profile_page.dart';
import '../../features/sign_in/presentation/pages/signin_page.dart';
import '../../features/sign_up/bindings/sign_up_bindings.dart';
import '../../features/sign_up/presentation/pages/sign_up_page.dart';
import '../../features/splash_screen/bindings/splashscreen_bindings.dart';
import '../../features/splash_screen/presentation/pages/splashscreen_page.dart';
import 'routes.dart';

class Pages {
  static const splashScreen = SplashScreen();

  static final List<GetPage> pages = [
    GetPage(
        name: Routes.splashScreen,
        page: () => const SplashScreen(),
        binding: SplashscreenBindings()),
    GetPage(
      name: Routes.signUp,
      page: () =>  SignUpPage(),
      binding: SignUpBindings(),
    ),
    GetPage(
      name: Routes.signIn,
      page: () =>  SignInScreen(),
      binding: SignInBindings(),
    ),
    GetPage(
        name: Routes.mainPage,
        page: () => const MainPage(),
        binding: MainPageBindings()),
    GetPage(
      name: Routes.profile,
      page: () => const ProfilePage(),
      binding: ProfileBindings(),
    ),

    GetPage(
      name: Routes.signIn,
      page: () =>  SignInScreen(),
      // binding: PropertiesBindings(),
    ),
    GetPage(
      name: Routes.forgotPassword,
      page: () => const ForgotPasswordScreen(),
      // binding: PropertiesBindings(),
    ),
    GetPage(
      name: Routes.branch,
      page: () => const BranchPage(),
      // binding: PropertiesBindings(),
    ),

  ];
}
