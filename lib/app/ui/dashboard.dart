import 'package:corona_virus_traker_flutte_app/app/repositories/data_repositories.dart';
import 'package:corona_virus_traker_flutte_app/app/services/api.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'endpoint_card.dart';

class DashBoard extends StatefulWidget {
  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  @override
  void initState() {
    super.initState();
    _updateData();
  }

  int _cases;

  Future<void> _updateData() async {
    final dataRepository = Provider.of<DataRepository>(context, listen: false);
    final cases = await dataRepository.getEndPointData(Endpoint.cases);
    setState(() {
      _cases = cases;
    });
    print(_cases);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Coronavirus Tracker'),
      ),
      body: RefreshIndicator(
        onRefresh: _updateData,
        child: ListView(
          children: [
            EndPointCard(
              endpoint: Endpoint.cases,
              value: _cases,
            ),
          ],
        ),
      ),
    );
  }
}
