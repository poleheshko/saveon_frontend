import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:saveon_frontend/models/common/coming_soon_alert.dart';
import 'package:saveon_frontend/models/common/saveon_button.dart';
import 'package:saveon_frontend/models/common/saveon_section.dart';
import 'package:saveon_frontend/models/common/saveon_textbutton_small.dart';

import '../../models/common/clickable_svg_logo.dart';
import '../../models/common/common_page_empty.dart';
import '../../models/common/saveon_spacer.dart';
import '../../models/common/saveon_textbutton.dart';
import '../../services/auth_service.dart';
import 'signup_page.dart';
import '../bottom_navigation/main_navigation.dart';

class SaveonLoginPage extends StatefulWidget {
  const SaveonLoginPage({super.key});

  @override
  State<SaveonLoginPage> createState() => _SaveonLoginPage();
}

class _SaveonLoginPage extends State<SaveonLoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  bool _hidePassword = true;
  bool _isLoading = false;
  bool _rememberMe = false;

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  final _authService = AuthService();

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    final success = await _authService.login(
      email: _emailCtrl.text.trim(),
      password: _passwordCtrl.text,
    );

    if (!mounted) return;
    setState(() => _isLoading = false);

    if (success) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const MainNavigation()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid email or password')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return CommonPageEmpty(
      commonPageEmptyContent: [
        SafeArea(
          //Content
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              //Welcome titles
              const SizedBox(height: 24),
              Text(
                'Welcome back',
                style: theme.textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Sign in to track your finances.',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),

              SaveOnSection(
                SaveOnSectionContent: [
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _emailCtrl,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            labelText: 'Email',
                            prefixIcon: Icon(Icons.email_outlined),
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            focusedErrorBorder: InputBorder.none,
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Please enter your email';
                            }
                            final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
                            if (!emailRegex.hasMatch(value.trim())) {
                              return 'Enter a valid email';
                            }
                            return null;
                          },
                        ),
                        SaveOnSpacer(),
                        TextFormField(
                          controller: _passwordCtrl,
                          obscureText: _hidePassword,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            prefixIcon: const Icon(Icons.lock_outline),
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            focusedErrorBorder: InputBorder.none,
                            suffixIcon: IconButton(
                              icon: Icon(
                                _hidePassword
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                              ),
                              onPressed:
                                  () => setState(
                                    () => _hidePassword = !_hidePassword,
                                  ),
                            ),
                          ),
                          validator:
                              (value) =>
                                  value == null || value.length < 6
                                      ? 'Password must be at least 6 characters'
                                      : null,
                        ),
                        SaveOnSpacer(),

                        //remember me and forget password
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Checkbox(
                                  value: _rememberMe,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      _rememberMe = value ?? false;
                                    });
                                  },
                                ),
                                SaveOnTextButton(
                                  buttonLabel: "Remember me",
                                  onPressed: () {
                                    setState(() {
                                      _rememberMe = !_rememberMe;
                                    });
                                  },
                                ),
                              ],
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: SaveOnTextButton(
                                onPressed: () => showComingSoonDialog(context),
                                buttonLabel: 'Forgot password?',
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        SaveOnButton(
                          buttonText: "Log in",
                          onPressed: _isLoading ? null : _submit,
                          isLoading: _isLoading,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Column(
                children: [
                  //text line with text sign up with
                  Row(
                    children: [
                      Expanded(
                        child: Container(color: Color(0xFFC0C0C0), height: 0.2),
                      ),
                      SizedBox(width: 10),
                      Text(
                        "Sign in with",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Container(color: Color(0xFFC0C0C0), height: 0.2),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),

                  //clickable logoes as way to sign up
                  Row(
                    children: [
                      Expanded(flex: 2, child: SizedBox()),
                      ClickableSvgLogo(
                        SvgPath: "lib/assets/logos/google_logo_30px.svg",
                        onTap: () => showComingSoonDialog(context),
                      ),
                      Expanded(flex: 1, child: SizedBox()),
                      ClickableSvgLogo(
                        SvgPath: "lib/assets/logos/apple_logo_30px.svg",
                        onTap: () => showComingSoonDialog(context),
                      ),
                      Expanded(flex: 1, child: SizedBox()),
                      ClickableSvgLogo(
                        SvgPath: "lib/assets/logos/facebook_logo_30px.svg",
                        onTap: () => showComingSoonDialog(context),
                      ),
                      Expanded(flex: 2, child: SizedBox()),
                    ],
                  ),
                  const SizedBox(height: 18),

                  //sign in if have account
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account?",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      SizedBox(width: 5),
                      SaveOnTextButtonSmall(
                        buttonLabel: "Sign up",
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => const SaveOnSignupPage(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
