import 'package:barberto/constants/routes.dart';
import 'package:barberto/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:pub_semver/pub_semver.dart';
import '../../module/human_captcha.dart';
import '../../module/form/custom_text_field.dart';
import '../../module/form/custom_button.dart';
import '../../utils/responsive_extensions.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with ResponsiveMixin {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService authService = AuthService();
  bool _captchaValid = false;

  void _handleLogin() async {
    final email = _emailController.text;
    final password = _passwordController.text;

    try {
      await ApiService.instance.loginWithEmail(
        email: email,
        password: password,
        saveTokenCallback: (token) {
          authService.saveAuthToken(token);
        },
      );

      Navigator.pushReplacementNamed(context, AppRoutes.loggedInHome);
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Login failed: $error'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: theme.colorScheme.surface,
        systemNavigationBarColor: theme.colorScheme.surface,
      ),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: theme.colorScheme.surface,
          body: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: isDesktop(context) ? 500 : double.infinity,
              ),
              child: SingleChildScrollView(
                padding: getAdaptivePadding(
                  mobile: const EdgeInsets.all(16),
                  tablet: const EdgeInsets.all(24),
                  desktop: const EdgeInsets.all(32),
                ),
                child: Column(
                  children: [
                    SizedBox(height: getAdaptiveIconSize(32)),
                    // Logo or App Name
                    Image(
                      image: const AssetImage('images/barberto_logo_nobg.png'),
                      width: getAdaptiveIconSize(64),
                      height: getAdaptiveIconSize(64),
                    ),
                    SizedBox(height: getAdaptiveIconSize(12)),
                    Text(
                      'ورود به Barberto',
                      textDirection: TextDirection.rtl,
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontFamily: 'IranYekanX-Bold',
                        fontWeight: FontWeight.bold,
                        fontSize: getAdaptiveFontSize(24),
                      ),
                    ),
                    SizedBox(height: getAdaptiveIconSize(8)),
                    Text(
                      'خوش برگشتی! لطفاً وارد شوید',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontFamily: 'IranYekanX-Medium',
                        color: Colors.grey[600],
                        fontSize: getAdaptiveFontSize(16),
                      ),
                    ),
                    SizedBox(height: getAdaptiveIconSize(24)),
                    Padding(
                      padding: getAdaptivePadding(
                        mobile: const EdgeInsets.symmetric(horizontal: 16.0),
                        tablet: const EdgeInsets.symmetric(horizontal: 24.0),
                        desktop: const EdgeInsets.symmetric(horizontal: 32.0),
                      ),
                      child: Card(
                        elevation: 6,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Padding(
                          padding: getAdaptivePadding(
                            mobile: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 24),
                            tablet: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 28),
                            desktop: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 32),
                          ),
                          child: Column(
                            children: [
                              EmailTextField(
                                controller: _emailController,
                                label: 'ایمیل',
                                onChanged: (value) {},
                              ),
                              SizedBox(height: getAdaptiveIconSize(16)),
                              PasswordTextField(
                                controller: _passwordController,
                                label: 'رمز عبور',
                                onChanged: (value) {},
                              ),
                              SizedBox(height: getAdaptiveIconSize(16)),
                              HumanCaptcha(
                                onChanged: (isValid) {
                                  setState(() {
                                    _captchaValid = isValid;
                                  });
                                },
                              ),
                              SizedBox(height: getAdaptiveIconSize(24)),
                              LoginButton(
                                onPressed: _captchaValid
                                    ? _handleLogin
                                    : () {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                              content: Text(
                                                  'لطفاً سوال امنیتی را به درستی پاسخ دهید')),
                                        );
                                      },
                                enabled: _captchaValid,
                              ),
                              SizedBox(height: getAdaptiveIconSize(12)),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pushReplacementNamed(
                                          context, AppRoutes.signup);
                                    },
                                    child: Text(
                                      'ثبت نام',
                                      style: TextStyle(
                                        fontFamily: 'IranYekanX-Bold',
                                        color: Colors.orange,
                                        fontSize: getAdaptiveFontSize(14),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    'حساب کاربری ندارید؟',
                                    style: TextStyle(
                                      fontFamily: 'IranYekanX-Medium',
                                      fontSize: getAdaptiveFontSize(14),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: getAdaptiveIconSize(18)),
                    FutureBuilder<Version>(
                      future: getCurrentAppVersion(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Text(
                            'نسخه برنامه: ${snapshot.data}',
                            style: TextStyle(
                              fontSize: getAdaptiveFontSize(14),
                              fontFamily: 'IranYekanXFaNum-Bold',
                              color: Colors.grey,
                            ),
                          );
                        } else {
                          return const SizedBox.shrink();
                        }
                      },
                    ),
                    SizedBox(height: getAdaptiveIconSize(18)),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Future<Version> getCurrentAppVersion() async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  String version = packageInfo.version;
  return Version.parse(version);
}
