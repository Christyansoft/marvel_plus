import 'package:flutter/material.dart';

class HeaderHomeWidget extends StatelessWidget {
  final Function(String text) onChangedText;
  final Function onTapCloseButton;
  final TextEditingController textEditingController;

  const HeaderHomeWidget({
    super.key,
    required this.onChangedText,
    required this.onTapCloseButton,
    required this.textEditingController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),
              Row(
                children: [
                  Text(
                    'MARVEL ',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      color: Theme.of(context).primaryColor,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    'Characters',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 38,
                child: TextFormField(
                  onChanged: onChangedText,
                  controller: textEditingController,
                  textInputAction: TextInputAction.search,
                  decoration: InputDecoration(
                    enabled: true,
                    suffixIcon: IconButton(
                      onPressed: () => onTapCloseButton(),
                      splashRadius: 18,
                      icon: const Icon(
                        Icons.close,
                        color: Colors.grey,
                      ),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
      ],
    );
  }
}
