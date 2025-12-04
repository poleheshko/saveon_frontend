import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:saveon_frontend/models/common/saveon_button.dart';
import 'package:saveon_frontend/models/common/saveon_section.dart';
import 'package:saveon_frontend/models/common/saveon_spacer.dart';

import '../../models/common/clickable_svg_logo.dart';
import '../../models/common/coming_soon_alert.dart';
import '../../models/common/common_page_empty.dart';
import '../../models/common/saveon_textbutton_small.dart';
import '../../services/auth_service.dart';
import '../bottom_navigation/main_navigation.dart';
import 'login_page.dart';

class SaveOnSignupPage extends StatefulWidget {
  const SaveOnSignupPage({super.key});

  @override
  State<SaveOnSignupPage> createState() => _SaveOnSignupPage();
}

class _SaveOnSignupPage extends State<SaveOnSignupPage> {
  final _formKey = GlobalKey<FormState>(); //form key

  //form controllers
  final _nameCtrl = TextEditingController();
  final _surnameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  final _dateOfBirthCtrl = TextEditingController();
  DateTime? _selectedDateOfBirth;
  bool _hidePassword = true;

  //other
  bool _rememberMe = false;
  bool _isLoading = false;

  final _authService = AuthService();

  @override
  void dispose() {
    _nameCtrl.dispose();
    _surnameCtrl.dispose();
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    _dateOfBirthCtrl.dispose();
    super.dispose();
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
              Column(
                children: [
                  Text(
                    'Get Started!',
                    style: theme.textTheme.headlineLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Track your finances. Share your expenses.',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              const SizedBox(height: 32),

              //Registration form
              SaveOnSection(
                SaveOnSectionContent: [
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        //form-name
                        TextFormField(
                          controller: _nameCtrl,
                          keyboardType: TextInputType.name,
                          decoration: const InputDecoration(
                            labelText: 'Name',
                            prefixIcon: Icon(Icons.person_outline),
                            hintText: "Enter your name",
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            focusedErrorBorder: InputBorder.none,
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Please enter your name';
                            }
                            if (value.trim().length < 2) {
                              return 'Name must be at least 2 characters';
                            }
                            return null;
                          },
                        ),
                        SaveOnSpacer(),

                        //form-surname
                        TextFormField(
                          controller: _surnameCtrl,
                          keyboardType: TextInputType.name,
                          decoration: const InputDecoration(
                            labelText: 'Surname',
                            prefixIcon: Icon(Icons.badge_outlined),
                            hintText: "Enter your surname",
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            focusedErrorBorder: InputBorder.none,
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Please enter your surname';
                            }
                            if (value.trim().length < 2) {
                              return 'Surname must be at least 2 characters';
                            }
                            return null;
                          },
                        ),
                        SaveOnSpacer(),

                        //form-email
                        TextFormField(
                          controller: _emailCtrl,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            labelText: 'Email',
                            prefixIcon: Icon(Icons.email_outlined),
                            hintText: "Enter your email",
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

                        //form-date of birth
                        TextFormField(
                          controller: _dateOfBirthCtrl,
                          readOnly: true,
                          decoration: const InputDecoration(
                            labelText: 'Date of birth (optional)',
                            prefixIcon: Icon(Icons.calendar_today_outlined),
                            hintText: "Select your date of birth",
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            focusedErrorBorder: InputBorder.none,
                          ),
                          validator: (value) {
                            // Date of birth is optional, so no validation needed
                            return null;
                          },
                          onTap: () async {
                            // Show date picker when field is tapped
                            FocusScope.of(context).requestFocus(
                              FocusNode(),
                            ); // Remove keyboard focus

                            final DateTime? picked = await showDatePicker(
                              context: context,
                              initialDate:
                                  _selectedDateOfBirth ??
                                  DateTime.now().subtract(
                                    const Duration(days: 365 * 18),
                                  ),
                              // Default to 18 years ago
                              firstDate: DateTime(1900),
                              lastDate: DateTime.now(),
                              helpText: 'Select date of birth',
                            );

                            if (picked != null &&
                                picked != _selectedDateOfBirth) {
                              setState(() {
                                _selectedDateOfBirth = picked;
                                _dateOfBirthCtrl.text = DateFormat(
                                  'dd.MM.yyyy',
                                ).format(picked);
                              });
                            }
                          },
                        ),
                        SaveOnSpacer(),

                        //form-password
                        TextFormField(
                          controller: _passwordCtrl,
                          obscureText: _hidePassword,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            prefixIcon: const Icon(Icons.lock_outline),
                            hintText: "Enter safe password",
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
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a password';
                            }
                            if (value.length < 8) {
                              return 'Password must be at least 8 characters';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              //remember me and forget password
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child:
                //checkbox for remembering me
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
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
                    SaveOnTextButtonSmall(
                      buttonLabel: "I agree to the processing of Personal date",
                      onPressed: () {
                        setState(() {
                          _rememberMe = !_rememberMe;
                        });
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              //sign up button
              Align(
                child: Container(
                  child: SaveOnButton(
                    buttonText: "Sign up",
                    onPressed: _isLoading ? null : _submit,
                    isLoading: _isLoading,
                  ),
                ),
              ),
              const SizedBox(height: 24),

              //sign up with
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
                        "Sign up with",
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
                        "Already have an account?",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      SizedBox(width: 5),
                      SaveOnTextButtonSmall(
                        buttonLabel: "Sign in",
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => const SaveonLoginPage(),
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

  Future<void> _submit() async {
    // Validate form
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // Check if user agreed to terms
    if (!_rememberMe) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please agree to the processing of Personal data'),
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    // Convert date of birth to ISO format if provided
    String? birthday;
    if (_selectedDateOfBirth != null) {
      // Format as ISO date string (YYYY-MM-DD)
      birthday = DateFormat('yyyy-MM-dd').format(_selectedDateOfBirth!);
    }

    // Call registration API
    final result = await _authService.register(
      email: _emailCtrl.text.trim(),
      password: _passwordCtrl.text,
      name: _nameCtrl.text.trim(),
      surname: _surnameCtrl.text.trim(),
      birthday: birthday,
      // phoneNumber can be added later if you add a phone field
      // phoneNumber: _phoneCtrl.text.trim().isEmpty ? null : _phoneCtrl.text.trim(),
    );

    if (!mounted) return;
    setState(() => _isLoading = false);

    if (result != null) {
      // Registration successful
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Registration successful. Welcome!'),
          backgroundColor: Colors.green,
        ),
      );

      // Navigate to login page after a short delay
      await Future.delayed(const Duration(milliseconds: 500));
      if (!mounted) return;

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const SaveonLoginPage()),
      );
    } else {
      // Registration failed
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Registration failed. Please try again.'),
          backgroundColor: Colors.red,
        ),
      );
    }

    final success = await _authService.login(
      email: _emailCtrl.text.trim(),
      password: _passwordCtrl.text,
    );

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
}
