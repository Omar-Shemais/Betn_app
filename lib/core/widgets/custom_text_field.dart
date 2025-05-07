import 'package:flutter/material.dart';
import 'package:furnitrue_app/core/utils/app_colors/app_colors.dart';
import 'package:furnitrue_app/core/utils/dimensions/dimensions.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    required this.hint,
    this.prefixIcon,
    this.suffixIcon,
    this.onChange,
    this.isObsecure,
    this.onTap,
    this.controller,
    this.textInputAction,
    this.validator,
    this.hasUnderline = false,
    this.height,
    this.width,
    this.borderRadius, // New customizable radius
    this.keyboardType,
    this.readOnly, // New customizable keyboardType
  });

  final String hint;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Function(String)? onChange;
  final bool? isObsecure;
  final void Function()? onTap;
  final TextEditingController? controller;
  final TextInputAction? textInputAction;
  final String? Function(String?)? validator;
  final bool hasUnderline;

  final double? height; // New
  final double? width; // New
  final BorderRadiusGeometry? borderRadius; // New
  final TextInputType? keyboardType; // New
  final bool? readOnly; // 🔥 add this

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 0.width, left: 0.width),
      child: SizedBox(
        height: widget.height?.height,
        width: widget.width?.width,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: widget.borderRadius ?? BorderRadius.circular(16),
            color: _isFocused ? AppColors.secondaryColor : AppColors.offWhite,
          ),
          child: TextFormField(
            readOnly: widget.readOnly ?? false,
            keyboardType: widget.keyboardType ?? TextInputType.text,
            focusNode: _focusNode,
            cursorColor: AppColors.black,
            cursorWidth: 1,
            obscureText: widget.isObsecure ?? false,
            onChanged: widget.onChange,
            onTap: widget.onTap,
            controller: widget.controller,
            validator: widget.validator,
            textInputAction: widget.textInputAction,
            style: const TextStyle(
              fontSize: 16,
              color: AppColors.black,
              fontWeight: FontWeight.w400,
            ),
            decoration: InputDecoration(
              prefixIcon: widget.prefixIcon,
              suffixIcon: widget.suffixIcon,
              hintText: _isFocused ? '' : widget.hint,
              hintStyle: TextStyle(
                color: AppColors.lightTextColor,
                fontFamily: 'roboto',
                fontWeight: FontWeight.w900,
                fontSize: 14.width,
              ),
              contentPadding: EdgeInsets.symmetric(
                vertical: 15.height,
                horizontal: 20.width,
              ),
              border:
                  widget.hasUnderline
                      ? const UnderlineInputBorder()
                      : InputBorder.none,
              focusedBorder:
                  widget.hasUnderline
                      ? const UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColors.primaryColor,
                          width: 3,
                        ),
                      )
                      : InputBorder.none,
              enabledBorder:
                  widget.hasUnderline
                      ? const UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColors.primaryColor,
                          width: 3,
                        ),
                      )
                      : InputBorder.none,
            ),
          ),
        ),
      ),
    );
  }
}

/*
import 'package:flutter/material.dart';
import 'package:furnitrue_app/core/utils/app_colors/app_colors.dart';
import 'package:furnitrue_app/core/utils/dimensions/dimensions.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    required this.hint,
    this.prefixIcon,
    this.suffixIcon,
    this.onChange,
    this.isObsecure,
    this.onTap,
    this.controller,
    this.textInputAction,
    this.validator,
    this.hasUnderline = false,
    this.height,
    this.width,
    this.borderRadius,
    this.focusedColor, // New customizable focused color
    this.fillColor, // New customizable fill color
  });

  final String hint;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Function(String)? onChange;
  final bool? isObsecure;
  final void Function()? onTap;
  final TextEditingController? controller;
  final TextInputAction? textInputAction;
  final String? Function(String?)? validator;
  final bool hasUnderline;

  final double? height;
  final double? width;
  final BorderRadiusGeometry? borderRadius;
  final Color? focusedColor; // New
  final Color? fillColor; // New

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 0.width, left: 0.width),
      child: SizedBox(
        height: widget.height?.height,
        width: widget.width?.width,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: widget.borderRadius ?? BorderRadius.circular(16),
            color:
                _isFocused
                    ? (widget.focusedColor ?? AppColors.secondaryColor)
                    : (widget.fillColor ?? AppColors.offWhite),
          ),
          child: TextFormField(
            focusNode: _focusNode,
            cursorColor: AppColors.black,
            cursorWidth: 1,
            obscureText: widget.isObsecure ?? false,
            onChanged: widget.onChange,
            onTap: widget.onTap,
            controller: widget.controller,
            validator: widget.validator,
            textInputAction: widget.textInputAction,
            style: const TextStyle(
              fontSize: 16,
              color: AppColors.black,
              fontWeight: FontWeight.w400,
            ),
            decoration: InputDecoration(
              prefixIcon: widget.prefixIcon,
              suffixIcon: widget.suffixIcon,
              hintText: _isFocused ? '' : widget.hint,
              hintStyle: TextStyle(
                color: AppColors.lightTextColor,
                fontFamily: 'roboto',
                fontWeight: FontWeight.w900,
                fontSize: 14.width,
              ),
              contentPadding: EdgeInsets.symmetric(
                vertical: 15.height,
                horizontal: 20.width,
              ),
              border:
                  widget.hasUnderline
                      ? const UnderlineInputBorder()
                      : InputBorder.none,
              focusedBorder:
                  widget.hasUnderline
                      ? const UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColors.primaryColor,
                          width: 3,
                        ),
                      )
                      : InputBorder.none,
              enabledBorder:
                  widget.hasUnderline
                      ? const UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColors.primaryColor,
                          width: 3,
                        ),
                      )
                      : InputBorder.none,
            ),
          ),
        ),
      ),
    );
  }
}

*/
