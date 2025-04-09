// import 'package:easy_localization/easy_localization.dart';
import 'dart:io';

import 'package:amin_qassob/screen/main/cart/makeorder/makeorder_viewmodel.dart';
import 'package:amin_qassob/screen/main/home/home_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

import '../../../../../generated/assets.dart';
import '../../../../../provider/providers.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../../utils/utils.dart';
import '../../../main_screen.dart';

class SuccessScreen extends StatefulWidget {
  int orderId;
  double total_pay;
  bool back;

  SuccessScreen({Key? key, required this.orderId, required this.total_pay, required this.back}) : super(key: key);

  @override
  State<SuccessScreen> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
  String imagePath = "";
  final String cardNumber = '31119102504791';

  @override
  void initState() {
    requestGalleryPermission();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Providers>(
      builder: (context, provider, child) {
        return WillPopScope(
          onWillPop: () async {
            return widget.back;
          },
          child: ViewModelBuilder.reactive(
            viewModelBuilder: () => MakeOrderViewModel(),
            builder: (context, viewModel, child) {
              return Scaffold(
                body: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          "Buyurtmangiz qabul qilindi!",
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: BLACK_COLOR),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Image.asset(
                          Assets.imagesSuccesOrder,
                          width: 160,
                          height: 160,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        // Center(child: imagePoly()),
                        Container(
                          padding: const EdgeInsets.all(16),
                          margin: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: COLOR_PRIMARY,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.red.withOpacity(
                                    0.5,
                                  ),
                                  blurStyle: BlurStyle.outer,
                                  blurRadius: 5)
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Jami to'lov: ${widget.total_pay} ₩",
                                  style: asTextStyle(fontFamily: "p_reg", color: BLACK, size: 18, fontWeight: FontWeight.w600)),
                              Text("Korea post bank\nUchekuk bank\n우체국 은행  ( 071)",
                                  style: asTextStyle(fontFamily: "p_reg", color: WHITE, size: 18, fontWeight: FontWeight.w600)),
                              Row(
                                children: [
                                  Text(cardNumber,
                                      style: asTextStyle(
                                          fontFamily: "p_reg", color: BLACK, size: 18, fontWeight: FontWeight.bold)),
                                  IconButton(
                                    icon: Icon(Icons.copy, color: BLACK),
                                    onPressed: () {
                                      Clipboard.setData(ClipboardData(text: cardNumber));
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text('Karta raqami nusxalandi')),
                                      );
                                    },
                                  ),
                                ],
                              ),
                              Text("Ismi  이은호\nTolov chekini tashlab qóyin. Haridingiz uchun Tashakkur.",
                                  style: asTextStyle(fontFamily: "p_reg", color: WHITE, size: 18, fontWeight: FontWeight.w600)),
                            ],
                          ),
                        ),
                        const SizedBox(height: 4),

                        InkResponse(
                          onTap: () {
                            showImageDialog();
                          },
                          child: Container(
                            padding: EdgeInsets.all(imagePath == "" ? 29 : 0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: COLOR_PRIMARY,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.red.withOpacity(
                                      0.5,
                                    ),
                                    blurStyle: BlurStyle.outer,
                                    blurRadius: 5)
                              ],
                            ),
                            child: imagePath == ""
                                ? Icon(
                              Icons.photo_camera,
                              color: WHITE,
                            )
                                : ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.file(
                                  File(imagePath),
                                  height: 81,
                                  width: 81,
                                  fit: BoxFit.cover,
                                )),
                          ),
                        ),
                        // const Text(
                        //   "Xizmatlarimizdan foydalanganingiz uchun rahmat",
                        //   textAlign: TextAlign.center,
                        //   style: TextStyle(fontSize: 18, color: TEXT_COLOR2),
                        // ),
                        const SizedBox(
                          height: 24,
                        ),
                        GestureDetector(
                          onTap: () {
                            viewModel.payment(imagePath, widget.orderId);
                          },
                          child: Container(
                            width: getScreenWidth(context),
                            height: 45,
                            alignment: Alignment.center,
                            margin: const EdgeInsets.only(top: 0, left: 12, right: 12, bottom: 8),
                            padding: const EdgeInsets.all(6),
                            decoration:
                            const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(6)), color: COLOR_PRIMARY),
                            child: const Text(
                              "YUBORISH",
                              style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
            onViewModelReady: (viewModel) {
              viewModel.errorData.listen((event) {
                showError(context, event);
              });

              viewModel.paymentData.listen(
                    (event) {
                  showSuccess(context, "Muvaffaqiyatli!");
                  provider.setIndex(0);
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (ctx) => MainScreen()),
                        (route) => false,
                  );
                },
              );
            },
          ),
        );
      },
    );
  }

  // Widget imagePoly() {
  //   return Row(
  //     children: [
  //       InkWell(
  //         onTap: () {
  //           showImageDialog();
  //         },
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Text(
  //               "Rasm",
  //               style: asTextStyle(),
  //             ),
  //             Container(
  //                 height: 100,
  //                 width: 100,
  //                 margin: const EdgeInsets.only(left: 8, top: 8),
  //                 decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(12)),
  //                 child: Stack(
  //                   alignment: Alignment.bottomRight,
  //                   children: [
  //                     Container(
  //                       padding: EdgeInsets.all(imageFile == "" ? 29 : 0),
  //                       decoration: BoxDecoration(boxShadow: [
  //                         BoxShadow(color: BLACK.withOpacity(.2), blurRadius: 4, blurStyle: BlurStyle.outer)
  //                       ], borderRadius: BorderRadius.circular(8), color: LIGHT_GREY),
  //                       child: imageFile == ""
  //                           ? Image.asset(Assets.imagesPlaceholder,
  //                         height: getScreenHeight(context) / 3,
  //                         width: getScreenWidth(context),
  //                       )
  //                           : ClipRRect(
  //                           borderRadius: BorderRadius.circular(8),
  //                           child: Image.file(
  //                             File(imageFile ?? ""),
  //                             height: getScreenHeight(context) / 3,
  //                             width: getScreenWidth(context),
  //                             fit: BoxFit.cover,
  //                           )),
  //                     ),
  //                   ],
  //                 )),
  //           ],
  //         ),
  //       ),
  //       // InkWell(
  //       //   onTap: () async {
  //       //     FilePickerResult? result = await FilePicker.platform.pickFiles();
  //       //
  //       //     if (result != null) {
  //       //       pasportFile = File(result.files.single.path ?? "");
  //       //       // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //       //       //     content: Text(
  //       //       //   pasportFile?.path.split("/").last ?? "",
  //       //       //   style: asTextStyle(color: AppColors.WHITE),
  //       //       // )));
  //       //       setState(() {});
  //       //     } else {
  //       //       // User canceled the picker
  //       //     }
  //       //   },
  //       //   child: Column(
  //       //     children: [
  //       //       Text(
  //       //         "Obyektivka",
  //       //         style: asTextStyle(),
  //       //       ),
  //       //       Container(
  //       //           width: 100,
  //       //           height: 100,
  //       //           margin: const EdgeInsets.only(top: 8, left: 16),
  //       //           padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
  //       //           decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: AppColors.COLOR_PRIMARY),
  //       //           child: Text(
  //       //             pasportFile == null
  //       //                 ? "Obyektivka biriktirish"
  //       //                 : pasportFile?.path.split("/").last ?? "Obyektivka biriktirish",
  //       //             style: asTextStyle(color: AppColors.WHITE),
  //       //           )),
  //       //     ],
  //       //   ),
  //       // ),
  //       //
  //       // // if (selectIlmiyDaraja != null && selectJob == "O'qituvchi")
  //       // InkWell(
  //       //   onTap: () async {
  //       //     FilePickerResult? result = await FilePicker.platform.pickFiles();
  //       //
  //       //     if (result != null) {
  //       //       diplomFile = File(result.files.single.path ?? "");
  //       //       // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //       //       //     content: Text(
  //       //       //   diplomFile?.path.split("/").last ?? "",
  //       //       //   style: asTextStyle(color: AppColors.WHITE),
  //       //       // )));
  //       //       setState(() {});
  //       //     } else {
  //       //       // User canceled the picker
  //       //     }
  //       //   },
  //       //   child: Column(
  //       //     children: [
  //       //       Text(
  //       //         "OTM Diplomi",
  //       //         style: asTextStyle(),
  //       //       ),
  //       //       Container(
  //       //           width: 100,
  //       //           height: 100,
  //       //           margin: const EdgeInsets.only(top: 8, left: 16),
  //       //           padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
  //       //           decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: AppColors.COLOR_PRIMARY),
  //       //           child: Text(
  //       //             diplomFile == null ? "Fayl biriktirish" : diplomFile?.path.split("/").last ?? "Fayl biriktirish",
  //       //             style: asTextStyle(color: AppColors.WHITE),
  //       //           )),
  //       //     ],
  //       //   ),
  //       // ),
  //     ],
  //   );
  // }

  void showImageDialog() {
    final ImagePicker picker = ImagePicker();
    final alert = AlertDialog(
      backgroundColor: Colors.white,
      title: const Text("Manbaani tanlang", style: TextStyle(color: Colors.black)),
      content: const Text(""),
      actions: [
        TextButton(
            onPressed: () async {
              Navigator.pop(context);
              XFile? image =
              await picker.pickImage(source: ImageSource.camera, imageQuality: 70, maxWidth: 1800, maxHeight: 1800);
              if (image != null) {
                var croppedFile = await ImageCropper().cropImage(
                  sourcePath: image.path,
                  compressQuality: 70,
                  uiSettings: [
                    AndroidUiSettings(
                      toolbarTitle: 'Cropper',
                      // cropStyle: CropStyle.circle,
                      aspectRatioPresets: [
                        CropAspectRatioPreset.square,
                        CropAspectRatioPreset.original,
                      ],
                    ),
                    IOSUiSettings(
                      title: 'Cropper',
                      // cropStyle: CropStyle.circle,
                      aspectRatioPresets: [
                        CropAspectRatioPreset.square,
                        CropAspectRatioPreset.original,
                      ],
                    ),
                  ],
                );
                if (croppedFile != null) {
                  setState(() {
                    imagePath = croppedFile.path;
                    // imageController.text = imagePath;
                    // widget.item?.value = imageController.text;
                    // viewModel.sendImage(imagePath);
                  });
                }
              }
            },
            child: Text(
              "Kamera",
              style: asTextStyle(color: COLOR_PRIMARY),
            )),
        TextButton(
            onPressed: () async {
              Navigator.pop(context);
              XFile? image =
              await picker.pickImage(source: ImageSource.gallery, imageQuality: 60, maxHeight: 1000, maxWidth: 1000);
              if (image != null) {
                var croppedFile = await ImageCropper().cropImage(
                  sourcePath: image.path,
                  compressQuality: 60,
                  uiSettings: [
                    AndroidUiSettings(
                      toolbarTitle: 'Cropper',
                      // cropStyle: CropStyle.circle,
                      aspectRatioPresets: [
                        CropAspectRatioPreset.square,
                        CropAspectRatioPreset.original,
                      ],
                    ),
                    IOSUiSettings(
                      title: 'Cropper',
                      // cropStyle: CropStyle.circle,
                      aspectRatioPresets: [
                        CropAspectRatioPreset.square,
                        CropAspectRatioPreset.original,
                      ],
                    ),
                  ],
                );
                if (croppedFile != null) {
                  //  final size = (await croppedFile.length()) / 1024 / 1024;
                  setState(() {
                    imagePath = croppedFile.path;
                    // imageController.text = imagePath;
                    // widget.item?.value = imageController.text;
                    // viewModel.sendImage(imagePath);
                  });
                }
              }
            },
            child: Text("Galereya", style: asTextStyle(color: COLOR_PRIMARY))),
      ],
    );
    showDialog(context: context, builder: (_) => alert);
  }

  Future<void> requestGalleryPermission() async {
    if (await Permission.photos.isGranted || await Permission.storage.isGranted) {
      print("Permission already granted");
      return;
    }

    if (await Permission.photos
        .request()
        .isGranted || await Permission.storage
        .request()
        .isGranted) {
      print("Permission granted");
    } else {
      print("Permission denied");
    }
  }
}
