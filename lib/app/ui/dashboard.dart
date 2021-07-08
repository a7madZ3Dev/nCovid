import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/api.dart';
import './endpoint_card.dart';
import '../repositories/endpoints_data.dart';
import '../repositories/data_repository.dart';
import './last_updated_status_text.dart';
import './show_alert_dialog.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  EndpointsData _endpointsData;

  @override
  void initState() {
    super.initState();
    final dataRepository = Provider.of<DataRepository>(context, listen: false);
    _endpointsData = dataRepository.getAllEndpointsCachedData();
    _updateData();
  }

  Future<void> _updateData() async {
    try {
      final dataRepository =
          Provider.of<DataRepository>(context, listen: false);
      final endpointsData = await dataRepository.getAllEndpointsData();
      setState(() => _endpointsData = endpointsData);
    } on SocketException catch (_) {   // internet cut 
      showAlertDialog(
        context: context,
        title: 'Connection Error',
        content: 'Could not retrieve data. Please try again later.',
        defaultActionText: 'OK',
      );
    } catch (_) {    // invalid log in  
      showAlertDialog(
        context: context,
        title: 'Unknown Error',
        content: 'You con\'t access this website',
        defaultActionText: 'OK',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final formatter = LastUpdatedDateFormatter(
      lastUpdated: _endpointsData != null
          ? _endpointsData.values[Endpoint.cases]?.date
          : null,
    );
    return Scaffold(
      appBar: AppBar(
        title: Text('CoronaVirus Tracker'),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: _updateData,
        child: ListView(children: [
          LastUpdatedStatusText(
            text: formatter.lastUpdatedStatusText(),
          ),
          ...Endpoint.values
              .map((endpoint) => EndpointCard(
                    endpoint: endpoint,
                    value: _endpointsData != null
                        ? _endpointsData.values[endpoint]?.value
                        : null,
                  ))
              .toList(),
        ]),
      ),
    );
  }
}
