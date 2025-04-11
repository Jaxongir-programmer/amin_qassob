import 'package:amin_qassob/extensions/extensions.dart';
import 'package:amin_qassob/lang.g.dart';
import 'package:amin_qassob/provider/providers.dart';
import 'package:amin_qassob/screen/main/cart/makeorder/success/success_screen.dart';
import 'package:amin_qassob/utils/utils.dart';
import 'package:easy_localization/easy_localization.dart';

// import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

import '../../../../generated/assets.dart';
import '../../../../model/address_model.dart';
import '../../../../model/make_order_model.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/pref_utils.dart';
import '../../../../view/custom_views.dart';
import '../../home/hearder.dart';
import '../map/google_map_screen.dart';
import 'makeorder_viewmodel.dart';

class MakeOrderScreen extends StatefulWidget {
  MakeOrderModel orderModel;

  MakeOrderScreen(this.orderModel, {Key? key}) : super(key: key);

  @override
  _MakeOrderScreenState createState() => _MakeOrderScreenState();
}

class _MakeOrderScreenState extends State<MakeOrderScreen> {
  // MapItemModel? selectMap;
  String deliverDate = "";
  String? deliverDateForLabel;
  var extraPhoneController = TextEditingController(text: "+998 (");
  var commentController = TextEditingController();
  var orientrController = TextEditingController();
  var phoneFormatter = MaskTextInputFormatter(mask: '+998 (##) ### ## ##', type: MaskAutoCompletionType.eager);

  AddressModel? selectedAddress;

  DateFormat format = DateFormat("dd.MM.yyyy HH:mm");

  final List<PaymentModel> paymentTypes = [
    // PaymentModel("click", 1),
    PaymentModel(LocaleKeys.card.tr(), 2),
    // PaymentModel("naqd", 3),
  ];

  final List<PaymentModel> genderList = [
    PaymentModel("Erkak kishi", 1),
    PaymentModel("Ayol kishi", 1),
  ];

  String? selectedPayment;
  int? paymentId;

  String? selectedGender;
  int? genderId;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Consumer<Providers>(
      builder: (BuildContext context, Providers provider, Widget? child) {
        return ViewModelBuilder<MakeOrderViewModel>.reactive(
          viewModelBuilder: () {
            return MakeOrderViewModel();
          },
          builder: (BuildContext context, MakeOrderViewModel viewModel, Widget? child) {
            return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                title: Text(LocaleKeys.confirm.tr()),
              ),
              body: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              // if (provider.cartSumma <= (PrefUtils.getUser()?.orderSummaLimit ?? 0))
                              //   infowDeliverSummaWidget(provider),
                              phoneAndTimeWidget(),
                              // const SizedBox(
                              //   height: 20,
                              // ),
                              // cashBackWidget(),
                              const SizedBox(
                                height: 20,
                              ),
                              addressWidget(provider),
                              // const SizedBox(
                              //   height: 20,
                              // ),
                              // genderWidget(),
                              const SizedBox(
                                height: 10,
                              ),
                              commentWidget(),
                            ],
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Divider(),
                          payTypeWidget(),
                          Padding(
                            padding: const EdgeInsets.only(left: 16.0, right: 16, top: 4, bottom: 8),
                            child: !viewModel.progressOrderData
                                ? ElevatedButton(
                                    onPressed: () {
                                      // if (deliverDate == "") {
                                      //   showWarning(context, "Yetkazib berish vaqtini tanlang !");
                                      // } else
                                      if (selectedPayment == null) {
                                        showWarning(context, LocaleKeys.choose_payment.tr());
                                      }
                                      // else if (provider.getSelectAdres == null) {
                                      //   showWarning(context, "Yetkazib berish manzilini tanlang !");
                                      // }
                                      else {
                                        widget.orderModel.phone2 = extraPhoneController.text
                                            .replaceAll(" ", "")
                                            .replaceAll("(", "")
                                            .replaceAll(")", "");
                                        widget.orderModel.comment = commentController.text;
                                        // widget.orderModel.order_time = (format.parse(deliverDate).millisecondsSinceEpoch/1000).toString();
                                        widget.orderModel.order_time = "";
                                        // widget.orderModel.order_time = "2025-03-09T12:00:00Z";
                                        widget.orderModel.lat = provider.getSelectAdres?.lat.toString() ?? "41.2995";
                                        widget.orderModel.lon = provider.getSelectAdres?.long.toString() ?? "69.2401";
                                        widget.orderModel.address = orientrController.text;
                                        widget.orderModel.payment_type = paymentId ?? 3;
                                        viewModel.makeOrder(widget.orderModel);
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor: PRIMARY_COLOR,
                                      backgroundColor: PRIMARY_COLOR,
                                      shadowColor: PRIMARY_COLOR,
                                      elevation: 3,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                                    ),
                                    child: Text(
                                      LocaleKeys.confirm.tr().toUpperCase(),
                                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                                    ))
                                : const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            );
          },
          onViewModelReady: (viewModel) {
            viewModel.errorData.listen((event) {
              showError(context, event);
            });

            viewModel.makeOrderData.listen((event) {
              startScreenF(
                  context,
                  SuccessScreen(
                      orderId: event, total_pay: (Providers().cartSumma + widget.orderModel.deliver_summa), back: false));
              PrefUtils.clearCart();
            });
          },
        );
      },
    );
  }

  Widget infowDeliverSummaWidget(Providers provider) {
    double summa = (PrefUtils.getUser()?.orderSummaLimit ?? 0) - provider.cartSumma;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
      decoration: const BoxDecoration(color: Colors.red, borderRadius: BorderRadius.all(Radius.circular(12))),
      child: Row(
        children: [
          Image.asset(
            Assets.profileShieldDone2x,
            color: Colors.white,
            width: 24,
            height: 24,
          ),
          const SizedBox(
            width: 8,
          ),
          const Expanded(
              child: Text(
            "Bepul yetkazish uchun yana ",
            style: TextStyle(color: Colors.white),
          )),
          Text(
            "${summa.formattedAmountString()} ₩",
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }

  Widget phoneAndTimeWidget() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.grey.shade300, width: 2)),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      LocaleKeys.phone_number.tr(),
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Row(
                      children: [
                        Text(
                          (PrefUtils.getUser()?.phone_number ?? ""),
                          style: const TextStyle(fontSize: 13),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Text(
                          extraPhoneController.text.length < 19 ? "" : extraPhoneController.text,
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              InkWell(
                  onTap: addPhoneBox,
                  child: Icon(
                    Icons.add,
                    color: Colors.grey.shade500,
                  ))
            ],
          ),
          // const SizedBox(
          //   height: 6,
          // ),
          // Divider(
          //   color: Colors.grey.shade300,
          // ),
          // InkWell(
          //     onTap: () async {
          //       hourPicer();
          //     },
          //     child: Padding(
          //       padding: const EdgeInsets.symmetric(vertical: 6.0),
          //       child: Row(
          //         children: [
          //           const Icon(
          //             Icons.access_time_rounded,
          //             size: 20,
          //           ),
          //           const SizedBox(
          //             width: 8,
          //           ),
          //           Expanded(
          //             child: Text(
          //               deliverDateForLabel ?? "Yetkazib berish vaqti",
          //               style: const TextStyle(fontSize: 16),
          //             ),
          //           ),
          //           Icon(
          //             Icons.arrow_forward_ios_outlined,
          //             size: 20,
          //             color: Colors.grey.shade500,
          //           )
          //         ],
          //       ),
          //     ))
        ],
      ),
    );
  }

  Widget addressWidget(Providers provider) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.grey.shade300, width: 2)),
      child: Column(
        children: [
          InkWell(
            onTap: () async {
              var r = await Navigator.push(context, MaterialPageRoute(builder: (_) => const GoogleMapScreen()));
              if (r is AddressModel) {
                setState(() {
                  selectedAddress = r;
                });
              }
              // addressListDialog(context, provider);
            },
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${"Yetkazish manzili"}:  ${provider.getSelectAdres?.reName ?? ""}",
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        // provider.getSelectAdres?.name ?? "Manzil kiritilmagan",
                        "${selectedAddress?.lat ?? "Manzil tanlang"}  ${selectedAddress?.long ?? ""}",
                        style: const TextStyle(fontSize: 13),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios_outlined,
                  size: 20,
                  color: Colors.grey.shade500,
                )
              ],
            ),
          ),
          const SizedBox(
            height: 6,
          ),
          Divider(
            color: Colors.grey.shade300,
          ),
          InkWell(
            onTap: openOrientrBox,
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        LocaleKeys.orientr.tr(),
                        style: TextStyle(fontSize: 16),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        orientrController.text != "" ? orientrController.text : "Mo'ljal kiritilmagan",
                        style: const TextStyle(fontSize: 13),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios_outlined,
                  size: 20,
                  color: Colors.grey.shade500,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget payTypeWidget() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  LocaleKeys.select_payment_type.tr(),
                  style: TextStyle(fontSize: 13),
                ),
                const SizedBox(
                  height: 4,
                ),
                SizedBox(
                  height: 60,
                  width: 120,
                  child: FormField<String>(
                    builder: (FormFieldState<String> state) {
                      return InputDecorator(
                        decoration: const InputDecoration(
                            labelStyle: TextStyle(
                              fontSize: 12,
                            ),
                            contentPadding: EdgeInsets.symmetric(horizontal: 8),
                            errorStyle: TextStyle(color: Colors.redAccent, fontSize: 12.0),
                            border: OutlineInputBorder()),
                        isEmpty: selectedPayment == '',
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            hint: Text(
                              LocaleKeys.select_payment_type.tr(),
                              style: TextStyle(fontSize: 12),
                            ),
                            value: selectedPayment,
                            isDense: true,
                            onChanged: (value) {
                              setState(() {
                                selectedPayment = value.toString();
                              });
                              if (selectedPayment == "click") {
                                paymentId = 1;
                              } else if (selectedPayment == "terminal") {
                                paymentId = 2;
                              } else {
                                paymentId = 3;
                              }
                            },
                            items: paymentTypes
                                .map((item) => DropdownMenuItem<String>(
                                      value: item.name,
                                      child: Text(
                                        item.name,
                                        style: const TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                    ))
                                .toList(),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                LocaleKeys.total_amount.tr(),
                style: TextStyle(fontSize: 16),
              ),
              Text(
                "${(Providers().cartSumma + widget.orderModel.deliver_summa).formattedAmountString()} ₩",
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget commentWidget() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.grey.shade300, width: 2)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: openCommentBox,
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        LocaleKeys.comment.tr(),
                        style: TextStyle(fontSize: 16),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        commentController.text == "" ? LocaleKeys.no_comment.tr() : commentController.text,
                        style: const TextStyle(fontSize: 13),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios_outlined,
                  size: 20,
                  color: Colors.grey.shade500,
                )
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 6.0),
            child: Divider(),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                LocaleKeys.delivery_price.tr(),
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                "${widget.orderModel.deliver_summa.formattedAmountString()}₩",
                style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget genderWidget() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      height: 60,
      width: 120,
      child: FormField<String>(
        builder: (FormFieldState<String> state) {
          return InputDecorator(
            decoration: const InputDecoration(
                labelStyle: TextStyle(
                  fontSize: 12,
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 16),
                errorStyle: TextStyle(color: Colors.redAccent, fontSize: 12.0),
                border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(8)))),
            isEmpty: selectedGender == '',
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                hint: const Text(
                  "Yetkazib beruvchini tanlang",
                  style: TextStyle(fontSize: 14),
                ),
                value: selectedGender,
                isDense: true,
                onChanged: (value) {
                  setState(() {
                    selectedGender = value.toString();
                  });
                  if (selectedGender == "Erkak kishi") {
                    genderId = 1;
                  } else if (selectedGender == "Ayol kishi") {
                    genderId = 2;
                  }
                },
                items: genderList
                    .map((item) => DropdownMenuItem<String>(
                          value: item.name,
                          child: Text(
                            item.name,
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ))
                    .toList(),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget cashBackWidget() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.grey.shade300)),
      child: Row(
        children: [
          CircleAvatar(
            radius: 15,
            backgroundColor: Colors.grey.shade300,
            child: Image.asset(
              Assets.imagesAvatar,
              width: 25,
              height: 25,
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          const Expanded(
              child: Text(
            "Keshbek",
            style: TextStyle(fontSize: 16),
          )),
          Text(
            // "${widget.orderModel.total_cashback.formattedAmountString()} UZS",
            "",
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          )
        ],
      ),
    );
  }

  openOrientrBox() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16.0))),
            contentPadding: const EdgeInsets.only(top: 10.0),
            content: Container(
              width: getScreenWidth(context),
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        "Manzil:",
                        style: TextStyle(fontSize: 24.0),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  TextField(
                    controller: orientrController,
                    autofocus: true,
                    decoration: InputDecoration(
                      hintText: LocaleKeys.orientr.tr(),
                      contentPadding: EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                      border: InputBorder.none,
                    ),
                    minLines: 2,
                    maxLines: 6,
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {});
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                      margin: const EdgeInsets.symmetric(vertical: 12),
                      decoration: const BoxDecoration(
                        color: PRIMARY_COLOR,
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                      child: Text(
                        LocaleKeys.save.tr(),
                        style: TextStyle(color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  openCommentBox() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16.0))),
            contentPadding: const EdgeInsets.only(top: 10.0),
            content: Container(
              width: getScreenWidth(context),
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        "Izoh",
                        style: TextStyle(fontSize: 24.0),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  TextField(
                    controller: commentController,
                    autofocus: true,
                    decoration: const InputDecoration(
                      hintText: "Izoh",
                      contentPadding: EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                      border: InputBorder.none,
                    ),
                    minLines: 2,
                    maxLines: 6,
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {});
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                      margin: const EdgeInsets.symmetric(vertical: 12),
                      decoration: const BoxDecoration(
                        color: PRIMARY_COLOR,
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                      child: Text(
                        LocaleKeys.save.tr(),
                        style: TextStyle(color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  addPhoneBox() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16.0))),
            contentPadding: const EdgeInsets.only(top: 10.0),
            content: Container(
              width: getScreenWidth(context),
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        "Qo'shimcha raqam",
                        style: TextStyle(fontSize: 14.0),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  CustomViews.buildMiniTextField("", "+998 (xx) xxx xx xx",
                      maskTextInputFormatter: phoneFormatter,
                      controller: extraPhoneController,
                      autofocus: true,
                      inputType: TextInputType.phone),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      setState(() {});
                    },
                    child: Container(
                      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                      margin: const EdgeInsets.symmetric(vertical: 12),
                      decoration: const BoxDecoration(
                        color: PRIMARY_COLOR,
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                      child: Text(
                        LocaleKeys.save.tr(),
                        style: TextStyle(color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  void hourPicer() {
    DateTime today = DateTime.now();
    DateTime tomorrow = DateTime.now().add(const Duration(days: 1));
    List<TimeClas> timeListToday = [];
    List<TimeClas> timeListTomorrow = [];
    int selectDay = 0;
    int selectHour = 0;

    List<TimeClas> oclockList = [
      TimeClas("8.00 - 9.00", 08),
      TimeClas("9.00 - 10.00", 09),
      TimeClas("10.00 - 11.00", 10),
      TimeClas("11.00 - 12.00", 11),
      TimeClas("12.00 - 13.00", 12),
      TimeClas("13.00 - 14.00", 13),
      TimeClas("14.00 - 15.00", 14),
      TimeClas("15.00 - 16.00", 15),
      TimeClas("16.00 - 17.00", 16),
      TimeClas("17.00 - 18.00", 17),
      TimeClas("18.00 - 19.00", 18),
      TimeClas("19.00 - 20.00", 19),
    ];

    if (today.hour < 20 && today.hour >= 8) {
      for (var i = (today.hour + 1); i < 20; i++) {
        timeListToday.add(TimeClas("${i.toDouble().toStringAsFixed(2)} - ${(i + 1).toDouble().toStringAsFixed(2)}", i.toInt()));
      }
      timeListTomorrow = oclockList.sublist(0, 5);
    } else if (today.hour < 8) {
      timeListToday = oclockList;
      timeListTomorrow = oclockList.sublist(0, 5);
    }

    if (today.hour > 18) {
      today = today.add(const Duration(days: 1));
      tomorrow = today.add(const Duration(days: 2));
      timeListToday = oclockList;
      timeListTomorrow = oclockList.sublist(0, 5);
    }

    showMyBottomSheet(context, StatefulBuilder(
      builder: (BuildContext context, void Function(void Function()) setState2) {
        return SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(
                height: 40,
              ),
              IconButton(
                  onPressed: () {
                    finish(context);
                  },
                  icon: const Icon(
                    CupertinoIcons.left_chevron,
                    color: PRIMARY_COLOR,
                  )),
              Container(
                color: Colors.white,
                padding: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                  bottom: 16,
                ),
                child: CupertinoSlidingSegmentedControl<int>(
                  backgroundColor: GREY_LIGHT_COLOR,
                  thumbColor: Colors.white,
                  groupValue: selectDay,
                  children: {
                    0: segmentItem(context: context, title: today.hour >= 19 ? "Ertaga" : "Bugun", groupValue: selectDay == 0),
                    1: segmentItem(
                        context: context, title: today.hour >= 19 ? "Ertadan keyin" : "Ertaga", groupValue: selectDay == 1),
                  },
                  onValueChanged: (value) {
                    setState2(() {
                      selectDay = value ?? 0;
                    });
                  },
                ),
              ),
              ListView.separated(
                itemCount: selectDay == 0 ? timeListToday.length : timeListTomorrow.length,
                primary: false,
                shrinkWrap: true,
                itemBuilder: (ctx, index) {
                  var item = selectDay == 0 ? timeListToday[index] : timeListTomorrow[index];
                  return InkWell(
                    onTap: () {
                      setState2(() {
                        for (var element in (selectDay == 0 ? timeListToday : timeListTomorrow)) {
                          element.isSelected = false;
                        }
                        selectHour = item.time;
                        item.isSelected = true;
                      });
                    },
                    child: Text(
                      item.name,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold, color: item.isSelected ? PRIMARY_COLOR : TEXT_COLOR2),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(
                    height: 16,
                  );
                },
              ),
              const SizedBox(
                height: 40,
              ),
              Container(
                height: 50,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(16)),
                  color: PRIMARY_COLOR,
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(4, 8),
                      blurRadius: 20,
                      color: PRIMARY_COLOR.withOpacity(0.25),
                    ),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: const BorderRadius.all(Radius.circular(29)),
                    onTap: () {
                      setState(() {
                        deliverDate =
                            "${selectDay == 0 ? asDateFormater(today).substring(0, 10) : asDateFormater(tomorrow).toString().substring(0, 10)} ${selectHour.toString().length == 1 ? "0$selectHour" : selectHour}:00";
                        deliverDateForLabel =
                            "${selectDay == 0 ? asDateFormater(today).substring(0, 10) : asDateFormater(tomorrow).toString().substring(0, 10)}  $selectHour:00 - ${selectHour + 1}:00";
                        finish(context);
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          LocaleKeys.save.tr(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // Text(
              //     "${selectDay == 0 ? asDateFormater(today).substring(0, 10) : asDateFormater(tomorrow).toString().substring(0, 10)} $selectHour:00")
            ],
          ),
        );
      },
    ));
  }
}

class PaymentModel {
  final String name;
  final int id;

  PaymentModel(this.name, this.id);
}

class TimeClas {
  final String name;
  final int time;
  bool isSelected = false;

  TimeClas(this.name, this.time);
}
