// Events
import 'package:equatable/equatable.dart';

abstract class NeoEvent extends Equatable {
  const NeoEvent();
  @override
  List<Object> get props => [];
}

class GetNeoList extends NeoEvent {}