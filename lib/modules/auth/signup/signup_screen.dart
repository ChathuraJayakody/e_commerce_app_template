import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/routes/app_routes.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../widgets/common/common_widgets.dart';

// ============================================================
// SIGN UP SCREEN
// ============================================================
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _agreedToTerms = false;
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _signUp() async {
    if (!_agreedToTerms) {
      Get.snackbar('Terms Required', 'Please agree to Terms & Conditions',
          backgroundColor: AppColors.errorRed, colorText: Colors.white);
      return;
    }
    if (_formKey.currentState?.validate() ?? false) {
      setState(() => _isLoading = true);
      await Future.delayed(const Duration(seconds: 1));
      setState(() => _isLoading = false);
      Get.toNamed(AppRoutes.otp);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.softWhite,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(top: 60, bottom: 28, left: 24, right: 24),
              decoration: const BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(32),
                  bottomRight: Radius.circular(32),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const PremiumBackButton(),
                  const SizedBox(height: 20),
                  Text(
                    'Create Account',
                    style: AppTextStyles.displayMedium.copyWith(color: Colors.white),
                  ),
                  Text(
                    'Join LuxeMart for free today',
                    style: AppTextStyles.bodyMedium.copyWith(color: Colors.white70),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppDimensions.pagePaddingH),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 12),
                    PremiumTextField(
                      hint: 'John Doe',
                      label: 'Full Name',
                      controller: _nameController,
                      prefixIcon: const Icon(Icons.person_outline_rounded,
                          color: AppColors.textLight, size: 20),
                      validator: (val) =>
                          val?.isEmpty ?? true ? 'Please enter your name' : null,
                    ),
                    const SizedBox(height: 16),
                    PremiumTextField(
                      hint: 'your@email.com',
                      label: 'Email Address',
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      prefixIcon: const Icon(Icons.email_outlined,
                          color: AppColors.textLight, size: 20),
                      validator: (val) {
                        if (val?.isEmpty ?? true) return 'Please enter your email';
                        if (!GetUtils.isEmail(val!)) return 'Invalid email format';
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    PremiumTextField(
                      hint: 'Create a strong password',
                      label: 'Password',
                      controller: _passwordController,
                      isPassword: true,
                      prefixIcon: const Icon(Icons.lock_outline_rounded,
                          color: AppColors.textLight, size: 20),
                      validator: (val) {
                        if (val?.isEmpty ?? true) return 'Please enter a password';
                        if ((val?.length ?? 0) < 8)
                          return 'Password must be at least 8 characters';
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    PremiumTextField(
                      hint: 'Confirm your password',
                      label: 'Confirm Password',
                      controller: _confirmPasswordController,
                      isPassword: true,
                      prefixIcon: const Icon(Icons.lock_outline_rounded,
                          color: AppColors.textLight, size: 20),
                      validator: (val) {
                        if (val != _passwordController.text) return 'Passwords do not match';
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    // Terms
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 20,
                          height: 20,
                          child: Checkbox(
                            value: _agreedToTerms,
                            onChanged: (val) =>
                                setState(() => _agreedToTerms = val ?? false),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: RichText(
                            text: TextSpan(
                              text: 'I agree to the ',
                              style: AppTextStyles.bodySmall.copyWith(
                                  fontSize: 12, color: AppColors.textMedium),
                              children: [
                                TextSpan(
                                  text: 'Terms of Service',
                                  style: AppTextStyles.labelSmall.copyWith(
                                    color: AppColors.royalBlue,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                TextSpan(
                                    text: ' and ',
                                    style: AppTextStyles.bodySmall.copyWith(
                                        fontSize: 12)),
                                TextSpan(
                                  text: 'Privacy Policy',
                                  style: AppTextStyles.labelSmall.copyWith(
                                    color: AppColors.royalBlue,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 28),
                    PremiumButton(
                      text: 'Create Account',
                      onTap: _signUp,
                      isLoading: _isLoading,
                    ),
                    const SizedBox(height: 24),
                    Center(
                      child: GestureDetector(
                        onTap: () => Get.back(),
                        child: RichText(
                          text: TextSpan(
                            text: 'Already have an account? ',
                            style: AppTextStyles.bodyMedium.copyWith(fontSize: 14),
                            children: [
                              TextSpan(
                                text: 'Sign In',
                                style: AppTextStyles.labelLarge.copyWith(
                                  color: AppColors.royalBlue,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// FORGOT PASSWORD SCREEN
// ============================================================
class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _emailController = TextEditingController();
  bool _isLoading = false;
  bool _emailSent = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _sendReset() async {
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      _isLoading = false;
      _emailSent = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.softWhite,
      appBar: AppBar(
        leading: const Padding(
          padding: EdgeInsets.all(8),
          child: PremiumBackButton(),
        ),
        title: const Text('Forgot Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppDimensions.pagePaddingH),
        child: _emailSent ? _buildSuccessState() : _buildForm(),
      ),
    );
  }

  Widget _buildForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Container(
          width: 72,
          height: 72,
          decoration: BoxDecoration(
            color: AppColors.royalBlueSurface,
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Center(child: Text('🔑', style: TextStyle(fontSize: 34))),
        ),
        const SizedBox(height: 20),
        Text('Reset Password', style: AppTextStyles.displaySmall),
        const SizedBox(height: 8),
        Text(
          'Enter your email address and we\'ll send you a link to reset your password.',
          style: AppTextStyles.bodyMedium.copyWith(height: 1.6),
        ),
        const SizedBox(height: 32),
        PremiumTextField(
          hint: 'your@email.com',
          label: 'Email Address',
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          prefixIcon: const Icon(Icons.email_outlined,
              color: AppColors.textLight, size: 20),
        ),
        const SizedBox(height: 28),
        PremiumButton(
          text: 'Send Reset Link',
          onTap: _sendReset,
          isLoading: _isLoading,
        ),
      ],
    );
  }

  Widget _buildSuccessState() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: AppColors.successGreen.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const Center(child: Text('✅', style: TextStyle(fontSize: 50))),
          ),
          const SizedBox(height: 24),
          Text('Email Sent!', style: AppTextStyles.displaySmall),
          const SizedBox(height: 12),
          Text(
            'We\'ve sent a password reset link to\n${_emailController.text}',
            style: AppTextStyles.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          PremiumButton(
            text: 'Back to Sign In',
            onTap: () => Get.until((route) => route.settings.name == AppRoutes.login),
            width: 200,
          ),
          const SizedBox(height: 16),
          TextButton(
            onPressed: () => setState(() => _emailSent = false),
            child: Text('Resend Email',
                style: AppTextStyles.labelMedium.copyWith(color: AppColors.royalBlue)),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// OTP VERIFICATION SCREEN
// ============================================================
class OTPScreen extends StatefulWidget {
  const OTPScreen({super.key});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final List<TextEditingController> _controllers =
      List.generate(6, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());
  bool _isLoading = false;
  int _resendTimer = 30;

  @override
  void initState() {
    super.initState();
    _startResendTimer();
  }

  void _startResendTimer() async {
    while (_resendTimer > 0) {
      await Future.delayed(const Duration(seconds: 1));
      if (mounted) setState(() => _resendTimer--);
    }
  }

  @override
  void dispose() {
    for (var c in _controllers) c.dispose();
    for (var f in _focusNodes) f.dispose();
    super.dispose();
  }

  Future<void> _verify() async {
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 1));
    setState(() => _isLoading = false);
    Get.offAllNamed(AppRoutes.main);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.softWhite,
      appBar: AppBar(
        leading: const Padding(
          padding: EdgeInsets.all(8),
          child: PremiumBackButton(),
        ),
        title: const Text('Verify OTP'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppDimensions.pagePaddingH),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Center(
                  child: Text('💬', style: TextStyle(fontSize: 34))),
            ),
            const SizedBox(height: 20),
            Text('Enter OTP', style: AppTextStyles.displaySmall),
            const SizedBox(height: 8),
            RichText(
              text: TextSpan(
                text: 'We sent a 6-digit code to ',
                style: AppTextStyles.bodyMedium,
                children: [
                  TextSpan(
                    text: 'j***@email.com',
                    style: AppTextStyles.labelMedium.copyWith(
                        color: AppColors.royalBlue),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            // OTP Input Fields
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                6,
                (index) => SizedBox(
                  width: 46,
                  height: 56,
                  child: TextFormField(
                    controller: _controllers[index],
                    focusNode: _focusNodes[index],
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    maxLength: 1,
                    style: AppTextStyles.headingMedium,
                    decoration: InputDecoration(
                      counterText: '',
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: EdgeInsets.zero,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: AppColors.borderGrey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                            color: AppColors.royalBlue, width: 2),
                      ),
                    ),
                    onChanged: (val) {
                      if (val.isNotEmpty && index < 5) {
                        _focusNodes[index + 1].requestFocus();
                      } else if (val.isEmpty && index > 0) {
                        _focusNodes[index - 1].requestFocus();
                      }
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),
            PremiumButton(
              text: 'Verify & Continue',
              onTap: _verify,
              isLoading: _isLoading,
            ),
            const SizedBox(height: 20),
            Center(
              child: _resendTimer > 0
                  ? Text(
                      'Resend code in ${_resendTimer}s',
                      style: AppTextStyles.bodySmall.copyWith(fontSize: 13),
                    )
                  : GestureDetector(
                      onTap: () {
                        setState(() => _resendTimer = 30);
                        _startResendTimer();
                      },
                      child: Text(
                        'Resend Code',
                        style: AppTextStyles.labelMedium.copyWith(
                          color: AppColors.royalBlue,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
