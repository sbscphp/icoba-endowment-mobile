import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icoba_endowment_mobile/core/data/models/country.dart';
import 'package:icoba_endowment_mobile/core/data/view_models/auth/auth_vm.dart';

import '../../../core/constants/color_path.dart';
import '../../../core/utilities/extensions/color_extensions.dart';
import '../../../core/utilities/navigator.dart';
import '../custom_button.dart';
import 'bottom_sheet_header.dart';

class CountryCodeBottomSheet extends ConsumerStatefulWidget {
  final ValueChanged<String>? onOptionSelected;
  final Country? selectedOption;

  const CountryCodeBottomSheet({
    super.key,
    this.onOptionSelected,
    this.selectedOption,
  });

  @override
  ConsumerState<CountryCodeBottomSheet> createState() =>
      _CountryCodeBottomSheetState();
}

class _CountryCodeBottomSheetState
    extends ConsumerState<CountryCodeBottomSheet> {
  Country? _selectedCountry;
  List<Country> _filteredCountries = [];

  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.selectedOption != null) {
      _selectedCountry = widget.selectedOption;
      setState(() {});
    }
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    final query = _searchController.text.toLowerCase().trim();
    final vm = ref.read(authViewModel);
    setState(() {
      _filteredCountries = query.isEmpty
          ? vm.countries
          : vm.countries.where((country) {
              return (country.name?.toLowerCase().contains(query) ?? false) ||
                  (country.dialCode?.toLowerCase().contains(query) ?? false) ||
                  (country.iso2?.toLowerCase().contains(query) ?? false);
            }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final vm = ref.watch(authViewModel);

    // Initialize filtered list on first build
    if (_filteredCountries.isEmpty && _searchController.text.isEmpty) {
      _filteredCountries = vm.countries;
    }

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BottomSheetHeader(headerTitle: "Select country code"),
          SizedBox(height: 15.h),

          // Search field
          TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: "Search by name or code...",
              hintStyle: textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurface.withCustomOpacity(0.4),
              ),
              prefixIcon: Icon(
                Icons.search,
                size: 20.r,
                color: colorScheme.onSurface.withCustomOpacity(0.4),
              ),
              suffixIcon: _searchController.text.isNotEmpty
                  ? GestureDetector(
                      onTap: () {
                        _searchController.clear();
                        setState(() {
                          _filteredCountries = vm.countries;
                        });
                      },
                      child: Icon(
                        Icons.close,
                        size: 18.r,
                        color: colorScheme.onSurface.withCustomOpacity(0.4),
                      ),
                    )
                  : null,
              filled: true,
              fillColor: colorScheme.outline.withCustomOpacity(0.06),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 12.h,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          SizedBox(height: 12.h),

          // Options list
          Flexible(
            child: _filteredCountries.isEmpty
                ? Padding(
                    padding: EdgeInsets.symmetric(vertical: 24.h),
                    child: Center(
                      child: Text(
                        "No results found",
                        style: textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onSurface.withCustomOpacity(0.4),
                        ),
                      ),
                    ),
                  )
                : ListView.separated(
                    shrinkWrap: true,
                    itemCount: _filteredCountries.length,
                    separatorBuilder: (_, __) => Divider(
                      color: colorScheme.outline.withCustomOpacity(0.1),
                    ),
                    itemBuilder: (context, index) {
                      final option = _filteredCountries[index];
                      final isSelected = _selectedCountry == option;

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedCountry = option;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 14.h,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? ColorPath.athensGrey8
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    Text(
                                      option.flagEmoji ?? "",
                                      style: textTheme.bodyMedium?.copyWith(
                                        fontWeight: isSelected
                                            ? FontWeight.w600
                                            : FontWeight.normal,
                                        color: isSelected
                                            ? ColorPath.brandColor
                                            : colorScheme.onSurface,
                                      ),
                                    ),
                                    SizedBox(width: 4.w),
                                    Flexible(
                                      child: Text(
                                        " ${option.name} (${option.dialCode})",
                                        overflow: TextOverflow.ellipsis,
                                        style: textTheme.bodyMedium?.copyWith(
                                          fontWeight: isSelected
                                              ? FontWeight.w600
                                              : FontWeight.normal,
                                          color: isSelected
                                              ? ColorPath.brandColor
                                              : colorScheme.onSurface,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              if (isSelected)
                                Icon(
                                  Icons.check_circle_rounded,
                                  color: ColorPath.brandColor,
                                  size: 20.r,
                                ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),

          SizedBox(height: 20.h),
          CustomButton(
            onPressed: _selectedCountry == null
                ? null
                : () {
                    vm.selectedCountry = _selectedCountry;
                    widget.onOptionSelected?.call(
                      _selectedCountry?.iso2 ?? "N/A",
                    );
                    popNavigation(context: context);
                  },
            buttonText: "Confirm",
          ),
        ],
      ),
    );
  }
}
