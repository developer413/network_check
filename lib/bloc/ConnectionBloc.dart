import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:network_bloc/bloc/ConnectionEvent.dart';
import 'package:network_bloc/bloc/ConnectionState.dart';

class ConnectionBloc extends Bloc<ConnectionEvent, NetworkConnectionState> {
  ConnectionBloc() : super(ConnectionInitial());

  final Connectivity _connectivity = Connectivity();
  StreamSubscription _subscription;

  @override
  Stream<NetworkConnectionState> mapEventToState(ConnectionEvent event) async* {
    if (event is ListenConnection) {
      _subscription = _connectivity.onConnectivityChanged.listen((status) {
        switch (status) {
          case ConnectivityResult.wifi:
            add(ConnectionChanged(ConnectionWifi()));
            break;
          case ConnectivityResult.mobile:
            add(ConnectionChanged(ConnectionMobile()));
            break;
          case ConnectivityResult.none:
            add(ConnectionChanged(NoConnection()));
            break;
          default:
            add(ConnectionChanged(ConnectionInitial()));
            break;
        }
      });
    }
    if (event is ConnectionChanged) yield event.connectionState;
  }

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}
