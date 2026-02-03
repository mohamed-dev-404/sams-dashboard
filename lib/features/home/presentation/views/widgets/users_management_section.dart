import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sams_dashboard/core/utils/colors/app_colors.dart';
import 'package:sams_dashboard/features/home/data/models/user_model.dart';
import 'package:sams_dashboard/features/home/data/user_mock_data.dart';
import 'package:sams_dashboard/features/home/presentation/views/widgets/table_pagination_bar.dart';
import 'package:sams_dashboard/features/home/presentation/views/widgets/users_filters_section.dart';
import 'package:sams_dashboard/features/home/presentation/views/widgets/users_table_section.dart';

//*) Users management main section (Filters + Table + Pagination)
class UsersManagementSection extends StatefulWidget {
  const UsersManagementSection({super.key});

  @override
  State<UsersManagementSection> createState() => _UsersManagementSectionState();
}

class _UsersManagementSectionState extends State<UsersManagementSection> {
  late final ValueNotifier<int> _currentPage; // Current active page notifier

  late final ValueNotifier<int> _rowsPerPage; // Rows per page notifier

  // Main data source (unfiltered users list)
  late final List<UserModel> _allUsers;

  @override
  void initState() {
    super.initState();

    // Initial pagination values
    _currentPage = ValueNotifier<int>(1);
    _rowsPerPage = ValueNotifier<int>(5);

    // Load mock users (acts as the single source of truth)
    _allUsers = getMockUsers();
  }

  @override
  void dispose() {
    // Dispose notifiers to avoid memory leaks
    _currentPage.dispose();
    _rowsPerPage.dispose();
    super.dispose();
  }

  //*) ------------------------------------------------------------------------
  //*) Pagination Logic
  //*) ------------------------------------------------------------------------

  //? Returns only the users for the current page
  List<UserModel> _getPaginatedUsers(int page, int rows) {
    //! Calculate starting index based on page number
    final int startIndex = (page - 1) * rows;

    //? Prevent out-of-range access
    if (startIndex >= _allUsers.length) return [];

    //! Slice the list based on pagination values
    return _allUsers.skip(startIndex).take(rows).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16.r),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //todo Filters section (will be connected to table later)
          const UsersFiltersSection(),

          //*) --------------------------------------------------------------
          //*) Table Section (listens to page & rows changes)
          //*) --------------------------------------------------------------
          Expanded(
            child: AnimatedBuilder(
              //? Rebuild table when page or rows-per-page changes
              animation: Listenable.merge([_currentPage, _rowsPerPage]),
              builder: (context, _) {
                final paginatedUsers = _getPaginatedUsers(
                  _currentPage.value,
                  _rowsPerPage.value,
                );

                return UsersTableSection(
                  users: paginatedUsers,
                );
              },
            ),
          ),

          const Divider(height: 1, color: AppColors.whiteHover),
          SizedBox(height: 24.h),

          //*) --------------------------------------------------------------
          //*) Pagination Bar Section
          //*) --------------------------------------------------------------
          AnimatedBuilder(
            //? Keep pagination bar in sync with table state
            animation: Listenable.merge([_currentPage, _rowsPerPage]),
            builder: (context, _) {
              return TablePaginationBar(
                totalItems: _allUsers.length,
                currentPage: _currentPage.value,
                rowsPerPage: _rowsPerPage.value,
                onRowsPerPageChanged: (newRows) {
                  //! Reset page when rows-per-page changes
                  _rowsPerPage.value = newRows;
                  _currentPage.value = 1;
                },
                onPageChanged: (newPage) {
                  _currentPage.value = newPage;
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
