import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../src/models/sales_order.dart';
import '../src/uiHelper/floating_action_button.dart';
import '../src/uiHelper/reuseable_title.dart';
import 'package:google_fonts/google_fonts.dart';


class SalesOrderPageUi extends StatefulWidget {
  const SalesOrderPageUi({super.key});
  @override
  State<SalesOrderPageUi> createState() => _SalesOrderPageUiState();
}

class _SalesOrderPageUiState extends State<SalesOrderPageUi> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  /// ============== filter actions ============================================
  String _currentFilter = 'Today';
  List<Map<String, dynamic>> _allData = [];
  List<Map<String, dynamic>> _filteredData = [];

  /// ------------ filter controllers for later --------------------------------
  TextEditingController _nameController = TextEditingController();
  String? _selectedPaymentMethod;
  DateTime? _startDate;
  DateTime? _endDate;

  List<String> _paymentMethods = [
    'Card',
    'Cash',
    'Online',
    'Cheque'
  ];


  /// ------------------- the function to get data ---------------------------
  void _generateRandomData() {
    final names = ['John Doe', 'Jane Smith', 'Bob Johnson', 'Alice Brown', 'Charlie Wilson', 'Diana Davis', 'Eva Martinez', 'Frank Taylor'];
    final summaries = ['Purchase order', 'Service payment', 'Subscription fee', 'Product sale', 'Consultation', 'Maintenance'];
    final paymentMethods = ['Credit Card', 'PayPal', 'Bank Transfer', 'Cash', 'Debit Card'];

    _allData.clear();
    final now = DateTime.now();

    for (int i = 1; i <= 50; i++) {
      final daysAgo = (i * 1.2).floor();
      final date = now.subtract(Duration(days: daysAgo));

      _allData.add({
        'id': i,
        'name': names[i % names.length],
        'summary': summaries[i % summaries.length],
        'date': date,
        'total': (100 + (i * 150.5)).toInt(),
        'item_count': (i % 10) + 1,
        'payment_method': paymentMethods[i % paymentMethods.length],
        'status': i % 3 == 0 ? 'Paid' : 'Unpaid',
      });
    }
    _allData.sort((a, b) => b['date'].compareTo(a['date']));
  }

  /// ================== apply filter - trigger fuction ========================
  void _applyFilter() {
    setState(() {
      _filteredData = _getFilteredData();
    });
  }


  /// ============= get filtered data ==========================================
  List<Map<String, dynamic>> _getFilteredData() {
    List<Map<String, dynamic>> filtered = List.from(_allData);

    filtered = _applyQuickDateFilter(filtered);

    filtered = _applyAdvancedFilters(filtered);

    return filtered;
  }


  /// ================ default quick filters ===================================
  List<Map<String, dynamic>> _applyQuickDateFilter(List<Map<String, dynamic>> data) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    switch (_currentFilter) {
      case 'Today':
        final tomorrow = today.add(Duration(days: 1));
        return data.where((item) {
          final itemDate = item['date'] as DateTime;
          return itemDate.isAfter(today.subtract(Duration(seconds: 1))) &&
              itemDate.isBefore(tomorrow);
        }).toList();

      case 'Yesterday':
        final yesterday = today.subtract(Duration(days: 1));
        return data.where((item) {
          final itemDate = item['date'] as DateTime;
          return itemDate.isAfter(yesterday.subtract(Duration(seconds: 1))) &&
              itemDate.isBefore(today);
        }).toList();

      case '7 Days':
        final sevenDaysAgo = today.subtract(Duration(days: 7));
        return data.where((item) {
          final itemDate = item['date'] as DateTime;
          return itemDate.isAfter(sevenDaysAgo.subtract(Duration(seconds: 1)));
        }).toList();

      case '30 Days':
        final thirtyDaysAgo = today.subtract(Duration(days: 30));
        return data.where((item) {
          final itemDate = item['date'] as DateTime;
          return itemDate.isAfter(thirtyDaysAgo.subtract(Duration(seconds: 1)));
        }).toList();

      default:
        return data;
    }
  }


  /// ============ filter- Advance one =========================================
  List<Map<String, dynamic>> _applyAdvancedFilters(List<Map<String, dynamic>> data) {
    List<Map<String, dynamic>> filtered = data;

    // Filter by name
    if (_nameController.text.isNotEmpty) {
      filtered = filtered.where((item) {
        return item['name'].toString().toLowerCase()
            .contains(_nameController.text.toLowerCase());
      }).toList();
    }

    // Filter by payment method
    if (_selectedPaymentMethod != null && _selectedPaymentMethod!.isNotEmpty) {
      filtered = filtered.where((item) {
        return item['payment_method'] == _selectedPaymentMethod;
      }).toList();
    }

    // Filter by date range
    if (_startDate != null && _endDate != null) {
      filtered = filtered.where((item) {
        final itemDate = item['date'] as DateTime;
        final endOfDay = DateTime(_endDate!.year, _endDate!.month, _endDate!.day, 23, 59, 59);
        return itemDate.isAfter(_startDate!.subtract(Duration(seconds: 1))) &&
            itemDate.isBefore(endOfDay.add(Duration(seconds: 1)));
      }).toList();
    }

    return filtered;
  }

  @override
  void initState() {
    super.initState();
    _generateRandomData();
    _applyFilter();
  }






/// ======================= UI Building=========================================
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
  /// ================ Floating action button ==================================
        floatingActionButton: FloatingActionButtonUI(
            onPressed: () async{
              print('FloatingActionButton pressed Sales...');
              // Navigator.pushReplacement(
              //   context,
              //   MaterialPageRoute(builder: (context) => PurchaseOrderPageUI()),
              // );
            }),
        backgroundColor: const Color.fromRGBO(246, 246, 248, 1),
  /// ============== UI Page ===================================================
        body: SafeArea(
            top: true,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment:CrossAxisAlignment.center,
                children: [

            /// ------------- App Bar ------------------------------------------
                  // const SizedBox(height: 6,),
                  Container(
                    width: MediaQuery.sizeOf(context).width * 1,
                    height: 100,
                    decoration: const BoxDecoration(
                      // color: Color.fromRGBO(25, 153, 38, 1),
                      // borderRadius: BorderRadius.all(Radius.circular(14))
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color.fromARGB(255, 9, 89, 9),
                          Color.fromARGB(255, 92, 163, 92),
                          Color.fromRGBO(244, 250, 244, 1)
                        ],
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        ReusableListTitleUi(
                            title:'Orders',
                            icon:Icons.currency_exchange
                        )

                      ],
                    ),
                  ),

            /// ---------------- filter row ------------------------------------
                  const SizedBox(height: 6,),
                  Container(
                    width: MediaQuery.sizeOf(context).width * 0.96,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Wrap(
                            spacing: 8,
                            children: ['Today', 'Yesterday', '7 Days', '30 Days'].map((label) {
                              final bool isSelected = _currentFilter == label;
                              return FilterChip(
                                label: Text(
                                  label,
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: isSelected ? Colors.white : Colors.black87,
                                  ),
                                ),
                                selected: isSelected,
                                onSelected: (val) {
                                  setState(() {
                                    _currentFilter = label;
                                    _applyFilter();
                                  });
                                },
                                selectedColor: const Color(0xFF199926),
                                backgroundColor: Colors.transparent,
                                showCheckmark: false,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: BorderSide(
                                    color: isSelected
                                        ? const Color(0xFF199926)
                                        : Colors.grey.shade400,
                                    width: 1,
                                  ),
                                ),
                                elevation: 2,
                              );
                            }).toList(),
                          ),
                        ),
                        IconButton(
                          onPressed: _showAdvancedFilterDialog,
                          icon: Icon(
                            Icons.filter_list_alt,
                            color: Colors.grey[700],
                            size: 26,
                          ),
                        )
                      ],
                    ),
                  ),

            /// ------------------ Filter options:  ----------------------------
                  const SizedBox(height: 4,),
                  // Active Advanced Filters Display
                  if (_hasActiveAdvancedFilters())
                    Container(
                      width: MediaQuery.sizeOf(context).width * 0.96,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Wrap(
                            spacing: 4,
                            runSpacing: 4,
                            children: _buildActiveFilterChips(),
                          ),
                        ],
                      ),
                    ),

            /// ------ List Builder to show data -------------------------------
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: _refreshData,
                      color: Color(0xFF199926),
                      child: SingleChildScrollView(
                        physics: AlwaysScrollableScrollPhysics(),
                        child: Column(
                          children: [
                            ListView.builder(
                              padding: const EdgeInsets.all(16),
                              itemCount: _filteredData.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                final item = _filteredData[index];
                                return Card(
                                  margin: const EdgeInsets.only(bottom: 12),
                                  elevation: 2,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(16),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [

                                      /// -------- Name ------------------------
                                            Expanded(
                                              child: Text(
                                                item['name'],
                                                style: GoogleFonts.poppins(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),

                                      /// -------- Payment Status --------------
                                            Container(
                                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                                              decoration: BoxDecoration(
                                                color: item['status'] == 'Paid'
                                                    ? Colors.green.shade100
                                                    : Colors.orange.shade100,
                                                borderRadius: BorderRadius.circular(12),
                                              ),
                                              child: Text(
                                                item['status'],
                                                style: GoogleFonts.poppins(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                  color: item['status'] == 'Paid'
                                                      ? Colors.green.shade700
                                                      : Colors.orange.shade700,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          item['summary'],
                                          style: GoogleFonts.poppins(
                                            fontSize: 12,
                                            color: Colors.grey[600],
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Total: ${item['total']}',
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600,
                                                    color: const Color(0xFF199926),
                                                  ),
                                                ),
                                                Text(
                                                  'Items: ${item['item_count']}',
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 12,
                                                    color: Colors.grey[600],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              children: [
                                                Text(
                                                  item['payment_method'],
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                Text(
                                                  '${item['date'].day}/${item['date'].month}/${item['date'].year}',
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 12,
                                                    color: Colors.grey[600],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),


                      // -----Add some bottom padding if list is short----------
                            if (_filteredData.isEmpty)
                              Container(
                                height: 200,
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.search_off,
                                        size: 48,
                                        color: Colors.grey[400],
                                      ),
                                      SizedBox(height: 16),
                                      Text(
                                        'No data found',
                                        style: GoogleFonts.poppins(
                                          fontSize: 16,
                                          color: Colors.grey[600],
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        'Try adjusting your filters',
                                        style: GoogleFonts.poppins(
                                          fontSize: 12,
                                          color: Colors.grey[500],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),

                ],
              ),
            )

        ),
      ),
    );
  }



  /// ========================= Advance filter Pop up  =========================
  void _showAdvancedFilterDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: Text(
                'Advanced Filters',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Name filter
                    Text('Filter by Name:', style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500)),
                    SizedBox(height: 8),
                    TextField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        hintText: 'Enter name...',
                        hintStyle: GoogleFonts.poppins(fontSize: 12),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      ),
                      style: GoogleFonts.poppins(fontSize: 12),
                    ),
                    SizedBox(height: 16),

                    // Payment method filter
                    Text('Payment Method:', style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500)),
                    SizedBox(height: 8),
                    DropdownButtonFormField<String>(
                      value: _selectedPaymentMethod,
                      decoration: InputDecoration(
                        hintText: 'Select payment method',
                        hintStyle: GoogleFonts.poppins(fontSize: 12),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      ),
                      items: [
                        DropdownMenuItem<String>(
                          value: null,
                          child: Text('All Methods', style: GoogleFonts.poppins(fontSize: 12)),
                        ),
                        ..._paymentMethods.map((method) => DropdownMenuItem<String>(
                          value: method,
                          child: Text(method, style: GoogleFonts.poppins(fontSize: 12)),
                        )).toList(),
                      ],
                      onChanged: (value) {
                        setDialogState(() {
                          _selectedPaymentMethod = value;
                        });
                      },
                    ),
                    SizedBox(height: 16),

                    // Date range filter
                    Text('Date Range:', style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500)),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () async {
                              final date = await showDatePicker(
                                context: context,
                                initialDate: _startDate ?? DateTime.now().subtract(Duration(days: 30)),
                                firstDate: DateTime.now().subtract(Duration(days: 365)),
                                lastDate: DateTime.now(),
                              );
                              if (date != null) {
                                setDialogState(() {
                                  _startDate = date;
                                });
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade400),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                _startDate != null
                                    ? '${_startDate!.day}/${_startDate!.month}/${_startDate!.year}'
                                    : 'Start Date',
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: _startDate != null ? Colors.black : Colors.grey,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 8),
                        Text(' - ', style: GoogleFonts.poppins()),
                        SizedBox(width: 8),
                        Expanded(
                          child: InkWell(
                            onTap: () async {
                              final date = await showDatePicker(
                                context: context,
                                initialDate: _endDate ?? DateTime.now(),
                                firstDate: _startDate ?? DateTime.now().subtract(Duration(days: 365)),
                                lastDate: DateTime.now(),
                              );
                              if (date != null) {
                                setDialogState(() {
                                  _endDate = date;
                                });
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade400),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                _endDate != null
                                    ? '${_endDate!.day}/${_endDate!.month}/${_endDate!.year}'
                                    : 'End Date',
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: _endDate != null ? Colors.black : Colors.grey,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      _nameController.clear();
                      _selectedPaymentMethod = null;
                      _startDate = null;
                      _endDate = null;
                      _applyFilter();
                    });
                    Navigator.of(context).pop();
                  },
                  child: Text('Clear', style: GoogleFonts.poppins(color: Colors.grey)),
                ),
                TextButton(
                  onPressed: () {
                    _applyFilter();
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Apply',
                    style: GoogleFonts.poppins(
                      color: Color(0xFF199926),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }


  bool _hasActiveAdvancedFilters() {
    return _nameController.text.isNotEmpty ||
        (_selectedPaymentMethod != null && _selectedPaymentMethod!.isNotEmpty) ||
        (_startDate != null && _endDate != null);
  }

  List<Widget> _buildActiveFilterChips() {
    List<Widget> chips = [];

    chips.add(
      SizedBox(
        height: 36,
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Text(
            'Filters:',
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );

    // Name filter chip
    if (_nameController.text.isNotEmpty) {
      chips.add(
        SizedBox(
          height: 36,
          child: Chip(
            label: Text(
              '${_nameController.text}',
              style: GoogleFonts.poppins(fontSize: 14, color: Colors.white),
            ),
            backgroundColor: Color(0xFF199926),
            deleteIcon: Icon(Icons.close, size: 14, color: Colors.white),
            onDeleted: () {
              setState(() {
                _nameController.clear();
                _applyFilter();
              });
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),)
          ),
        ),
      );
    }

    // Payment method filter chip
    if (_selectedPaymentMethod != null && _selectedPaymentMethod!.isNotEmpty) {
      chips.add(
        SizedBox(
          height: 36,
          child: Chip(
            label: Text(
              '$_selectedPaymentMethod',
              style: GoogleFonts.poppins(fontSize: 12, color: Colors.white),
            ),
            backgroundColor: Color(0xFF199926),
            deleteIcon: Icon(Icons.close, size: 12, color: Colors.white),
            onDeleted: () {
              setState(() {
                _selectedPaymentMethod = null;
                _applyFilter();
              });
            },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),)
          ),
        ),
      );
    }

    // Date range filter chip
    if (_startDate != null && _endDate != null) {
      chips.add(
        SizedBox(
          height: 36,
          child: Chip(
            label: Text(
              '${_startDate!.day}/${_startDate!.month}/${_startDate!.year} - ${_endDate!.day}/${_endDate!.month}/${_endDate!.year}',
              style: GoogleFonts.poppins(fontSize: 12, color: Colors.white),
            ),
            backgroundColor: Color(0xFF199926),
            deleteIcon: Icon(Icons.close, size: 12, color: Colors.white),
            onDeleted: () {
              setState(() {
                _startDate = null;
                _endDate = null;
                _applyFilter();
              });
            },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),)
          ),
        ),
      );
    }

    // // // Clear all button
    // if (chips.isNotEmpty) {
    //   chips.add(
    //     SizedBox(
    //       height: 36,
    //       child: ActionChip(
    //         label: Text(
    //           'Clear All',
    //           style: GoogleFonts.poppins(fontSize: 12, color: Colors.red),
    //         ),
    //         backgroundColor: Colors.red.shade50,
    //         side: BorderSide(color: Colors.red.shade200),
    //         onPressed: () {
    //           setState(() {
    //             _nameController.clear();
    //             _selectedPaymentMethod = null;
    //             _startDate = null;
    //             _endDate = null;
    //             _applyFilter();
    //           });
    //         },
    //           shape: RoundedRectangleBorder(
    //             borderRadius: BorderRadius.circular(8),)
    //       ),
    //     ),
    //   );
    // }

    return chips;
  }



  /// ------------- refreshing action -----------------------------------------
  Future<void> _refreshData() async {
    await Future.delayed(Duration(milliseconds: 1000));
    setState(() {
      _generateRandomData();
      _applyFilter();
    });
  }


  /// ===================== dispose method to end the scope of variables =======
  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }
}
