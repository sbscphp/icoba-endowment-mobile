import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icoba_endowment_mobile/core/constants/app_constants.dart';
import 'package:icoba_endowment_mobile/core/data/data_providers/donation_data_provider.dart';
import 'package:icoba_endowment_mobile/core/data/enum/view_state.dart';
import 'package:icoba_endowment_mobile/core/data/models/response_data/campaign_data.dart';
import 'package:icoba_endowment_mobile/core/data/models/response_data/checkout_response.dart';
import 'package:icoba_endowment_mobile/core/data/models/response_data/checkout_validation_response.dart';
import 'package:icoba_endowment_mobile/core/data/states/base_state.dart';
import 'package:icoba_endowment_mobile/core/utilities/utilities.dart';
import 'package:icoba_endowment_mobile/locator.dart';

class GuestDonationVm extends BaseState {
  final DonationDataProvider _dataProvider = locator<DonationDataProvider>();

  //message
  String _message = '';
  String get message => _message;

  String? _selectedCurrency = "NGN";
  String? get selectedCurrency => _selectedCurrency;
  set selectedCurrency(String val) {
    _selectedCurrency = val;
    notifyListeners();
  }

  String? _email;
  String? get email => _email;
  set email(String? val) {
    _email = val;
    notifyListeners();
  }

  String? _phone;
  String? get phone => _phone;
  set phone(String? val) {
    _phone = val;
    notifyListeners();
  }

  String? _fName;
  String? get fName => _fName;
  set fName(String? val) {
    _fName = val;
    notifyListeners();
  }

  String? _lName;
  String? get lName => _lName;
  set lName(String? val) {
    _lName = val;
    notifyListeners();
  }

  String? _orgName;
  String? get orgName => _orgName;
  set orgName(String? val) {
    _orgName = val;
    notifyListeners();
  }

  String? _tin;
  String? get tin => _tin;
  set tin(String? val) {
    _tin = val;
    notifyListeners();
  }

  String? _rcNumber;
  String? get rcNumber => _rcNumber;
  set rcNumber(String? val) {
    _rcNumber = val;
    notifyListeners();
  }

  String? _corporateUUID;
  String? get corporateUUID => _corporateUUID;
  set corporateUUID(String? val) {
    _corporateUUID = val;
    notifyListeners();
  }

  String? _donorType;
  String? get donorType => _donorType;
  set donorType(String? val) {
    _donorType = val;
    notifyListeners();
  }

  String? _setNumber;
  String? get setNumber => _setNumber;
  set setNumber(String? val) {
    _setNumber = val;
    notifyListeners();
  }

  String? _alumniID;
  String? get alumniID => _alumniID;
  set alumniID(String? val) {
    _alumniID = val;
    notifyListeners();
  }

  CampaignData? _selectedCampaign;
  CampaignData? get selectedCampaign => _selectedCampaign;
  set selectedCampaign(CampaignData? campaign) {
    _selectedCampaign = campaign;
    notifyListeners();
  }

  CheckoutResponse? _checkoutResponse;
  CheckoutResponse? get checkoutResponse => _checkoutResponse;

  String get checkoutUrl => _checkoutResponse?.checkoutUrl ?? "";

  //Pay with Card
  Future<void> stripeCheckout({
    required double amount,
    String donationType = 'donation',
    bool isAnonymous = false,
  }) async {
    setDonationState(ViewState.busy);

    final details = {
      "amount": amount,
      "currency": _selectedCurrency,
      "campaign_uuid": _selectedCampaign?.campaignId,
      "donor_type": _donorType,
      "donor_email": _email,
      "donor_phone": _phone,
      //corporate
      "corporate_category_uuid": _corporateUUID,
      "rc_number": _rcNumber,
      "tin": _tin,
      "organization_name": _orgName,
      //alumni
      "set_number": _setNumber,
      "alumni_identifier": _alumniID,
      //friend and family
      "firstname": _fName,
      "lastname": _lName,

      "is_anonymous": isAnonymous,
      "payment_gateway": "stripe", //paystack, stripe
      "frontend_url": "https://icoba-endowment.vercel.app",
      "metadata": {"source": donationType},
    };

    details.removeWhere((key, value) => value == null);

    // log(details.toString());

    await _dataProvider
        .checkoutStripe(details: details)
        .then((response) async {
          _message = response.message ?? defaultSuccessMessage;
          _checkoutResponse = response.data;
          setDonationState(ViewState.retrieved);
        })
        .catchError((e) {
          _message = Utilities.formatMessage(e.toString(), isSuccess: false);
          setDonationState(ViewState.error);
        });
  }

  CheckoutValidationResponse? _checkoutValidationResponse;
  CheckoutValidationResponse? get checkoutValidationResponse =>
      _checkoutValidationResponse;

  String get receiptNumber => _checkoutValidationResponse?.receiptNumber ?? "";

  //manual verify
  Future<void> manualVerifyDonation() async {
    setDonationState(ViewState.busy);

    final details = {
      "checkout_session_id": _checkoutResponse?.checkoutSessionId,
      "payment_gateway": "stripe", //stripe, paystack
    };

    details.removeWhere((key, value) => value == null);

    await _dataProvider
        .manualVerifyDonation(details: details, useAuth: false)
        .then((response) async {
          _message = response.message ?? defaultSuccessMessage;
          _checkoutValidationResponse = response.data;
          setDonationState(ViewState.retrieved);
        })
        .catchError((e) {
          _message = Utilities.formatMessage(e.toString(), isSuccess: false);
          setDonationState(ViewState.error);
        });
  }
}

final guestDonationViewModel = ChangeNotifierProvider<GuestDonationVm>((ref) {
  return GuestDonationVm();
});
