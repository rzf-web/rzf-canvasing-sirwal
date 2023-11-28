part of '../signin.page.dart';

class _Mobile extends GetView<SignInController> {
  const _Mobile();

  @override
  Widget build(BuildContext context) {
    const padding = AppTheme.mobilePadding;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: padding),
        child: Center(
          child: AppRemoveOverscroll(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 93,
                    width: 100,
                    color: Colors.transparent,
                    margin: const EdgeInsets.only(bottom: 42),
                    child: Image.asset(
                      loginLogo,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 14.0),
                    child: Text(
                      "Welcome Back",
                      style: TextStyle(
                        fontSize: 24,
                        color: AppTheme.titleColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 58.0),
                    child: SizedBox(
                      width: getWidth(context) * .7,
                      child: const Text(
                        "Silahkan masukan username dan password anda",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                          color: AppTheme.bodyColor,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 25.0),
                    child: AppTextFieldAuth(
                      isPassword: false,
                      hintText: "Masukan email Anda",
                      controller: controller.emailController,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: AppTextFieldAuth(
                      isPassword: true,
                      hintText: "Masukan password Anda",
                      controller: controller.pwController,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 52.0, left: 4.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: AppCheckBox(
                        rightText: "Ingat Saya",
                        onChanged: (v) => controller.rememberMe = v,
                      ),
                    ),
                  ),
                  Obx(
                    () => AppButton(
                      onPressed: controller.login,
                      isLoading: controller.waiting.value,
                      child: const Text("Masuk", style: AppTheme.btnStyle),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
