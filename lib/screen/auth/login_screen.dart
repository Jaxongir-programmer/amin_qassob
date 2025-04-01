import 'dart:async';
import 'package:amin_qassob/screen/auth/offerta_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:pinput/pinput.dart';
import 'package:stacked/stacked.dart';
import '../../generated/assets.dart';
import '../../utils/app_colors.dart';
import '../../utils/utils.dart';
import '../main/main_screen.dart';
import 'auth_viewmodel.dart';

enum AuthState { phone, sms_code, login, registration }

class LoginScreen extends StatefulWidget {
  LoginScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin {
  var _isActiveButton = false;
  var state = AuthState.phone;

  TextEditingController userNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addresController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final smsController = TextEditingController();
  final focusNode = FocusNode();
  final formKey = GlobalKey<FormState>();
  final _formkey = GlobalKey<FormState>();

  // var phoneFormatter = MaskTextInputFormatter(mask: '010 (##) ### ## ##', type: MaskAutoCompletionType.eager);
  var phoneFormatter = MaskTextInputFormatter(mask: '010 #### ####', type: MaskAutoCompletionType.eager);

  AnimationController? _animationController;
  int levelClock = 180;
  bool reSend = false;

  @override
  void initState() {
    _animationController?.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          reSend = true;
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    smsController.dispose();
    focusNode.dispose();
    _animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const focusedBorderColor = Color.fromRGBO(23, 171, 144, 1);
    const fillColor = Color.fromRGBO(243, 246, 249, 0);
    const borderColor = Color.fromRGBO(23, 171, 144, 0.4);

    final defaultPinTheme = PinTheme(
      width: 45,
      height: 45,
      textStyle: const TextStyle(
        fontSize: 22,
        color: Color.fromRGBO(30, 60, 87, 1),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: borderColor),
      ),
    );

    final userNameField = TextFormField(
      controller: userNameController,
      autofocus: false,
      keyboardType: TextInputType.name,
      textInputAction: TextInputAction.next,
      onSaved: (value) {
        userNameController.text = value!;
      },
      decoration: const InputDecoration(
        hintText: 'Ismingiz',
        hintStyle: TextStyle(color: Colors.grey),
        prefixIcon: Icon(Icons.person),
      ),
    );

    final lastNameField = TextFormField(
      controller: lastNameController,
      autofocus: false,
      keyboardType: TextInputType.name,
      textInputAction: TextInputAction.next,
      onSaved: (value) {
        lastNameController.text = value!;
      },
      decoration: const InputDecoration(
        hintText: 'Familiyangiz',
        hintStyle: TextStyle(color: Colors.grey),
        prefixIcon: Icon(Icons.person),
      ),
    );

    final addressField = TextFormField(
      controller: addresController,
      autofocus: false,
      keyboardType: TextInputType.name,
      textInputAction: TextInputAction.next,
      onSaved: (value) {
        addresController.text = value!;
      },
      decoration: const InputDecoration(
        hintText: 'Manzilingiz',
        hintStyle: TextStyle(color: Colors.grey),
        prefixIcon: Icon(Icons.location_city),
      ),
    );

    final passwordField = TextFormField(
      controller: passwordController,
      autofocus: false,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.next,
      onSaved: (value) {
        passwordController.text = value!;
      },
      decoration: const InputDecoration(
        hintText: 'Parol...',
        hintStyle: TextStyle(color: Colors.grey),
        prefixIcon: Icon(Icons.password),
      ),
    );

    final phoneField = TextFormField(
      controller: phoneController,
      autofocus: false,
      keyboardType: TextInputType.phone,
      textInputAction: TextInputAction.next,
      inputFormatters: [phoneFormatter],
      onSaved: (value) {
        phoneController.text = value!;
      },
      decoration: const InputDecoration(
        hintStyle: TextStyle(color: Colors.grey),
        prefixIcon: Icon(Icons.phone),
        hintText: '010 XXXX XXXX',
      ),
    );

    return ViewModelBuilder<AuthViewModel>.reactive(
      viewModelBuilder: () {
        return AuthViewModel();
      },
      builder: (context, viewModel, child) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Form(
              key: _formkey,
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 50, left: 10),
                    child: InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: const Icon(
                          Icons.arrow_back_ios_rounded,
                          color: COLOR_PRIMARY,
                        )),
                  ),
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.only(top: 100, left: 30, right: 30),
                    child: Image.asset(
                      Assets.imagesAppLogo,
                      height: 160,
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(top: 300),
                      child: Column(
                        children: [
                          (state == AuthState.phone)
                              ? Padding(
                                  padding: const EdgeInsets.only(left: 33, right: 33, bottom: 10),
                                  child: phoneField,
                                )
                              : (state == AuthState.registration)
                                  ? Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(left: 33, right: 33, bottom: 16),
                                          child: userNameField,
                                        ),
                                        //lastname
                                        Padding(
                                          padding: const EdgeInsets.only(left: 33, right: 33, bottom: 16),
                                          child: lastNameField,
                                        ),
                                        //address
                                        Padding(
                                          padding: const EdgeInsets.only(left: 33, right: 33, bottom: 16),
                                          child: addressField,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 33, right: 33, bottom: 16),
                                          child: passwordField,
                                        ),
                                        // Container(
                                        //   alignment: Alignment.center,
                                        //   padding: const EdgeInsets.only(left: 33, right: 33, bottom: 16),
                                        //   child: Directionality(
                                        //     textDirection: TextDirection.ltr,
                                        //     child: Pinput(
                                        //       length: 6,
                                        //       controller: smsController,
                                        //       focusNode: focusNode,
                                        //       // androidSmsAutofillMethod: AndroidSmsAutofillMethod.smsUserConsentApi,
                                        //       // listenForMultipleSmsOnAndroid: true,
                                        //       defaultPinTheme: defaultPinTheme,
                                        //       separatorBuilder: (index) => const SizedBox(width: 8),
                                        //       hapticFeedbackType: HapticFeedbackType.lightImpact,
                                        //       onCompleted: (pin) {
                                        //         debugPrint('onCompleted: $pin');
                                        //       },
                                        //       onChanged: (value) {
                                        //         debugPrint('onChanged: $value');
                                        //       },
                                        //       cursor: Column(
                                        //         mainAxisAlignment: MainAxisAlignment.end,
                                        //         children: [
                                        //           Container(
                                        //             margin: const EdgeInsets.only(bottom: 9),
                                        //             width: 22,
                                        //             height: 1,
                                        //             color: focusedBorderColor,
                                        //           ),
                                        //         ],
                                        //       ),
                                        //       focusedPinTheme: defaultPinTheme.copyWith(
                                        //         decoration: defaultPinTheme.decoration!.copyWith(
                                        //           borderRadius: BorderRadius.circular(15),
                                        //           border: Border.all(color: focusedBorderColor),
                                        //         ),
                                        //       ),
                                        //       submittedPinTheme: defaultPinTheme.copyWith(
                                        //         decoration: defaultPinTheme.decoration!.copyWith(
                                        //           color: fillColor,
                                        //           borderRadius: BorderRadius.circular(8),
                                        //           border: Border.all(color: focusedBorderColor),
                                        //         ),
                                        //       ),
                                        //       errorPinTheme: defaultPinTheme.copyBorderWith(
                                        //         border: Border.all(color: Colors.redAccent),
                                        //       ),
                                        //     ),
                                        //   ),
                                        // ),

                                        // Stack(
                                        //   children: [
                                        //     if (reSend == false)
                                        //       Padding(
                                        //         padding: const EdgeInsets.symmetric(vertical: 8.0),
                                        //         child: Row(
                                        //           mainAxisAlignment: MainAxisAlignment.center,
                                        //           children: [
                                        //             Countdown(
                                        //               animation: StepTween(
                                        //                 begin: levelClock, // THIS IS A USER ENTERED NUMBER
                                        //                 end: 0,
                                        //               ).animate(_animationController!),
                                        //             ),
                                        //             const Text(" da kodni qayta olish mumkin",
                                        //                 style: TextStyle(
                                        //                   fontSize: 16,
                                        //                   color: COLOR_BDM_DARK,
                                        //                 )),
                                        //           ],
                                        //         ),
                                        //       ),
                                        //     if (reSend)
                                        //       Row(
                                        //         mainAxisAlignment: MainAxisAlignment.center,
                                        //         children: [
                                        //           InkWell(
                                        //             onTap: () async {
                                        //               reSend = false;
                                        //               viewModel.smsCheck(
                                        //                 phoneController.text
                                        //                     // .replaceAll("+", "")
                                        //                     .replaceAll(" ", "")
                                        //                     .replaceAll("(", "")
                                        //                     .replaceAll(")", ""),
                                        //               );
                                        //               _animationController!.reset();
                                        //               _animationController!.forward();
                                        //               _animationController?.addStatusListener((status) {
                                        //                 if (status == AnimationStatus.completed) {
                                        //                   setState(() {
                                        //                     reSend = true;
                                        //                   });
                                        //                 }
                                        //               });
                                        //             },
                                        //             child: Padding(
                                        //               padding: const EdgeInsets.symmetric(vertical: 8.0),
                                        //               child: Text(
                                        //                 "Kodni qayta yuborish",
                                        //                 style: TextStyle(
                                        //                     fontSize: 18,
                                        //                     color: Theme.of(context).primaryColor,
                                        //                     fontFamily: "medium",
                                        //                     decorationColor: Theme.of(context).primaryColor,
                                        //                     decoration: TextDecoration.underline),
                                        //               ),
                                        //             ),
                                        //           ),
                                        //         ],
                                        //       )
                                        //   ],
                                        // ),
                                      ],
                                    )
                                  : Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                  children: [
                                                    const Text(
                                                      "Parolni kiriting",
                                                      style: TextStyle(
                                                        color: TEXT_COLOR2,
                                                        fontSize: 24,
                                                        fontFamily: "bold",
                                                      ),
                                                    ),
                                                    Text(
                                                      "Telefon raqam: ${phoneController.text}",
                                                      style: const TextStyle(
                                                          fontWeight: FontWeight.w500, fontSize: 16, fontFamily: "regular"),
                                                    ),
                                                    const SizedBox(
                                                      height: 16,
                                                    )
                                                  ],
                                                ),
                                              ),
                                              passwordField,
                                              // Container(
                                              //   alignment: Alignment.center,
                                              //   padding: const EdgeInsets.only(left: 33, right: 33, bottom: 10),
                                              //   child: Directionality(
                                              //     textDirection: TextDirection.ltr,
                                              //     child: Pinput(
                                              //       length: 6,
                                              //       controller: smsController,
                                              //       focusNode: focusNode,
                                              //       // androidSmsAutofillMethod: AndroidSmsAutofillMethod.smsUserConsentApi,
                                              //       // listenForMultipleSmsOnAndroid: true,
                                              //       defaultPinTheme: defaultPinTheme,
                                              //       separatorBuilder: (index) => const SizedBox(width: 8),
                                              //       hapticFeedbackType: HapticFeedbackType.lightImpact,
                                              //       onCompleted: (pin) {
                                              //         debugPrint('onCompleted: $pin');
                                              //       },
                                              //       onChanged: (value) {
                                              //         debugPrint('onChanged: $value');
                                              //       },
                                              //       cursor: Column(
                                              //         mainAxisAlignment: MainAxisAlignment.end,
                                              //         children: [
                                              //           Container(
                                              //             margin: const EdgeInsets.only(bottom: 9),
                                              //             width: 22,
                                              //             height: 1,
                                              //             color: focusedBorderColor,
                                              //           ),
                                              //         ],
                                              //       ),
                                              //       focusedPinTheme: defaultPinTheme.copyWith(
                                              //         decoration: defaultPinTheme.decoration!.copyWith(
                                              //           borderRadius: BorderRadius.circular(15),
                                              //           border: Border.all(color: focusedBorderColor),
                                              //         ),
                                              //       ),
                                              //       submittedPinTheme: defaultPinTheme.copyWith(
                                              //         decoration: defaultPinTheme.decoration!.copyWith(
                                              //           color: fillColor,
                                              //           borderRadius: BorderRadius.circular(8),
                                              //           border: Border.all(color: focusedBorderColor),
                                              //         ),
                                              //       ),
                                              //       errorPinTheme: defaultPinTheme.copyBorderWith(
                                              //         border: Border.all(color: Colors.redAccent),
                                              //       ),
                                              //     ),
                                              //   ),
                                              // ),
                                              // const SizedBox(
                                              //   height: 16,
                                              // ),
                                              // Stack(
                                              //   children: [
                                              //     if (reSend == false)
                                              //       Row(
                                              //         mainAxisAlignment: MainAxisAlignment.center,
                                              //         children: [
                                              //           Countdown(
                                              //             animation: StepTween(
                                              //               begin: levelClock, // THIS IS A USER ENTERED NUMBER
                                              //               end: 0,
                                              //             ).animate(_animationController!),
                                              //           ),
                                              //           const Text(" da kodni qayta olish mumkin",
                                              //               style: TextStyle(
                                              //                 fontSize: 16,
                                              //                 color: COLOR_BDM_DARK,
                                              //                 fontFamily: "medium",
                                              //               )),
                                              //         ],
                                              //       ),
                                              //     if (reSend)
                                              //       Row(
                                              //         mainAxisAlignment: MainAxisAlignment.center,
                                              //         children: [
                                              //           InkWell(
                                              //             onTap: () async {
                                              //               reSend = false;
                                              //               viewModel.smsCheck(
                                              //                 phoneController.text
                                              //                     // .replaceAll("+", "")
                                              //                     .replaceAll(" ", "")
                                              //                     .replaceAll("(", "")
                                              //                     .replaceAll(")", ""),
                                              //               );
                                              //               _animationController!.reset();
                                              //               _animationController!.forward();
                                              //               _animationController?.addStatusListener((status) {
                                              //                 if (status == AnimationStatus.completed) {
                                              //                   setState(() {
                                              //                     reSend = true;
                                              //                   });
                                              //                 }
                                              //               });
                                              //             },
                                              //             child: Text(
                                              //               "Qayta yuboring",
                                              //               style: TextStyle(
                                              //                   fontSize: 18,
                                              //                   color: Theme.of(context).primaryColor,
                                              //                   fontFamily: "medium",
                                              //                   decorationColor: Theme.of(context).primaryColor,
                                              //                   decoration: TextDecoration.underline),
                                              //             ),
                                              //           ),
                                              //         ],
                                              //       )
                                              //   ],
                                              // ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                          if (state == AuthState.phone)
                            Padding(
                              padding: const EdgeInsets.only(top: 16, left: 24),
                              child: Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _isActiveButton = !_isActiveButton;
                                      });
                                    },
                                    icon: Icon(
                                      _isActiveButton ? Icons.check_box : Icons.check_box_outline_blank,
                                      color: _isActiveButton ? Colors.green : Colors.blueGrey,
                                    ),
                                    iconSize: 20,
                                  ),
                                  RichText(
                                      text: TextSpan(style: const TextStyle(color: GREY), children: <TextSpan>[
                                    TextSpan(
                                        text: "Foydalanish Shartlari",
                                        style: const TextStyle(color: Colors.green, fontWeight: FontWeight.w500),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            // _isActiveButton = _getActiveButton();
                                            Navigator.push(context, MaterialPageRoute(builder: (context) => OffertaScreen()));
                                          }),
                                    const TextSpan(
                                        text: "  bilan tanishib chiqdim", style: TextStyle(fontWeight: FontWeight.w500)),
                                  ])),
                                ],
                              ),
                            ),
                          //sign button
                          SizedBox(
                            height: 50,
                            width: 320,
                            child: TextButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      (!_isActiveButton && state == AuthState.phone) ? FULL_GREY : COLOR_PRIMARY),
                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                      RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)))),
                              onPressed: () async {
                                if (state == AuthState.phone) {
                                  if (phoneController.text.length < 13 || !_isActiveButton) {
                                    return;
                                  } else {
                                    viewModel.smsCheck(
                                      phoneController.text
                                          // .replaceAll("+", "")
                                          .replaceAll(" ", "")
                                          .replaceAll("(", "")
                                          .replaceAll(")", ""),
                                    );
                                    _animationController =
                                        AnimationController(vsync: this, duration: Duration(seconds: levelClock));
                                    _animationController!.forward();
                                    _animationController?.addStatusListener((status) {
                                      if (status == AnimationStatus.completed) {
                                        setState(() {
                                          reSend = true;
                                        });
                                      }
                                    });
                                  }
                                } else if (state == AuthState.login) {
                                  viewModel.login(
                                    phoneController.text.replaceAll(" ", "").replaceAll("(", "").replaceAll(")", ""),
                                    passwordController.text,
                                  );
                                } else {
                                  if (passwordController.text == "") {
                                    Fluttertoast.showToast(
                                        msg: "Parolni kiriting !",
                                        toastLength: Toast.LENGTH_SHORT,
                                        backgroundColor: ACCENT,
                                        textColor: Colors.white);
                                    print("HATOLIK");
                                  } else {
                                    if (userNameController.text == "" ||
                                        lastNameController.text == "" ||
                                        addresController.text == "") {
                                      Fluttertoast.showToast(msg: "Kerakli maydonlarni to'ldiring");
                                      return;
                                    }
                                    viewModel.registration(
                                      phoneController.text.replaceAll(" ", "").replaceAll("(", "").replaceAll(")", ""),
                                      userNameController.text,
                                      lastNameController.text,
                                      passwordController.text,
                                      addresController.text,
                                    );
                                  }
                                }
                              },
                              child: Text(
                                state == AuthState.phone
                                    ? "Tekshirish"
                                    : state == AuthState.sms_code
                                        ? "SMS code olish"
                                        : "Tasdiqlash",
                                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          if (state == AuthState.phone)
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 30.0),
                              child: Text("Tizimga kirish uchun telefon raqam bilan tasdiqlash talab qilinadi",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: COLOR_BDM_DARK,
                                  )),
                            ),
                        ],
                      ))
                ],
              ),
            ),
          ),
        );
      },
      onViewModelReady: (viewModel) {
        viewModel.getPublicOffer();

        viewModel.errorData.listen((event) {
          showError(context, event);
        });

        viewModel.registerData.listen((event) async {
          // viewModel.smsCheck(event);
          Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (BuildContext context) {
                return MainScreen();
              },
            ),
            (_) => false,
          );
        });


        viewModel.tokenData.listen((event) async {
          Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (BuildContext context) {
                return MainScreen();
              },
            ),
            (_) => false,
          );
        });

        viewModel.smsCheckData.listen((event) {
          setState(() {
            state = event ? AuthState.login : AuthState.registration;
          });
        });
      },
    );
  }
}

class Countdown extends AnimatedWidget {
  Countdown({Key? key, required this.animation}) : super(key: key, listenable: animation);
  Animation<int> animation;

  @override
  build(BuildContext context) {
    Duration clockTimer = Duration(seconds: animation.value);

    String timerText =
        '${clockTimer.inMinutes.remainder(60).toString()}:${clockTimer.inSeconds.remainder(60).toString().padLeft(2, '0')}';
    return Text(
      timerText,
      style: TextStyle(
        fontSize: 18,
        color: Theme.of(context).primaryColor,
        fontFamily: "medium",
      ),
    );
  }
}
