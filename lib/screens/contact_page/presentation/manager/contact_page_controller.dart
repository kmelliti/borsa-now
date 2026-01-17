import 'package:borsa_now_bis/core/services/contact_page_service.dart';

class ContactPageController {

  final ContactPageService _contactPageService;

  ContactPageController(this._contactPageService);

  Future contactUs(String object, String body) async {
    return await _contactPageService.contactUs(object, body);
  }
}