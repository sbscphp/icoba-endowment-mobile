import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icoba_endowment_mobile/core/constants/app_asset.dart';
import 'package:icoba_endowment_mobile/core/constants/app_theme/custom_color_scheme.dart';
import 'package:icoba_endowment_mobile/core/constants/color_path.dart';
import 'package:icoba_endowment_mobile/core/data/enum/view_state.dart';
import 'package:icoba_endowment_mobile/core/data/view_models/dashboard/transactions_vm.dart';
import 'package:icoba_endowment_mobile/core/data/view_models/user/user_vm.dart';
import 'package:icoba_endowment_mobile/ui/widgets/app_loader.dart';
import 'package:icoba_endowment_mobile/ui/widgets/custom_appbar.dart';
import 'package:icoba_endowment_mobile/ui/widgets/custom_scaffold.dart';
import 'package:icoba_endowment_mobile/ui/widgets/donor.dart';
import 'package:icoba_endowment_mobile/ui/widgets/empty_state.dart';
import 'package:icoba_endowment_mobile/ui/widgets/error_state.dart';
import 'package:icoba_endowment_mobile/ui/widgets/icoba_container.dart';

class RecentDonations extends ConsumerStatefulWidget {
  const RecentDonations({super.key});

  @override
  ConsumerState<RecentDonations> createState() => _RecentDonationsState();
}

class _RecentDonationsState extends ConsumerState<RecentDonations> {
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // _fetchData();
      _scrollListener();
    });
    super.initState();
  }

  void _fetchData() {
    ref.read(transactionsViewModel).getTransactions();
  }

  void _scrollListener() {
    final vm = ref.watch(transactionsViewModel);
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        //check paginated state
        if (vm.paginatedState != ViewState.error) {
          //check if data is not being currently fetched and also check total records
          if (vm.paginatedState != ViewState.busy &&
              vm.transactions.length < vm.transactionTotal) {
            //fetch more
            vm.getTransactions(firstCall: false);
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final transactionsVm = ref.watch(transactionsViewModel);
    final userVm = ref.watch(userViewModel);

    return CustomScaffold(
      useHorizontalPadding: false,
      useSafeArea: false,
      appBar: customAppBar(
        context: context,
        title: "Recent Donations",
        useChevLeft: true,
      ),
      body: Container(
        color: ColorPath.athensGrey4,
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.only(left: 16.w, right: 16.w),
        child: Builder(
          builder: (context) {
            if (transactionsVm.state == ViewState.busy) {
              return AppLoader();
            }
            if (transactionsVm.state == ViewState.error) {
              return ErrorState(
                message: transactionsVm.message,
                onPressed: () {
                  _fetchData();
                },
              );
            }
            if (transactionsVm.transactions.isEmpty) {
              return IcobaContainer(
                margin: EdgeInsets.only(top: 24.h, bottom: 24.h),
                child: Center(
                  child: EmptyState(
                    asset: AppAsset.empty,
                    title: "You are yet to make a donation",
                  ),
                ),
              );
            }
            return IcobaContainer(
              padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 16.h),
              margin: EdgeInsets.only(top: 16.h),
              bgColor: colorScheme.whiteText,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16.h),
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: () async {
                        _fetchData();
                      },
                      child: ListView.separated(
                        shrinkWrap: true,
                        controller: scrollController,
                        physics: AlwaysScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final data = transactionsVm.transactions[index];
                          return Donor(
                            amount: double.tryParse(data.amount ?? "0"),
                            currencyCode: data.currency,
                            donorName: data.linkedCampaign?.name,
                            setNumber: userVm.setName,
                            showTagRow: false,
                          );
                        },
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 16.h),
                        itemCount: transactionsVm.transactions.length,
                      ),
                    ),
                  ),
                  if (transactionsVm.paginatedState == ViewState.busy)
                    Column(
                      children: [
                        SizedBox(height: 6.h),
                        LinearProgressIndicator(
                          backgroundColor: Colors.transparent,
                          color: ColorPath.brandColor,
                        ),
                        SizedBox(height: 6.h),
                      ],
                    ),
                  if (transactionsVm.paginatedState == ViewState.error)
                    ErrorState(
                      onPressed: () async {
                        transactionsVm.getTransactions(firstCall: false);
                      },
                      isPaginationType: true,
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
