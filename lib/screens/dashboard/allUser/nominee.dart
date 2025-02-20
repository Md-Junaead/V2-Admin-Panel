// nominee_screen.dart (View)
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'nominee_view_model.dart';

class NomineeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => NomineeViewModel()..fetchNominees(),
      child: Scaffold(
        appBar: AppBar(title: Text('Nominees')),
        body: Consumer<NomineeViewModel>(
          builder: (context, viewModel, child) {
            if (viewModel.isLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (viewModel.errorMessage.isNotEmpty) {
              return Center(child: Text(viewModel.errorMessage));
            } else if (viewModel.nominees.isEmpty) {
              return Center(child: Text('No nominees found'));
            }
            return Padding(
              padding: EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: [
                    DataColumn(label: Text('Name')),
                    DataColumn(label: Text('Email')),
                    DataColumn(label: Text('Phone')),
                    DataColumn(label: Text('Address')),
                    DataColumn(label: Text('Nominee')),
                  ],
                  rows: viewModel.nominees.map((nominee) {
                    return DataRow(cells: [
                      DataCell(Text(nominee.user.name)),
                      DataCell(Text(nominee.user.email)),
                      DataCell(Text(nominee.user.phoneNo)),
                      DataCell(Text(nominee.user.address)),
                      DataCell(Text(nominee.name)),
                    ]);
                  }).toList(),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
