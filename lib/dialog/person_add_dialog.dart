import 'package:belal_pro/db/dbperson.dart';
import 'package:belal_pro/pages/PersonsPage.dart';
import 'package:belal_pro/db/dbhelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PersonAddDialog extends StatelessWidget {
  final String title, positiveBtnText, negativeBtnText;
  final GestureTapCallback positiveBtnPressed;

  final TextEditingController personName = TextEditingController();
  final TextEditingController personMobile = TextEditingController();

// declare a GlobalKey
  final _formKey = GlobalKey<FormState>();
  // declare a variable to keep track of the input text
  String _name = '';

  PersonAddDialog({
    super.key,
    required this.title,
    required this.positiveBtnText,
    required this.negativeBtnText,
    required this.positiveBtnPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      key: _formKey,
      textDirection: TextDirection.rtl,
      child: Dialog(
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: _buildDialogContent(context),
      ),
    );
  }

  Widget _buildDialogContent(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: <Widget>[
        Container(
          // Bottom rectangular box
          margin: const EdgeInsets.only(
              top: 30,)
          , // to push the box half way below circle
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.only(
              top: 60, left: 15, right: 15,)
          , // spacing inside the box
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                title,
                style: Theme.of(context).textTheme.headline5,
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: personName,
                textDirection: TextDirection.rtl,
                decoration: const InputDecoration(
                    icon: Icon(Icons.person_add, size: 25),
                    border: UnderlineInputBorder(),
                    labelText: 'اسم العميل ',
                    labelStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    )),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
                keyboardType: TextInputType.text,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.deny(
                      RegExp(r'[0-9]+[,.]{0,1}[0-9]*')),
                  FilteringTextInputFormatter.deny(RegExp(r'[a-zA-Z]')),
                ],
                // validate after each user interaction
                autovalidateMode: AutovalidateMode.onUserInteraction,
                // The validator receives the text that the user has entered.
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return 'يجب أن لا يكون فارغاً';
                  }
                  if (text.length < 4) {
                    return 'الرقم صغير يجب أن لا يقل عن 4';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: personMobile,
                textDirection: TextDirection.rtl,
                decoration: const InputDecoration(
                  icon: Icon(Icons.mobile_friendly, size: 25),
                  border: UnderlineInputBorder(),
                  labelText: 'رقم العميل ',
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 19,
                  ),
                ),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
                keyboardType: const TextInputType.numberWithOptions(
                  signed: false,
                  decimal: false,
                ),
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                ],
                // validate after each user interaction
                autovalidateMode: AutovalidateMode.onUserInteraction,
                // The validator receives the text that the user has entered.
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return 'يجب أن لا يكون فارغاً';
                  }
                  if (text.length < 10) {
                    return 'الرقم صغير يجب أن لا يقل عن 10';
                  }
                  return null;
                },
              ),
              ButtonBar(
                buttonMinWidth: 100,
                alignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  TextButton(
                    child: Text(
                      negativeBtnText,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  TextButton(
                    onPressed: () {
                      DbPerson dbPerson = DbPerson();
                      dbPerson.addPersons(personName.text, personMobile.text);
                      positiveBtnPressed;
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      positiveBtnText,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const CircleAvatar(
          // Top Circle with icon
          maxRadius: 40.0,
          child: Icon(
            Icons.people_outline_sharp,
            size: 45,
          ),
        ),
      ],
    );
  }
}
