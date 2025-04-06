import 'package:flutter/material.dart';
import 'package:inversiones/src/ui/pages/utils/general.dart';

class TextFieldSearch extends StatefulWidget {
  const TextFieldSearch({
    super.key,
    required this.labelText,
    required this.onChanged,
    this.controller,
    this.widthTextFieldSearch = 0.91,
  });

  final String labelText;
  final Function(String) onChanged;
  final TextEditingController? controller;
  final double? widthTextFieldSearch;

  @override
  State<TextFieldSearch> createState() => _TextFieldSearchState();
}

class _TextFieldSearchState extends State<TextFieldSearch> {
  late final TextEditingController _controller;
  bool hasText = false;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _controller.addListener(_handleTextChange);
  }

  void _handleTextChange() {
    if (!mounted) {
      return;
    }
    setState(() {
      hasText = _controller.text.isNotEmpty;
    });
  }

  @override
  void dispose() {
    _controller.removeListener(_handleTextChange);
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: General.mediaQuery(context).width * widget.widthTextFieldSearch!,
      child: TextField(
        controller: _controller,
        onChanged: (String? value) {
          if (value != null) {
            final cleanValue = General.removerCaracteresEspeciales(value);
            _controller.text = cleanValue;
            _controller.selection = TextSelection.fromPosition(
              TextPosition(offset: cleanValue.length),
            );
            widget.onChanged.call(cleanValue);
          }
        },
        decoration: InputDecoration(
          labelText: widget.labelText,
          suffixIcon: hasText
              ? IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _controller.clear();
                    widget.onChanged('');
                  },
                )
              : const Icon(Icons.search),
          filled: true,
          fillColor: const Color.fromRGBO(165, 165, 165, 0.15),
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
          hintStyle: const TextStyle(letterSpacing: 0.2),
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
    );
  }
}
