import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icoba_endowment_mobile/core/constants/app_constants.dart';
import 'package:icoba_endowment_mobile/core/data/data_providers/dashboard_data_provider.dart';
import 'package:icoba_endowment_mobile/core/data/enum/view_state.dart';
import 'package:icoba_endowment_mobile/core/data/models/response_data/event_model.dart';
import 'package:icoba_endowment_mobile/core/data/states/dashboard_state.dart';
import 'package:icoba_endowment_mobile/core/utilities/utilities.dart';
import 'package:icoba_endowment_mobile/locator.dart';

class EventsVm extends DashboardState {
  final DashboardDataProvider _dataProvider = locator<DashboardDataProvider>();

  //message
  String _message = '';
  String get message => _message;

  List<EventModel> _events = [];
  List<EventModel> get events => _events;

  Future<void> getEvents() async {
    setState(ViewState.busy);

    // details.removeWhere((key, value) => value == null);

    await _dataProvider
        .getEvents()
        .then((response) async {
          _message = response.message ?? defaultSuccessMessage;
          _events = response.data?.data ?? [];
          setState(ViewState.retrieved);
        })
        .catchError((e) {
          _message = Utilities.formatMessage(e.toString(), isSuccess: false);
          setState(ViewState.error);
        });
  }

  EventModel? _eventData;
  //getters
  String? get bannerImage => _eventData?.bannerUrl;
  String? get eventBody => _eventData?.longDescription;
  String? get eventDate => _eventData?.eventDate;
  String? get eventTitle => _eventData?.title;
  List<ImageData> get images => _eventData?.images ?? [];

  Future<void> getEvent({required String eventId}) async {
    setSecondState(ViewState.busy);

    // details.removeWhere((key, value) => value == null);

    await _dataProvider
        .getSingleEvent(eventID: eventId)
        .then((response) async {
          _message = response.message ?? defaultSuccessMessage;
          _eventData = response.data;
          setSecondState(ViewState.retrieved);
        })
        .catchError((e) {
          _message = Utilities.formatMessage(e.toString(), isSuccess: false);
          setSecondState(ViewState.error);
        });
  }
}

final eventsViewModel = ChangeNotifierProvider<EventsVm>((ref) {
  return EventsVm();
});
