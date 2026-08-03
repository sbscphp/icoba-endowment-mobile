
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/color_path.dart';
import '../../../core/utilities/extensions/color_extensions.dart';
import '../../../core/utilities/navigator.dart';
import '../custom_button.dart';
import 'bottom_sheet_header.dart';

class SelectOptionBottomSheet extends StatefulWidget {
  final String? bottomSheetTitle;
  final List<String> options;
  final ValueChanged<String>? onOptionSelected;
  final String? selectedOption;

  const SelectOptionBottomSheet({
    super.key,
    this.bottomSheetTitle,
    required this.options,
    this.onOptionSelected,
    this.selectedOption,
  });

  @override
  State<SelectOptionBottomSheet> createState() =>
      _SelectOptionBottomSheetState();
}

class _SelectOptionBottomSheetState extends State<SelectOptionBottomSheet> {
  String? _selectedOption;
  final TextEditingController _searchController = TextEditingController();
  List<String> _filteredOptions = [];

  bool get _showSearch => widget.options.length > 10;

  @override
  void initState() {
    super.initState();
    _filteredOptions = widget.options;
    _searchController.addListener(_onSearchChanged);
    if (widget.selectedOption != null &&
        widget.options.contains(widget.selectedOption)) {
      _selectedOption = widget.selectedOption;
      setState(() {});
    }
  }

  void _onSearchChanged() {
    final query = _searchController.text.toLowerCase().trim();
    setState(() {
      _filteredOptions = query.isEmpty
          ? widget.options
          : widget.options
                .where((option) => option.toLowerCase().contains(query))
                .toList();
    });
  }

  @override
  void dispose() {
    _searchController
      ..removeListener(_onSearchChanged)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BottomSheetHeader(headerTitle: widget.bottomSheetTitle ?? ""),
          SizedBox(height: 15.h),

          // Search field — only shown when options > 10
          if (_showSearch) ...[
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: "Search...",
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
                        onTap: () => _searchController.clear(),
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
          ],

          // Options list
          Flexible(
            child: _filteredOptions.isEmpty
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
                    itemCount: _filteredOptions.length,
                    separatorBuilder: (_, __) => Divider(
                      color: colorScheme.outline.withCustomOpacity(0.1),
                    ),
                    itemBuilder: (context, index) {
                      final option = _filteredOptions[index];
                      final isSelected = _selectedOption == option;

                      return GestureDetector(
                        onTap: () {
                          setState(() => _selectedOption = option);
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
                                child: Text(
                                  option,
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
            onPressed: _selectedOption == null
                ? null
                : () {
                    widget.onOptionSelected?.call(_selectedOption!);
                    popNavigation(context: context);
                  },
            buttonText: "Confirm",
          ),
        ],
      ),
    );
  }
}
