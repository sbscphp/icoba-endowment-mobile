import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart' show Html;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icoba_endowment_mobile/core/constants/color_path.dart';
import 'package:icoba_endowment_mobile/core/data/enum/view_state.dart';
import 'package:icoba_endowment_mobile/core/data/view_models/dashboard/events_vm.dart';
import 'package:icoba_endowment_mobile/core/utilities/date_utilitites.dart';
import 'package:icoba_endowment_mobile/core/utilities/extensions/color_extensions.dart';
import 'package:icoba_endowment_mobile/core/utilities/utilities.dart';
import 'package:icoba_endowment_mobile/ui/widgets/app_loader.dart';
import 'package:icoba_endowment_mobile/ui/widgets/custom_appbar.dart';
import 'package:icoba_endowment_mobile/ui/widgets/custom_scaffold.dart';
import 'package:icoba_endowment_mobile/ui/widgets/error_state.dart';

class ViewEvent extends ConsumerStatefulWidget {
  final String? eventID;
  const ViewEvent({super.key, this.eventID});

  @override
  ConsumerState<ViewEvent> createState() => _ViewEventState();
}

class _ViewEventState extends ConsumerState<ViewEvent> {
  final SwiperController swiperController = SwiperController();
  int currentPage = 0;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getEvent();
    });
    super.initState();
  }

  void _getEvent() async {
    await ref.read(eventsViewModel).getEvent(eventId: widget.eventID ?? "");
  }

  @override
  Widget build(BuildContext context) {
    // final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final eventsVm = ref.watch(eventsViewModel);

    return CustomScaffold(
      appBar: customAppBar(context: context, title: "Event", useChevLeft: true),
      body: Builder(
        builder: (context) {
          if (eventsVm.secondState == ViewState.busy) {
            return AppLoader();
          }
          if (eventsVm.secondState == ViewState.error) {
            return ErrorState(
              message: eventsVm.message,
              onPressed: () {
                eventsVm.getEvent(eventId: widget.eventID ?? "");
              },
            );
          }
          return SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.only(top: 24.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  eventsVm.eventTitle ?? "",
                  style: textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 12.h),
                if (eventsVm.bannerImage != null &&
                    eventsVm.bannerImage != "")
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      Container(
                        height: 300.h,
                        width: double.infinity,
                        margin: EdgeInsets.only(bottom: 12.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.r),
                          image: DecorationImage(
                            image: NetworkImage(eventsVm.bannerImage!),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                          vertical: 2.h,
                        ),
                        margin: EdgeInsets.only(right: 16.w, bottom: 16.h),
                        decoration: BoxDecoration(
                          color: isPast(eventsVm.eventDate)
                              ? ColorPath.alabastaWhite.withCustomOpacity(.65)
                              : ColorPath.lightPurple.withCustomOpacity(.65),
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                        child: Text(
                          isPast(eventsVm.eventDate) ? "PAST" : "UPCOMING",
                          style: textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: isPast(eventsVm.eventDate)
                                ? ColorPath.ebonyBlack
                                : ColorPath.toryBlue,
                          ),
                        ),
                      ),
                    ],
                  ),
                SizedBox(height: 6.h),
                Row(
                  children: [
                    Icon(
                      Icons.calendar_month_outlined,
                      color: ColorPath.gullGrey,
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      DateUtilities.dMY(
                        DateTime.tryParse(eventsVm.eventDate ?? "") ??
                            DateTime.now(),
                      ),
                      style: textTheme.bodySmall?.copyWith(
                        color: ColorPath.fiordGrey,
                      ),
                    ),
                  ],
                ),
                Divider(color: ColorPath.geyserGrey),
                Html(
                  data: eventsVm.eventBody,
                  onLinkTap: (url, attributes, element) {
                    Utilities.launchIt(url: url);
                  },
                ),
                SizedBox(height: 8.h),
                if (eventsVm.images.isNotEmpty)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Event Gallery",
                        style: textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      SizedBox(
                        height: 350.h,
                        child: Swiper(
                          controller: swiperController,
                          itemCount: eventsVm.images.length,
                          duration: 1000,
                          autoplay: true,
                          autoplayDelay: 5000,
                          // curve: Curves.easeInOut,
                          itemHeight: double.infinity,
                          itemWidth: double.infinity,
                          onIndexChanged: (index) {
                            currentPage = index;
                            setState(() {});
                          },

                          //  ListView.separated(
                          //   shrinkWrap: true,
                          //   scrollDirection: Axis.horizontal,
                          itemBuilder: (contex, index) {
                            final item = eventsVm.images[index];
                            return _isValidUrl(item.imageUrl ?? "")
                                ? Container(
                                    // height: 110.h,
                                    width: double.infinity,
                                    margin: EdgeInsets.only(
                                      left: 6.w,
                                      right: 6.w,
                                    ),
                                    decoration: BoxDecoration(
                                      color: ColorPath.ebonyBlack,
                                      borderRadius: BorderRadius.circular(12.r),
                                      image: DecorationImage(
                                        image: NetworkImage(
                                          item.imageUrl ?? "",
                                        ),
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  )
                                : Container(
                                    // height: 100.h,
                                    margin: EdgeInsets.only(
                                      left: 6.w,
                                      right: 6.w,
                                    ),
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12.r),
                                      color: ColorPath.athensGrey8,
                                    ),
                                    child: Center(
                                      child: Text("Image not available"),
                                    ),
                                  );
                          },
                          // separatorBuilder: (context, index) =>
                          //     SizedBox(width: 12.w),
                          // itemCount: dashboardVm.events.length,
                        ),
                      ),
                    ],
                  ),
                SizedBox(height: 55.h),
              ],
            ),
          );
        },
      ),
    );
  }

  bool _isValidUrl(String url) {
    final uri = Uri.tryParse(url);
    return uri != null &&
        (uri.isScheme("http") || uri.isScheme("https")) &&
        uri.host.isNotEmpty;
  }

  bool isPast(String? date) {
    final currentDate = DateTime.now();
    final eventDate = DateTime.tryParse(date ?? '');

    return currentDate.isAfter(eventDate ?? currentDate);
  }
}
