import 'package:shared_preferences/shared_preferences.dart';
import 'package:calendar_view/calendar_view.dart';
import 'package:weather_fox/src/features/calendar/presentation/calendarscreen.dart';
import 'dart:convert';

Future<DateTime?> getStartTimeOfFirstEvent(DateTime currentDay) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String> eventStrings = prefs.getStringList('events') ?? [];

  // Convert each event string to CalendarEventData
  List<CalendarEventData> events = eventStrings
      .map((e) => convertJsonToCalendarEvent(jsonDecode(e)))
      .toList();

  // Filter events that occur on the current day
  List<CalendarEventData> eventsOnCurrentDay = events.where((event) {
    return event.date.year == currentDay.year &&
        event.date.month == currentDay.month &&
        event.date.day == currentDay.day;
  }).toList();

  // If there are no events on the current day, return null
  if (eventsOnCurrentDay.isEmpty) {
    return null;
  }

  // Sort the events by start time
  eventsOnCurrentDay.sort((a, b) => a.startTime!.compareTo(b.startTime!));

  // Return the start time of the first event
  return eventsOnCurrentDay.first.startTime;
}

Future<DateTime?> getEndTimeOfLastEvent(DateTime currentDay) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String> eventStrings = prefs.getStringList('events') ?? [];

  // Convert each event string to CalendarEventData
  List<CalendarEventData> events = eventStrings
      .map((e) => convertJsonToCalendarEvent(jsonDecode(e)))
      .toList();

  // Filter events that occur on the current day
  List<CalendarEventData> eventsOnCurrentDay = events.where((event) {
    return event.date.year == currentDay.year &&
        event.date.month == currentDay.month &&
        event.date.day == currentDay.day;
  }).toList();

  // If there are no events on the current day, return null
  if (eventsOnCurrentDay.isEmpty) {
    return null;
  }

  // Sort the events by end time
  eventsOnCurrentDay.sort((a, b) => a.endTime!.compareTo(b.endTime!));

  // Return the end time of the last event
  return eventsOnCurrentDay.last.endTime;
}

Future<List<CalendarEventData<Object?>>> getEventofDay(
    DateTime currentDay) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String> eventStrings = prefs.getStringList('events') ?? [];

  // Convert each event string to CalendarEventData
  List<CalendarEventData> events = eventStrings
      .map((e) => convertJsonToCalendarEvent(jsonDecode(e)))
      .toList();

  // Filter events that occur on the current day
  List<CalendarEventData> eventsOnCurrentDay = events.where((event) {
    return event.date.year == currentDay.year &&
        event.date.month == currentDay.month &&
        event.date.day == currentDay.day;
  }).toList();

  // If there are no events on the current day, return null
  if (eventsOnCurrentDay.isEmpty) {
    return [];
  }

  // Sort the events by end time
  eventsOnCurrentDay.sort((a, b) => a.endTime!.compareTo(b.endTime!));

  return eventsOnCurrentDay;
}
