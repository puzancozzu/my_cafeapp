// import 'package:google_fonts/google_fonts.dart';
// import 'package:flutter/material.dart';
//
//
//
//
// class FilterScreenPopup {
//   void _showAdvancedFilterDialog() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return StatefulBuilder(
//           builder: (context, setDialogState) {
//             return AlertDialog(
//               title: Text(
//                 'Advanced Filters',
//                 style: GoogleFonts.poppins(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               content: SingleChildScrollView(
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     // Name filter
//                     Text('Filter by Name:', style: GoogleFonts.poppins(
//                         fontSize: 14, fontWeight: FontWeight.w500)),
//                     SizedBox(height: 8),
//                     TextField(
//                       controller: _nameController,
//                       decoration: InputDecoration(
//                         hintText: 'Enter name...',
//                         hintStyle: GoogleFonts.poppins(fontSize: 12),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         contentPadding: EdgeInsets.symmetric(
//                             horizontal: 12, vertical: 8),
//                       ),
//                       style: GoogleFonts.poppins(fontSize: 12),
//                     ),
//                     SizedBox(height: 16),
//
//                     // Payment method filter
//                     Text('Payment Method:', style: GoogleFonts.poppins(
//                         fontSize: 14, fontWeight: FontWeight.w500)),
//                     SizedBox(height: 8),
//                     DropdownButtonFormField<String>(
//                       value: _selectedPaymentMethod,
//                       decoration: InputDecoration(
//                         hintText: 'Select payment method',
//                         hintStyle: GoogleFonts.poppins(fontSize: 12),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         contentPadding: EdgeInsets.symmetric(
//                             horizontal: 12, vertical: 8),
//                       ),
//                       items: [
//                         DropdownMenuItem<String>(
//                           value: null,
//                           child: Text('All Methods',
//                               style: GoogleFonts.poppins(fontSize: 12)),
//                         ),
//                         ..._paymentMethods.map((method) =>
//                             DropdownMenuItem<String>(
//                               value: method,
//                               child: Text(method,
//                                   style: GoogleFonts.poppins(fontSize: 12)),
//                             )).toList(),
//                       ],
//                       onChanged: (value) {
//                         setDialogState(() {
//                           _selectedPaymentMethod = value;
//                         });
//                       },
//                     ),
//                     SizedBox(height: 16),
//
//                     // Date range filter
//                     Text('Date Range:', style: GoogleFonts.poppins(
//                         fontSize: 14, fontWeight: FontWeight.w500)),
//                     SizedBox(height: 8),
//                     Row(
//                       children: [
//                         Expanded(
//                           child: InkWell(
//                             onTap: () async {
//                               final date = await showDatePicker(
//                                 context: context,
//                                 initialDate: _startDate ??
//                                     DateTime.now().subtract(Duration(days: 30)),
//                                 firstDate: DateTime.now().subtract(
//                                     Duration(days: 365)),
//                                 lastDate: DateTime.now(),
//                               );
//                               if (date != null) {
//                                 setDialogState(() {
//                                   _startDate = date;
//                                 });
//                               }
//                             },
//                             child: Container(
//                               padding: EdgeInsets.symmetric(
//                                   horizontal: 12, vertical: 12),
//                               decoration: BoxDecoration(
//                                 border: Border.all(color: Colors.grey.shade400),
//                                 borderRadius: BorderRadius.circular(8),
//                               ),
//                               child: Text(
//                                 _startDate != null
//                                     ? '${_startDate!.day}/${_startDate!
//                                     .month}/${_startDate!.year}'
//                                     : 'Start Date',
//                                 style: GoogleFonts.poppins(
//                                   fontSize: 12,
//                                   color: _startDate != null
//                                       ? Colors.black
//                                       : Colors.grey,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                         SizedBox(width: 8),
//                         Text(' - ', style: GoogleFonts.poppins()),
//                         SizedBox(width: 8),
//                         Expanded(
//                           child: InkWell(
//                             onTap: () async {
//                               final date = await showDatePicker(
//                                 context: context,
//                                 initialDate: _endDate ?? DateTime.now(),
//                                 firstDate: _startDate ??
//                                     DateTime.now().subtract(
//                                         Duration(days: 365)),
//                                 lastDate: DateTime.now(),
//                               );
//                               if (date != null) {
//                                 setDialogState(() {
//                                   _endDate = date;
//                                 });
//                               }
//                             },
//                             child: Container(
//                               padding: EdgeInsets.symmetric(
//                                   horizontal: 12, vertical: 12),
//                               decoration: BoxDecoration(
//                                 border: Border.all(color: Colors.grey.shade400),
//                                 borderRadius: BorderRadius.circular(8),
//                               ),
//                               child: Text(
//                                 _endDate != null
//                                     ? '${_endDate!.day}/${_endDate!
//                                     .month}/${_endDate!.year}'
//                                     : 'End Date',
//                                 style: GoogleFonts.poppins(
//                                   fontSize: 12,
//                                   color: _endDate != null
//                                       ? Colors.black
//                                       : Colors.grey,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//               actions: [
//                 TextButton(
//                   onPressed: () {
//                     setState(() {
//                       _nameController.clear();
//                       _selectedPaymentMethod = null;
//                       _startDate = null;
//                       _endDate = null;
//                       _applyFilter();
//                     });
//                     Navigator.of(context).pop();
//                   },
//                   child: Text(
//                       'Clear', style: GoogleFonts.poppins(color: Colors.grey)),
//                 ),
//                 TextButton(
//                   onPressed: () {
//                     _applyFilter();
//                     Navigator.of(context).pop();
//                   },
//                   child: Text(
//                     'Apply',
//                     style: GoogleFonts.poppins(
//                       color: Color(0xFF199926),
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ],
//             );
//           },
//         );
//       },
//     );
//   }
// }