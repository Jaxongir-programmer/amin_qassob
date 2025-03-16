import 'dart:ui';
import 'dart:ui' as ui;

import 'package:amin_qassob/utils/pref_utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

// import 'package:easy_localization/easy_localization.dart';
import 'package:shimmer/shimmer.dart';

import '../generated/assets.dart';
import '../utils/app_colors.dart';
import 'package:flutter/material.dart';

import 'constants.dart';

void hideKeyboard(BuildContext context) {
  FocusScope.of(context).requestFocus(FocusNode());
}

Color setColor(String color_name) {
  switch (color_name) {
    case "Kok":
      return ACCENT_COLOR;
    case "Qizil":
      return Colors.red;
    case "Sariq":
      return YELLOW_COLOR;
    case "Yashil":
      return PRIMARY_LIGHT_COLOR;
    case "Zangori":
      return Colors.orange;
    default:
      return const Color(0xFFeeeeee);
  }
}

Widget segmentItem({required BuildContext context, required String title, required bool groupValue}) {
  return Container(
      alignment: Alignment.center,
      width: getScreenWidth(context) / 2 - 8,
      height: 40,
      child: Text(title,
          textAlign: TextAlign.center,
          style: TextStyle(color: groupValue ? Colors.black : GREY_COLOR, fontSize: 16, fontWeight: FontWeight.w500)));
}

Widget showMyProgress() {
  return Container(
      alignment: Alignment.center,
      color: BLACK_COLOR.withAlpha(90),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(color: ACCENT_COLOR, blurRadius: 150, spreadRadius: 1, blurStyle: BlurStyle.normal)
          ],
          // border: Border.all(color: WHITE, width: 1),
          color: PRIMARY_COLOR.withAlpha(100),
          borderRadius: BorderRadius.circular(8),
        ),
        child: const CircularProgressIndicator(
          color: Colors.white,
          backgroundColor: Colors.grey,
        ),
      ));
}

showMyBottomSheet(
  BuildContext context,
  Widget child, {
  EdgeInsets? margin,
  double? topRadiuses,
  Color? backgroundColor,
  Color? borderColor,
  double? borderWidth,
  double? minHeight,
}) {
  topRadiuses ??= 16;
  backgroundColor ??= Colors.white;
  margin ??= const EdgeInsets.all(12);
  borderColor ??= ACCENT_COLOR;
  borderWidth ??= 1.0;
  minHeight ??= 200;

  showModalBottomSheet(
      context: context,
      barrierColor: Colors.transparent,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.only(topLeft: Radius.circular(topRadiuses), topRight: Radius.circular(topRadiuses)),
          side: BorderSide(
            width: borderWidth,
            color: borderColor,
          )),
      builder: (context) => Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: backgroundColor,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 8,
                    offset: Offset(1, 1), // Shadow position
                  ),
                ],
                borderRadius:
                    BorderRadius.only(topRight: Radius.circular(topRadiuses!), topLeft: Radius.circular(topRadiuses)),
                shape: BoxShape.rectangle,
                // border: Border.all(color: Colors.white70),
              ),
              child: Stack(
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 8, top: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("     "),
                        Container(
                          width: 60,
                          height: 10,
                          decoration: BoxDecoration(
                              color: ACCENT_COLOR.withOpacity(.4), borderRadius: BorderRadius.circular(8)),
                        ),
                      ],
                    ),
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: minHeight!,
                      // minWidth: 5.0,
                      // maxHeight: 30.0,
                      // maxWidth: 30.0,
                    ),
                    child: Container(margin: margin, child: child),
                  ),
                ],
              ),
            ),
          ));
}

showAsBottomSheet(BuildContext context, Widget child,
    {EdgeInsets? margin,
    double? topRadiuses,
    Color? backgroundColor,
    Color? borderColor,
    double? borderWidth,
    double? minHeight,
    double? maxHeight,
    Color? barrierColor}) {
  topRadiuses ??= 16;
  backgroundColor ??= BACKGROUND_COLOR;
  margin ??= const EdgeInsets.all(12);
  borderColor ??= ACCENT;
  borderWidth ??= 1.0;
  minHeight ??= 100;
  barrierColor ??= BLACK.withOpacity(.7);
  maxHeight ??= MediaQuery.of(context).size.height * .9;
  showModalBottomSheet(
    context: context,
    barrierColor: barrierColor,
    isScrollControlled: true,
    // only work on showModalBottomSheet function
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(topRadiuses), topRight: Radius.circular(topRadiuses)),
        side: BorderSide(
          width: borderWidth,
          color: borderColor,
        )),
    builder: (context) => Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: backgroundColor,
          boxShadow: const [
            BoxShadow(
              color: GREY,
              blurRadius: 8,
              offset: Offset(1, 1), // Shadow position
            ),
          ],
          borderRadius:
              BorderRadius.only(topRight: Radius.circular(topRadiuses!), topLeft: Radius.circular(topRadiuses)),
          shape: BoxShape.rectangle,
          // border: Border.all(color: Colors.white70),
        ),
        child: Stack(
          children: [
            Container(
              margin: const EdgeInsets.only(right: 8, top: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * .3,
                    height: 5,
                    decoration: BoxDecoration(color: WHITE, borderRadius: BorderRadius.circular(8)),
                  ),
                  // InkWell(
                  //     onTap: () {
                  //       Navigator.pop(context);
                  //     },
                  //     child: const Icon(
                  //       Icons.clear_rounded,
                  //       size: 24,
                  //       color: WHITE,
                  //     ))
                ],
              ),
            ),
            ConstrainedBox(
              constraints: BoxConstraints(minHeight: minHeight!, maxHeight: maxHeight!
                  // minWidth: 5.0,
                  // maxWidth: 30.0,
                  ),
              child: Container(margin: margin, child: child),
            ),
          ],
        ),
      ),
    ),
  );
}

TextStyle asTextStyle(
    {String? fontFamily,
    Color? color,
    double? size,
    FontWeight? fontWeight,
    List<Shadow>? shadow,
    TextOverflow? overflow}) {
  color = color ?? WHITE;
  return TextStyle(
      fontFamily: fontFamily ?? "as_med",
      color: color,
      fontSize: size ?? 14,
      shadows: shadow,
      overflow: overflow,
      fontWeight: fontWeight);
}

Widget dialogRoundedShapeB() {
  return Container(
    width: 80,
    height: 10,
    decoration: const BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(12)),
      boxShadow: [BoxShadow(offset: Offset(0, 0), blurRadius: 1.5, spreadRadius: 1.5, color: Colors.grey)],
      color: Colors.white70,
    ),
  );
}

bool isMobile(BuildContext context) {
  return MediaQuery.of(context).size.shortestSide < 600;
}

Future<void> showError(BuildContext context, String message, {Function? pressOk}) async {
  var size = MediaQuery.of(context).size;
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    barrierColor: COLOR_PRIMARY.withAlpha(10), //this works
    builder: (BuildContext context) {
      return Align(
        alignment: Alignment.center,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaY: 4, sigmaX: 4),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Align(
                alignment: Alignment.center,
                child: Container(
                    padding: const EdgeInsets.all(8),
                    width: size.width * 0.8,
                    decoration: BoxDecoration(
                        color: COLOR_PRIMARY.withAlpha(500),
                        borderRadius: const BorderRadius.all(Radius.circular(16)),
                        gradient: const LinearGradient(
                            colors: [Colors.black45, Colors.black87],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter)),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 16),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.error_outlined,
                              size: 36,
                              color: Colors.red,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Text(
                                    "Xatolik !!!",
                                    style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(message,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                      maxLines: 10,
                                      overflow: TextOverflow.ellipsis),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                                onPressed: () {
                                  if (pressOk != null) {
                                    pressOk();
                                    Navigator.pop(context);
                                  } else {
                                    Navigator.pop(context);
                                  }
                                },
                                child: const Text(
                                  "Ha",
                                  style: TextStyle(color: Colors.white),
                                ))
                          ],
                        )
                      ],
                    )),
              ),
            ),
          ),
        ),
      );
    },
  );
}

void clearFocus(BuildContext context) {
  FocusScope.of(context).requestFocus(FocusNode()); //remove focus
}

void startScreenR(BuildContext context, StatefulWidget stl) {
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => stl));
}

void startScreenF(BuildContext context, StatefulWidget stl) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => stl));
}

void startScreenS(BuildContext context, StatelessWidget stl) {
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => stl));
}

void finishScreen(BuildContext context) {
  Navigator.pop(context);
}

@optionalTypeArgs
void finish<T extends Object?>(BuildContext context, [T? result]) {
  return Navigator.of(context).pop<T>(result);
}

double getScreenHeight(context) {
  return MediaQuery.of(context).size.height;
}

double getScreenWidth(context) {
  return MediaQuery.of(context).size.width;
}

Widget asCachedNetworkImage(String? url, {double? height, double? width, BoxFit? fit, BorderRadius? borderRadius}) {
  return ClipRRect(
    borderRadius: borderRadius ?? BorderRadius.circular(0),
    child: CachedNetworkImage(
      // imageUrl: PrefUtils.getBaseImageUrl() + (url ?? ""),
      imageUrl: BASE_IMAGE_URL + (url ?? ""),
      placeholder: (context, url) => const Center(
          child: SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                color: Colors.grey,
              ))),
      errorWidget: (context, url, error) => ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Container(
              color: Colors.grey.shade50,
              padding: const EdgeInsets.all(0),
              child: Center(
                  child: Image.asset(
                Assets.imagesPlaceholder,
              )))),
      height: height,
      width: width,
      alignment: Alignment.center,
      fit: fit ?? BoxFit.cover,
    ),
  );
}

Future<void> showWarning(BuildContext context, String message,
    {Function? pressOk, bool? noButton, bool? forSingOut}) async {
  var size = MediaQuery.of(context).size;
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    barrierColor: COLOR_PRIMARY.withAlpha(10), //this works
    builder: (BuildContext context) {
      return Align(
        alignment: Alignment.center,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaY: 8, sigmaX: 8),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Align(
                alignment: Alignment.center,
                child: Container(
                    padding: const EdgeInsets.all(8),
                    width: size.width * 0.8,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                        gradient: LinearGradient(
                            colors: [Colors.black45, Colors.black87],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter)),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 16),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(width: 8),
                            const Icon(
                              Icons.warning_rounded,
                              size: 36,
                              color: Colors.orange,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Text(
                                    "Diqqat !!!",
                                    style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(message,
                                      style: const TextStyle(color: Colors.white, fontSize: 16),
                                      maxLines: 10,
                                      overflow: TextOverflow.ellipsis)
                                ],
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Visibility(
                                  visible: noButton != null ? true : false,
                                  child: const Text(
                                    "Нет",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                )),
                            TextButton(
                                onPressed: () async {
                                  if (pressOk != null) {
                                    pressOk();
                                    if (forSingOut != true) {
                                      Navigator.pop(context);
                                    }
                                  } else {
                                    Navigator.pop(context);
                                  }
                                },
                                child: const Text(
                                  "OK",
                                  style: TextStyle(color: Colors.white),
                                ))
                          ],
                        )
                      ],
                    )),
              ),
            ),
          ),
        ),
      );
    },
  );
}

Future<void> showSuccess(BuildContext context, String message, {Function? pressOk}) async {
  var size = MediaQuery.of(context).size;
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    barrierColor: COLOR_PRIMARY.withAlpha(10), //this works
    builder: (BuildContext context) {
      return Align(
        alignment: Alignment.center,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaY: 4, sigmaX: 4),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Align(
                alignment: Alignment.center,
                child: Container(
                    padding: const EdgeInsets.all(8),
                    width: size.width * 0.8,
                    decoration: BoxDecoration(
                        color: COLOR_PRIMARY.withAlpha(500),
                        borderRadius: const BorderRadius.all(Radius.circular(16)),
                        gradient: const LinearGradient(
                            colors: [Colors.black45, Colors.black87],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter)),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 16),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.cloud_done_outlined,
                              size: 36,
                              color: Colors.green,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Text(
                                    "Muvaffaqiyatli.",
                                    style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(message,
                                      style: const TextStyle(color: Colors.white, fontSize: 16),
                                      maxLines: 10,
                                      overflow: TextOverflow.ellipsis)
                                ],
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                                onPressed: () {
                                  if (pressOk != null) {
                                    pressOk();
                                    Navigator.pop(context);
                                  } else {
                                    Navigator.pop(context);
                                  }
                                },
                                child: const Text(
                                  "OK",
                                  style: TextStyle(color: Colors.white),
                                ))
                          ],
                        )
                      ],
                    )),
              ),
            ),
          ),
        ),
      );
    },
  );
}

Widget shimmerColors({required Widget child, bool enabled = true}) {
  return Shimmer.fromColors(
    baseColor: Colors.grey.shade300,
    highlightColor: Colors.grey.shade100,
    enabled: enabled,
    child: child,
  );
}

Widget skeleton({double? height, double? width, double? radius}) {
  radius ??= 16;
  return Container(
    height: height,
    width: width,
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(radius)),
  );
}

String asDateFormater(DateTime dateTime, {bool? onlyDate}) {
  var formatter = DateFormat(onlyDate == true ? 'dd.MM.yyyy' : 'dd.MM.yyyy HH:mm');
  return formatter.format(dateTime);
}

Future<Uint8List?> getBytesFromAsset(String path, int width) async {
  ByteData data = await rootBundle.load(path);
  ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
  ui.FrameInfo fi = await codec.getNextFrame();
  return (await fi.image.toByteData(format: ui.ImageByteFormat.png))?.buffer.asUint8List();
}

Future<void> showExitDialog(BuildContext context, String message,
    {Function? pressOk, bool? noButton, bool? forSingOut}) async {
  var size = MediaQuery.of(context).size;
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    barrierColor: Colors.white.withAlpha(10), //this works
    builder: (BuildContext context) {
      return Align(
        alignment: Alignment.center,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaY: 8, sigmaX: 8),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: InkWell(
              onTap: () {
                // Navigator.pop(context);
              },
              child: Align(
                alignment: Alignment.center,
                child: Container(
                    margin: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                        color: COLOR_PRIMARY.withAlpha(500),
                        border: Border.all(width: 1, color: GREY),
                        borderRadius: const BorderRadius.all(Radius.circular(8)),
                        gradient: const LinearGradient(
                            colors: [TEXT_COLOR2, BDM_BLUE], begin: Alignment.bottomLeft, end: Alignment.topRight)),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(
                          height: 24,
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 48, right: 48, top: 16, bottom: 8),
                          child: Text(message,
                              style: const TextStyle(color: WHITE, fontSize: 25, fontFamily: "semibold"),
                              maxLines: 10,
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: size.width * 0.3,
                              decoration: BoxDecoration(
                                border: Border.all(width: 1, color: GREY),
                                borderRadius: const BorderRadius.all(Radius.circular(8)),
                              ),
                              child: TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Visibility(
                                    visible: noButton != null ? true : false,
                                    child: const Text(
                                      "Yo'q",
                                      style: TextStyle(color: WHITE, fontSize: 18),
                                    ),
                                  )),
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            Container(
                              width: size.width * 0.3,
                              decoration: BoxDecoration(
                                border: Border.all(width: 1, color: GREY),
                                borderRadius: const BorderRadius.all(Radius.circular(8)),
                              ),
                              child: TextButton(
                                  onPressed: () {
                                    if (pressOk != null) {
                                      pressOk();
                                      if (forSingOut != true) {
                                        Navigator.pop(context);
                                      }
                                    } else {
                                      Navigator.pop(context);
                                    }
                                  },
                                  child: const Text(
                                    "Ha",
                                    style: TextStyle(color: WHITE, fontSize: 18),
                                  )),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        )
                      ],
                    )),
              ),
            ),
          ),
        ),
      );
    },
  );
}

showAnimatedBlinkDialog(BuildContext context,
    {required Widget child, Duration? duration, Color? barrierColor, bool? closeIconEnabled}) {
  duration ??= const Duration(milliseconds: 700);
  barrierColor ??= Colors.black.withOpacity(.5);
  closeIconEnabled ??= true;
  showGeneralDialog(
    context: context,
    transitionBuilder: (context, animation, secondaryAnimation, child, {Function? close}) {
      return ScaleTransition(
        alignment: Alignment.center,
        scale: CurvedAnimation(
          parent: animation,
          curve: Curves.linear,
          reverseCurve: Curves.bounceIn,
        ),
        child: child,
      );
    },
    transitionDuration: duration,
    barrierColor: barrierColor,
    useRootNavigator: true,
    pageBuilder: (context, Animation<double> animation, Animation<double> secondaryAnimation) {
      return Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Center(
            child: InkWell(
                onTap: () {},
                child: Stack(
                  children: [
                    child,
                    if (closeIconEnabled ?? true)
                      Positioned(
                        right: 0,
                        child: IconButton(
                            onPressed: () {
                              finish(context);
                            },
                            icon: const Padding(
                                padding: EdgeInsets.all(8),
                                child: Icon(
                                  Icons.clear,
                                  color: Colors.red,
                                  size: 16,
                                ))),
                      )
                  ],
                )),
          ),
        ),
      );
    },
  );
}
