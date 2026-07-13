import 'package:borsa_now_bis/core/config/utils.dart';
import 'package:borsa_now_bis/core/di/di.dart';
import 'package:borsa_now_bis/screens/contact_page/presentation/manager/contact_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {

  final ContactPageController _contactPageController = getIt<ContactPageController>();

  final TextEditingController _textObjectController = TextEditingController();
  final TextEditingController _textMessageController = TextEditingController();
  final FocusNode _objectFocusNode = FocusNode(canRequestFocus: true);
  final FocusNode _messageFocusNode = FocusNode(canRequestFocus: true);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context,true),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              pushUpAnimation(
                Row(
                  children: [
                    // SvgPicture.asset("assets/icons/my_account.svg"),
                    // SizedBox(width: 20),
                    Text(
                      'help'.tr,
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        color: Colors.black,
                      ),
                    ),
        
                  ],
                ),
              ),
              SizedBox(height: 40,),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  focusNode: _objectFocusNode,
                  onTapOutside: (event) {
                    // code to unfocus after tap outside
                    _objectFocusNode.unfocus(disposition: UnfocusDisposition.previouslyFocusedChild);
                    // FocusScope.of(context).unfocus();
                  },
                  autofocus: false,
                  controller: _textObjectController,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    // hintText: 'Enter your comments here...',
                    labelText: 'object'.tr+"*",
                    border: OutlineInputBorder(), // Adds a standard border
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  focusNode: _messageFocusNode,
                  onTapOutside: (event) {
                    // code to unfocus after tap outside
                    _messageFocusNode.unfocus(disposition: UnfocusDisposition.previouslyFocusedChild);
                  },
                  autofocus: false,
                  controller: _textMessageController,
                  keyboardType: TextInputType.multiline,
                  maxLines: 4, // Allows unlimited vertical expansion
                  minLines: 4, // Sets the initial height
                  decoration: InputDecoration(
                    // hintText: 'Enter your comments here...',
                    labelText: 'message'.tr+"*",
                    border: OutlineInputBorder(), // Adds a standard border
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: ElevatedButton(onPressed: () async {

                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) => Center(
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(20.0),
                          child: CircularProgressIndicator(strokeWidth: 3),
                        ),
                      ),
                    ),
                  );

                  await _contactPageController.contactUs(_textObjectController.text, _textMessageController.text);
                  if (context.mounted) Navigator.of(context).pop();
        
                }, child: Text("send".tr)),
              ),
        
        
            ],
          ),
        ),
      ),
    );
  }

}
