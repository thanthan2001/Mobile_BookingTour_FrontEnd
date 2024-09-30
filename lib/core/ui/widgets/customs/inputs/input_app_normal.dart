import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Thêm import này để sử dụng FilteringTextInputFormatter
import 'package:reading_app/core/configs/app_dimens.dart';
import 'package:reading_app/core/configs/themes/app_colors.dart';
import 'package:reading_app/core/ui/widgets/customs/texts/lable.dart';
import 'package:reading_app/core/ui/widgets/customs/texts/text_normal.dart';

class InputAppNormal extends StatefulWidget {
  final String lable;
  final String placeholder;
  final Widget? prefixIcon;

  final bool isPassword;
  final bool isNumeric; // Thêm thuộc tính để xác định kiểu bàn phím
  final TextEditingController controller; // Sử dụng thuộc tính controller
  final String errorMess;

  const InputAppNormal({
    super.key,
    this.lable = "",
    this.prefixIcon,
    this.placeholder = "",
    this.isPassword = false, // Thêm tham số để xác định trường mật khẩu
    this.isNumeric = false,
    required this.controller,
    this.errorMess = "", // Chuyển thành required
  });

  @override
  // ignore: library_private_types_in_public_api
  _InputAppNormalState createState() => _InputAppNormalState();
}

class _InputAppNormalState extends State<InputAppNormal> {
  final FocusNode _focusNode = FocusNode();
  bool _obscureText = true; // Để kiểm soát việc hiển thị mật khẩu

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.lable.isNotEmpty
            ? Lable(contentChild: widget.lable)
            : const SizedBox(),
        Container(
          padding: const EdgeInsets.symmetric(
              // horizontal: AppDimens.paddingSpace20,
              vertical: AppDimens.paddingSpace5),
          // margin: const EdgeInsets.only(top: AppDimens.paddingSpace5),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppDimens.radius10),
              color: AppColors.textLight),
          child: TextField(
            controller: widget.controller, // Sử dụng widget.controller
            focusNode: _focusNode,
            obscureText: widget.isPassword
                ? _obscureText
                : false, // Sử dụng _obscureText cho mật khẩu
            textCapitalization: TextCapitalization.sentences,
            keyboardType: widget.isNumeric
                ? TextInputType.number
                : TextInputType.text, // Chuyển đổi kiểu bàn phím
            inputFormatters: widget.isNumeric
                ? [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(1)
                  ]
                : null, // Hạn chế chỉ cho phép một ký tự số
            style: const TextStyle(color: AppColors.textNormal),
            decoration: InputDecoration(
              prefixIcon: widget.prefixIcon,
              hintText: widget.placeholder,
              hintStyle: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: AppColors.textNormal.withOpacity(.5)),
              border: InputBorder.none,
              suffixIcon: widget.isPassword
                  ? IconButton(
                      icon: Icon(
                        _obscureText ? Icons.visibility : Icons.visibility_off,
                        color: AppColors.textNormal,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureText =
                              !_obscureText; // Chuyển đổi giữa ẩn/hiện mật khẩu
                        });
                      },
                    )
                  : null,
            ),
            onEditingComplete: () {
              // Tắt bàn phím khi ấn enter
              _focusNode.unfocus(); // Sử dụng _focusNode để tắt bàn phím
            },
          ),
        ),
        TextNormal(
          contentChild: widget.errorMess,
          colorChild: AppColors.red,
        )
      ],
    );
  }
}
