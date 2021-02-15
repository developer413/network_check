import 'package:network_bloc/bloc/ConnectionState.dart';

abstract class ConnectionEvent {}

class ListenConnection extends ConnectionEvent {}

class ConnectionChanged extends ConnectionEvent {
  NetworkConnectionState connectionState;

  ConnectionChanged(this.connectionState);
}
