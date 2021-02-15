import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:network_bloc/bloc/ConnectionBloc.dart';
import 'package:network_bloc/bloc/ConnectionState.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _connectionStatus = 'Waiting';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<ConnectionBloc, NetworkConnectionState>(
        builder: (context, state) {
          if (state is ConnectionInitial) {
            _connectionStatus = 'connection initialized';
          } else if (state is ConnectionWifi) {
            _connectionStatus = 'connected to Wifi';
          } else if (state is ConnectionMobile) {
            _connectionStatus = 'using cellular data';
          } else {
            _connectionStatus = 'no connection';
          }
          return Center(child: Text('network Status: $_connectionStatus'));
        },
      ),
    );
  }
}
