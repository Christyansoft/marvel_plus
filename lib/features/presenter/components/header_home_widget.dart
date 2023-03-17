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
                    'BUSCA MARVEL',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      color: Theme.of(context).primaryColor,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    'TESTE FRONT-END',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                'Nome do Personagem',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).primaryColor,
                  fontSize: 16,
                ),
              ),
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
        Container(
          height: 40,
          padding: const EdgeInsets.only(left: 92),
          width: double.infinity,
          color: Theme.of(context).primaryColor,
          child: const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Nome',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
