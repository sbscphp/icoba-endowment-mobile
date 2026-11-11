import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icoba_endowment_mobile/core/constants/app_theme/custom_color_scheme.dart';
import 'package:icoba_endowment_mobile/core/constants/color_path.dart';
import 'package:icoba_endowment_mobile/core/constants/named_routes.dart';
import 'package:icoba_endowment_mobile/core/data/enum/view_state.dart';
import 'package:icoba_endowment_mobile/core/data/view_models/dashboard/events_vm.dart';
import 'package:icoba_endowment_mobile/core/utilities/extensions/color_extensions.dart';
import 'package:icoba_endowment_mobile/core/utilities/navigator.dart';
import 'package:icoba_endowment_mobile/ui/widgets/app_loader.dart';
import 'package:icoba_endowment_mobile/ui/widgets/clickable.dart';
import 'package:icoba_endowment_mobile/ui/widgets/error_state.dart';
import 'package:icoba_endowment_mobile/ui/widgets/home/view_event.dart';
import 'package:icoba_endowment_mobile/ui/widgets/icoba_container.dart';

class Events extends ConsumerStatefulWidget {
  const Events({super.key});

  @override
  ConsumerState<Events> createState() => _EventsState();
}

class _EventsState extends ConsumerState<Events> {
  final SwiperController swiperController = SwiperController();
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final eventsVm = ref.watch(eventsViewModel);
    return eventsVm.events.isEmpty
        ? SizedBox.shrink()
        : IcobaContainer(
            padding: EdgeInsets.all(16.w),
            margin: EdgeInsets.only(top: 16.h),
            bgColor: colorScheme.whiteText,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Events",
                  style: textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 12.h),
                Builder(
                  builder: (context) {
                    if (eventsVm.state == ViewState.busy) {
                      return AppLoader();
                    }
                    if (eventsVm.state == ViewState.error) {
                      return ErrorState(
                        message: eventsVm.message,
                        onPressed: () {
                          // dashboardVm.getEvents();
                        },
                      );
                    }

                    return SizedBox(
                      height: 250.h,
                      child: Column(
                        children: [
                          Expanded(
                            child: Swiper(
                              controller: swiperController,
                              itemCount: eventsVm.events.length,
                              duration: 1000,
                              autoplay: eventsVm.events.length > 2,
                              autoplayDelay: 5000,
                              allowImplicitScrolling: false,
                              // curve: Curves.easeInOut,
                              itemWidth:
                                  (MediaQuery.of(context).size.width * 0.9)
                                      .roundToDouble(),
                              itemHeight: 220,
                              // itemWidth: double.infinity,
                              onIndexChanged: (index) {
                                currentPage = index;
                                setState(() {});
                              },

                              //  ListView.separated(
                              //   shrinkWrap: true,
                              //   scrollDirection: Axis.horizontal,
                              itemBuilder: (contex, index) {
                                final event = eventsVm.events[index];
                                return Clickable(
                                  onPressed: () {
                                    pushNavigation(
                                      context: context,
                                      widget: ViewEvent(eventID: event.eventId),
                                      routeName: NamedRoutes.viewEvent,
                                    );
                                  },
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child:
                                            _isValidUrl(event.bannerUrl ?? "")
                                            ? Stack(
                                                alignment:
                                                    Alignment.bottomRight,
                                                children: [
                                                  Container(
                                                    // height: 110.h,
                                                    width: double.infinity,
                                                    margin: EdgeInsets.only(
                                                      left: 6.w,
                                                      right: 6.w,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      color:
                                                          ColorPath.athensGrey8,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            12.r,
                                                          ),
                                                      image: DecorationImage(
                                                        image: NetworkImage(
                                                          event.bannerUrl ?? "",
                                                        ),
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                          horizontal: 8.w,
                                                          vertical: 2.h,
                                                        ),
                                                    margin: EdgeInsets.only(
                                                      right: 16.w,
                                                      bottom: 16.h,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      color:
                                                          isPast(
                                                            event.eventDate,
                                                          )
                                                          ? ColorPath
                                                                .alabastaWhite
                                                                .withCustomOpacity(
                                                                  .65,
                                                                )
                                                          : ColorPath
                                                                .lightPurple
                                                                .withCustomOpacity(
                                                                  .65,
                                                                ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            6.r,
                                                          ),
                                                    ),
                                                    child: Text(
                                                      isPast(event.eventDate)
                                                          ? "PAST"
                                                          : "UPCOMING",
                                                      style: textTheme.bodySmall
                                                          ?.copyWith(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                isPast(
                                                                  event
                                                                      .eventDate,
                                                                )
                                                                ? ColorPath
                                                                      .ebonyBlack
                                                                : ColorPath
                                                                      .toryBlue,
                                                          ),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            : Container(
                                                // height: 100.h,
                                                margin: EdgeInsets.only(
                                                  left: 6.w,
                                                  right: 6.w,
                                                ),
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                        12.r,
                                                      ),
                                                  color: ColorPath.athensGrey8,
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    "Image not available",
                                                  ),
                                                ),
                                              ),
                                      ),
                                      SizedBox(height: 4.h),
                                      Padding(
                                        padding: EdgeInsets.only(left: 6.0),
                                        child: Text(
                                          event.title ?? "",
                                          style: textTheme.bodySmall?.copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              // separatorBuilder: (context, index) =>
                              //     SizedBox(width: 12.w),
                              // itemCount: dashboardVm.events.length,
                            ),
                          ),
                          SizedBox(height: 12.h),
                          Padding(
                            padding: EdgeInsets.only(left: 6.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: List.generate(
                                eventsVm.events.length,
                                (index) => AnimatedContainer(
                                  duration: Duration(milliseconds: 200),
                                  height: 8.h,
                                  width: index == currentPage ? 16.w : 8.w,
                                  margin: EdgeInsets.symmetric(horizontal: 2.w),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.circular(12.r),
                                    color: index == currentPage
                                        ? ColorPath.brandColor
                                        : ColorPath.yonderBlue,
                                  ),
                                ),
                              ).toList(),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
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
