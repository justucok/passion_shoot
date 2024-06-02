
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proj_passion_shoot/features/data/datasource/dio/remote_datasource.dart';
import 'package:proj_passion_shoot/features/data/model/event_calender/event.dart';


part 'event_event.dart';
part 'event_state.dart';

class EventBloc extends Bloc<EventEvent, EventState> {
  final RemoteDataSource remoteDatasource;
  EventBloc(this.remoteDatasource) : super(EventInitial()) {
    on<LoadEvent>((event, emit) async {
      emit(EventLoading());
      try { 
        final result = await remoteDatasource.getEvent();
        emit(EventLoaded(events: result.data));
      } catch (e) {
        emit(EventError(error: e.toString()));
      }
    });
  }
}
