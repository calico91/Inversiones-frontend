import 'package:flutter/material.dart';
import 'package:inversiones/src/ui/pages/utils/enums.dart';
import 'package:inversiones/src/ui/pages/utils/general.dart';
import 'package:inversiones/src/ui/pages/utils/validate_form.dart';

class TextFieldLogin extends StatefulWidget {
  const TextFieldLogin({
    super.key,
    this.hintText,
    this.controller,
    this.validateText,
    this.prefixIcon,
    this.obscureText,
    this.suffixIcon,
    this.fillColor,
    this.widthTextField = 0.73,
    this.title = '',
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
  });

  final String? hintText;
  final TextEditingController? controller;
  final ValidateText? validateText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool? obscureText;
  final Color? fillColor;
  final double? widthTextField;
  final String title;
  final AutovalidateMode autovalidateMode;

  @override
  State<TextFieldLogin> createState() => _TextFieldLoginState();
}

class _TextFieldLoginState extends State<TextFieldLogin> {
  late final FocusNode _focusNode;
  late final TextEditingController _controller;
  final GlobalKey<FormFieldState<String>> _formFieldKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _focusNode = FocusNode();
    _focusNode.addListener(_handleFocusChange);
  }

  void _handleFocusChange() {
    if (_focusNode.hasFocus) {
      _formFieldKey.currentState?.validate();
    }
  }

  @override
  void dispose() {
    _focusNode.removeListener(_handleFocusChange);
    _focusNode.dispose();
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.title, textAlign: TextAlign.right),
        const SizedBox(height: 5),
        SizedBox(
          width: General.mediaQuery(context).width * widget.widthTextField!,
          child: TextFormField(
            key: _formFieldKey,
            focusNode: _focusNode,
            controller: _controller,
            textDirection: TextDirection.ltr,
            validator: (String? value) => ValidateForm().validateStructure(
              value,
              true,
              widget.validateText!,
            ),
            autovalidateMode: widget.autovalidateMode,
            inputFormatters:
                ValidateForm.validateInputFormatters(widget.validateText!),
            keyboardType: TextInputType.text,
            textAlign: TextAlign.left,
            maxLength: ValidateForm.validateMaxLength(widget.validateText!),
            onChanged: (String? value) {
              if (value != null) {
                final cleanValue = General.removerCaracteresEspeciales(value);
                _controller.text = cleanValue;
                _controller.selection = TextSelection.fromPosition(
                  TextPosition(offset: _controller.text.length),
                );
              }
            },
            obscureText: widget.obscureText ?? false,
            decoration: InputDecoration(
              prefixIconColor: const Color.fromRGBO(31, 33, 36, 0.8),
              suffixIconColor: const Color.fromRGBO(31, 33, 36, 0.8),
              prefixIcon: widget.prefixIcon,
              suffixIcon: widget.suffixIcon,
              filled: true,
              fillColor:
                  widget.fillColor ?? const Color.fromRGBO(165, 165, 165, 0.2),
              hintText: widget.hintText ?? '',
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: Colors.grey[100]!, width: 0.2),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(
                  color: Color(0xFF1B80BF),
                  width: 1.5,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(
                  color: Colors.red,
                  width: 1.5,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
