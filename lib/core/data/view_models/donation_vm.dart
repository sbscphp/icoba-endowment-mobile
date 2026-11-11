import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icoba_endowment_mobile/core/constants/api_routes.dart';
import 'package:icoba_endowment_mobile/core/data/data_providers/donation_data_provider.dart';
import 'package:icoba_endowment_mobile/core/data/models/response_data/checkout_response.dart';
import 'package:icoba_endowment_mobile/core/data/models/response_data/checkout_validation_response.dart';
import 'package:icoba_endowment_mobile/core/data/models/response_data/pledge_data.dart';
import 'package:open_filex_plus/open_filex_plus.dart';
// import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';

import '../../../locator.dart';
import '../../constants/app_constants.dart';
import '../../utilities/utilities.dart';
import '../enum/view_state.dart';
import '../models/response_data/bank_data.dart';
import '../models/response_data/campaign_data.dart';
import '../models/response_data/create_pledge_response.dart';
import '../models/response_data/initiate_transfer_response.dart';
import '../states/base_state.dart';

class DonationVm extends BaseState {
  final DonationDataProvider _dataProvider = locator<DonationDataProvider>();

  //message
  String _message = '';
  String get message => _message;

  List<CampaignData> _campaigns = [];
  List<CampaignData> get campaigns => _campaigns;

  CampaignData? _selectedCampaign;
  CampaignData? get selectedCampaign => _selectedCampaign;
  set selectedCampaign(CampaignData? campaign) {
    _selectedCampaign = campaign;
    notifyListeners();
  }

  Future<void> getCampaignDropDowns() async {
    setDonationState(ViewState.busy);

    // details.removeWhere((key, value) => value == null);

    await _dataProvider
        .getCampaignDropdown()
        .then((response) async {
          _message = response.message ?? defaultSuccessMessage;
          _campaigns = response.data ?? [];
          setDonationState(ViewState.retrieved);
        })
        .catchError((e) {
          _message = Utilities.formatMessage(e.toString(), isSuccess: false);
          setDonationState(ViewState.error);
        });
  }

  CampaignData? _designatedCampaign;
  CampaignData? get designatedCampaign => _designatedCampaign;

  //values
  List<String> get supportedCurrencies =>
      _designatedCampaign?.availableDonationCurrencies ?? [];
  List<String> prefillAmount = ["100,000", "500,000", "1,000,000", "2,000,000"];
  String selectedAmount = "";

  String? _selectedCurrency = "NGN";
  String? get selectedCurrency => _selectedCurrency;
  set selectedCurrency(String val) {
    _selectedCurrency = val;
    notifyListeners();
  }

  Future<void> getSingleCampaign() async {
    setDonationState(ViewState.busy);

    // details.removeWhere((key, value) => value == null);

    await _dataProvider
        .getSingleCampaign(campaignId: _selectedCampaign?.campaignId ?? "")
        .then((response) async {
          _message = response.message ?? defaultSuccessMessage;
          _designatedCampaign = response.data;
          setDonationState(ViewState.retrieved);
        })
        .catchError((e) {
          _message = Utilities.formatMessage(e.toString(), isSuccess: false);
          setDonationState(ViewState.error);
        });
  }

  List<String> paymentMethods = ["Bank transfer", "Pay with Card"];

  String? _selectedPaymentMethod;
  String? get selectedPaymentMethod => _selectedPaymentMethod;
  set selectedPaymentMethod(String? val) {
    _selectedPaymentMethod = val;
    notifyListeners();
  }

  CheckoutResponse? _checkoutResponse;
  CheckoutResponse? get checkoutResponse => _checkoutResponse;

  String get checkoutUrl => _checkoutResponse?.checkoutUrl ?? "";

  //Pay with Card
  Future<void> stripeCheckout({
    required double amount,
    required String donationPurpose,
    String donationType = 'donation',
    bool isAnonymous = false,
  }) async {
    setDonationState(ViewState.busy);

    final details = {
      "amount": amount,
      "currency": _selectedCurrency,
      "campaign_uuid": _designatedCampaign?.campaignId,
      // "pledge_uuid": "f9fbee7f-5248-40ae-9b9a-4bde475eaad0",//todo::: handle pedge uuid
      "purpose": donationPurpose,
      "is_anonymous": isAnonymous,
      "payment_gateway": "stripe", //stripe, paystack
      "metadata": {"source": donationType},
      "frontend_url": "https://icoba-endowment.vercel.app",
    };

    details.removeWhere((key, value) => value == null);

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
        .manualVerifyDonation(details: details)
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

  BankAccountData? _bankAccountData;

  List<BankData> get bankAccounts => _bankAccountData?.accounts ?? [];
  String get bankName => _bankAccountData?.bankName ?? "N/A";
  String get accountName => _bankAccountData?.accountName ?? "N/A";

  BankData? selectedAccount;

  Future<void> getBankData() async {
    setDonationState(ViewState.busy);

    // details.removeWhere((key, value) => value == null);

    await _dataProvider
        .getAvailableBanks()
        .then((response) async {
          _message = response.message ?? defaultSuccessMessage;
          _bankAccountData = response.data;
          setDonationState(ViewState.retrieved);
        })
        .catchError((e) {
          _message = Utilities.formatMessage(e.toString(), isSuccess: false);
          setDonationState(ViewState.error);
        });
  }

  InitiateTransferResponse? initiateTransferResponse;

  //Pay with Bank
  Future<void> initiateBankTransfer({
    required double amount,
    String donationType = 'donation',
  }) async {
    setDonationState(ViewState.busy);

    final details = {
      "amount": amount,
      "currency": _selectedCurrency,
      "campaign_uuid": _designatedCampaign?.campaignId,
      //   "pledge_uuid": "17e8ac58-765b-4a8c-9bfc-7f1691883b23",
      "is_anonymous": false,
      "metadata": {"source": donationType},
      "paid_into_account_key": selectedAccount
          ?.accountKey, //fcmb_ngn, fcmb_usd, fcmb_eur, fcmb_gpb (must match with currency)
    };

    details.removeWhere((key, value) => value == null);

    await _dataProvider
        .initiateBankTransfer(details: details)
        .then((response) async {
          _message = response.message ?? defaultSuccessMessage;
          initiateTransferResponse = response.data;
          setDonationState(ViewState.retrieved);
        })
        .catchError((e) {
          _message = Utilities.formatMessage(e.toString(), isSuccess: false);
          setDonationState(ViewState.error);
        });
  }

  //Acknowledge Payment
  Future<void> acknowledgeBankTransfer() async {
    setDonationState(ViewState.busy);

    // details.removeWhere((key, value) => value == null);

    await _dataProvider
        .acknowledgeBankTransfer(
          transactionUUID: initiateTransferResponse?.transactionUuid ?? "",
        )
        .then((response) async {
          _message = response.message ?? defaultSuccessMessage;
          initiateTransferResponse = response.data;
          setDonationState(ViewState.retrieved);
        })
        .catchError((e) {
          _message = Utilities.formatMessage(e.toString(), isSuccess: false);
          setDonationState(ViewState.error);
        });
  }

  //PLEDGES
  List<String> pledgeTypes = [
    "One - time future payment",
    "Monthly Installments",
    "Custom schedule",
  ];

  String? selectedPledgeType;
  String? selectedPlanType;
  int? selectedMothCount;

  CreatePledgeResponse? _createPledgeResponse;
  CreatePledgeResponse? get createPledgeResponse => _createPledgeResponse;
  //data
  List<PledgeScheduleItem> get summaryData =>
      _createPledgeResponse?.schedule?.items ?? [];
  double get amountPerInstallment =>
      double.tryParse(
        _createPledgeResponse?.schedule?.amountPerInstallment ?? "0",
      ) ??
      0;

  //creates pledge
  Future<void> createPledge({
    required double amount,
    bool? isAnonymous,
    String? installmentCount,
    String? interval,
  }) async {
    setPledgeState(ViewState.busy);

    final details = {
      "campaign_uuid": _designatedCampaign?.campaignId,
      "committed_amount": amount,
      "currency": _selectedCurrency,
      "payment_plan_type": selectedPledgeType,
      "is_anonymous": isAnonymous,
      // "donor_type":"icoba_alumni",
      "metadata": {"source": "portal"},
    };

    if (selectedPledgeType == 'monthly') {
      //Monthly
      details["installment_count"] = selectedMothCount;
    }

    if (selectedPledgeType == 'custom') {
      //Custom
      details["installment_count"] = installmentCount;
      details["schedule"] = {
        "frequency": selectedPlanType, //daily, weekly, monthly
        "interval": interval,
      };
    }

    details.removeWhere((key, value) => value == null);

    await _dataProvider
        .createPledge(details: details)
        .then((response) async {
          _message = response.message ?? defaultSuccessMessage;
          _createPledgeResponse = response.data;
          setPledgeState(ViewState.retrieved);
        })
        .catchError((e) {
          _message = Utilities.formatMessage(e.toString(), isSuccess: false);
          setPledgeState(ViewState.error);
        });
  }

  //creates pledge
  Future<void> downloadReceipt({String? receiptNumber}) async {
    setState(ViewState.busy);

    await _dataProvider
        .makeBytesRequest(
          requestUrl: ApiRoutes.downloadReceipt(receiptNumber ?? ""),
        )
        .then((response) async {
          _message = defaultSuccessMessage;
          // Save to temp directory
          final dir = await getTemporaryDirectory();
          final filePath = '${dir.path}/${receiptNumber}_Receipt.pdf';
          final file = File(filePath);
          await file.writeAsBytes(response);

          setState(ViewState.retrieved);
          await OpenFilex.open(filePath);
        })
        .catchError((e) {
          _message = Utilities.formatMessage(e.toString(), isSuccess: false);
          setState(ViewState.error);
        });
  }

  int page = 1;
  int total = 0;

  List<PledgeData> _pledges = [];
  List<PledgeData> get pledges => _pledges;

  getPledges({bool firstCall = true}) async {
    if (firstCall) {
      page = 1;
      setDashboardState(ViewState.busy);
    } else {
      setPaginatedState(ViewState.busy);
    }

    // details.removeWhere((key, value) => value == null);

    await _dataProvider
        .getPledges(page: page)
        .then((response) async {
          _message = response.message ?? defaultSuccessMessage;
          if (firstCall) {
            _pledges = response.data?.data ?? [];
            page++;
            total = response.data?.total ?? 0;
            setDashboardState(ViewState.retrieved);
          } else {
            _pledges.addAll(response.data?.data ?? []);
            page++;
            setPaginatedState(ViewState.retrieved);
          }
        })
        .catchError((e) {
          _message = Utilities.formatMessage(e.toString(), isSuccess: false);
          if (firstCall) {
            setDashboardState(ViewState.error);
          } else {
            setPaginatedState(ViewState.error);
          }
        });
  }
}

final donationViewModel = ChangeNotifierProvider<DonationVm>((ref) {
  return DonationVm();
});
