import 'package:amin_qassob/generated/assets.dart';
import 'package:amin_qassob/utils/utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../extensions/extensions.dart';
import '../utils/app_colors.dart';
import '../utils/constants.dart';
import '../utils/pref_utils.dart';

extension CustomViews on Widget {
  static Widget buildText(String title, String text,
      {TextEditingController? controller,
        TextInputType? inputType,
        Color? textColor,
        TextCapitalization? textCapitalization,
        TextInputAction? textInputAction,
        bool thousandFormat = false,
        bool enabled = true,
        Function(String)? onChanged,
        TextInputFormatter? textInputFormatter}) {
    textCapitalization ??= TextCapitalization.none;
    textInputAction ??= TextInputAction.next;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if(title!="")Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
         const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: GREY_LIGHT_COLOR),
          child: Text(text != "" ? text : title,
              style: TextStyle(fontSize: 16, color: text != "" ? Colors.black : GREY_COLOR)),
        ),
      ],
    );
  }

  static Widget buildSelectCategory(String title, String? selectedData,
      {String? hint,
        Function? onTap,
        Function? onTapRIcon,
        Widget? leadingIcon,
        IconData? rightIcon,
        Color? rightIconColor,
        Color? textColor,
        Function? clearSelected}) {
    bool haveText = selectedData != null &&
        selectedData.isNotEmpty &&
        selectedData != noSelected;
    Widget _selectWidget() {
      return Row(
        children: [
          leadingIcon != null
              ? Padding(
              padding:
              const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
              child: leadingIcon)
              : const SizedBox(height: 52, width: 12),
          Expanded(
            child: Text(
              haveText ? selectedData : hint ?? title,
              style: asTextStyle(
                color: haveText ? textColor : GREY_TEXT_COLOR,
                fontWeight: FontWeight.w600,
                size: 16,
              ),

              // TextStyle(
              //     color: haveText ? textColor : colorGray, fontSize: 16),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          onTapRIcon == null
              ? Container(
              margin: (clearSelected != null && haveText)
                  ? const EdgeInsets.only(left: 10)
                  : const EdgeInsets.symmetric(horizontal: 10),
              child:
              const Icon(Icons.expand_more, color: GREY))
              : InkWell(
            onTap: () {
              onTapRIcon();
            },
            child: Container(
                padding: (clearSelected != null && haveText)
                    ? const EdgeInsets.only(left: 10)
                    : const EdgeInsets.symmetric(
                    horizontal: 10, vertical: 10),
                child: const Icon(Icons.location_on_outlined,
                    color: PRIMARY_COLOR)),
          )
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: GREY_LIGHT_COLOR,
              border: Border.all(
                  color: haveText ? PRIMARY_COLOR : Colors.transparent)),
          child: Row(
            children: [
              Expanded(
                child: onTap != null
                    ? InkWell(
                    onTap: () {
                      FocusManager.instance.primaryFocus?.unfocus();
                      onTap();
                    },
                    child: _selectWidget())
                    : _selectWidget(),
              ),
              if (clearSelected != null && haveText)
                InkWell(
                  onTap: () {
                    clearSelected();
                  },
                  child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      child: const Icon(CupertinoIcons.xmark, size: 20)),
                ),
            ],
          ),
        ),
      ],
    );
  }

  static Widget getMaterialButton(BuildContext context, String label, Color color, VoidCallback onTap) {
    return ElevatedButton(
        onPressed: onTap,
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0), side: BorderSide(color: color))),
          backgroundColor: MaterialStateProperty.all(color),
          padding: MaterialStateProperty.all(EdgeInsets.all(16)),
        ),
        child: Text(label));
  }

  static Widget buildProgressView(List<Widget> views, Stream<bool> progress) {
    views.add(StreamBuilder<bool>(
        stream: progress,
        builder: (context, snapshot) {
          return snapshot.hasData && snapshot.requireData
              ? InkWell(
                  child: Container(
                    color: Colors.black38,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                )
              : SizedBox();
        }));
    return Stack(
      children: views,
    );
  }

  static Widget buildLoadingView(Widget view, bool progress) {
    return Stack(
      children: [
        view,
        if (progress)
          InkWell(
            child: Container(
              color: Colors.black26,
              child: Center(
                child: Lottie.asset("assets/lottie/loading.json", repeat: true),
              ),
            ),
          )
      ],
    );
  }

  static Widget buildNetworkImage(String? url, {double? height, double? width, BoxFit? fit}) {
    return CachedNetworkImage(
      imageUrl: PrefUtils.getBaseImageUrl() + (url ?? ""),
      placeholder: (context, url) => Center(
          child: Container(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                color: Colors.grey,
              ))),
      errorWidget: (context, url, error) => ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Container(
              color: Colors.white,
              child: Center(
                  child: Image.asset(Assets.imagesAppLogo,
              )))),
      height: height,
      width: width,
      fit: fit ?? BoxFit.cover,
    );
  }

  static Widget buildTextField(String title, String hint,
      {TextEditingController? controller,
      TextInputType? inputType,
      IconData? prefixIcon,
      Function? onChanged,
      MaskTextInputFormatter? maskTextInputFormatter,
      bool obscureText = false,
      bool enabled = true}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 12, color: BLACK_COLOR),
        ),
        const SizedBox(
          height: 8,
        ),
        TextFormField(
          controller: controller,
          textInputAction: TextInputAction.next,
          keyboardType: inputType,
          maxLines: 2,
          enabled: enabled,
          inputFormatters: maskTextInputFormatter != null ? [maskTextInputFormatter] : null,
          onChanged: (text) {
            if (onChanged != null) {
              onChanged(text);
            }
          },
          decoration: InputDecoration(
              prefixIcon: prefixIcon != null
                  ? Icon(
                      prefixIcon,
                      color: Colors.grey.shade500,
                    )
                  : null,
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: HexColor.fromHex("#EBF0FF"), width: 1.5),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              filled: true,
              hintStyle: TextStyle(color: Colors.grey),
              contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              hintText: hint,
              fillColor: Colors.white70),
        )
      ],
    );
  }

  static Widget buildSearchTextField(String hint,
      {TextEditingController? controller,
      TextInputType? inputType,
      IconData? prefixIcon,
      Function? onChanged,
      MaskTextInputFormatter? maskTextInputFormatter,
      bool obscureText = false,
      bool enabled = true}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox.fromSize(
          size: Size.fromHeight(56),
          child: TextField(
            controller: controller,
            textInputAction: TextInputAction.next,
            keyboardType: inputType,
            maxLines: 1,
            enabled: enabled,
            inputFormatters: maskTextInputFormatter != null ? [maskTextInputFormatter] : null,
            onChanged: (text) {
              if (onChanged != null) {
                onChanged(text);
              }
            },
            decoration: InputDecoration(
                prefixIcon: prefixIcon != null
                    ? Icon(
                        prefixIcon,
                        color: Colors.grey.shade500,
                      )
                    : null,
                enabledBorder: new OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 1),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                filled: true,
                hintStyle: TextStyle(color: Colors.grey),
                hintText: hint,
                fillColor: Colors.white70),
          ),
        )
      ],
    );
  }

  static Widget buildMiniTextField(String title, String hint,
      {TextEditingController? controller,
      TextInputType? inputType,
      IconData? prefixIcon,
      Function? onChanged,
        int? minLine,
        int? maxLine,
      MaskTextInputFormatter? maskTextInputFormatter,
      bool obscureText = false,
        bool? autofocus,
      bool enabled = true}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 12, color: BLACK_COLOR),
        ),
        SizedBox(height: 4),
        SizedBox.fromSize(
          // size: Size.fromHeight(56),
          child: TextField(
            controller: controller,
            textInputAction: TextInputAction.next,
            keyboardType: inputType,
            minLines: minLine??1,
            maxLines: maxLine??1,
            enabled: enabled,
            autofocus: autofocus??false,
            inputFormatters: maskTextInputFormatter != null ? [maskTextInputFormatter] : null,
            onChanged: (text) {
              if (onChanged != null) {
                onChanged(text);
              }
            },
            style: TextStyle(color: enabled ? Colors.black : Colors.grey),
            decoration: InputDecoration(
                prefixIcon: prefixIcon != null
                    ? Icon(
                        prefixIcon,
                        color: PRIMARY_COLOR,
                      )
                    : null,
                enabledBorder: new OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 1),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                filled: true,
                hintStyle: TextStyle(color: Colors.grey),
                hintText: hint,
                fillColor: Colors.white70),
          ),
        )
      ],
    );
  }

  static Widget buildMoreTextField(String title, String hint,
      {TextEditingController? controller, bool enabled = true, IconData? prefixIcon, Function? onChanged}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 12, color: BLACK_COLOR),
        ),
        const SizedBox(
          height: 8,
        ),
        TextField(
          controller: controller,
          textInputAction: TextInputAction.newline,
          keyboardType: TextInputType.multiline,
          maxLines: 3,
          enabled: enabled,
          onChanged: (text) {
            if (onChanged != null) {
              onChanged(text);
            }
          },
          decoration: InputDecoration(
              prefixIcon: prefixIcon != null
                  ? Icon(
                      prefixIcon,
                      color: Colors.grey.shade500,
                    )
                  : null,
              enabledBorder: new OutlineInputBorder(
                borderSide: BorderSide(color: HexColor.fromHex("#EBF0FF"), width: 1.5),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              filled: true,
              hintStyle: TextStyle(color: Colors.grey),
              hintText: hint,
              fillColor: Colors.white70),
        )
      ],
    );
  }
}
