import 'dart:core';

class EventModel<T> {
  final int event;
  final T data;
   T? data2;

  EventModel({required this.event, required this.data, this.data2});
}