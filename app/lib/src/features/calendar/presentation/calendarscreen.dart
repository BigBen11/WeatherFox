// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:calendar_view/calendar_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:device_calendar/device_calendar.dart';

CalendarEventData convertJsonToCalendarEvent(Map<String, dynamic> json) {
  return CalendarEventData(
    title: json['title'],
    date: DateTime.parse(json['date']),
    startTime: DateTime.parse(json['startTime']),
    endTime: DateTime.parse(json['endTime']),
    description: json['description'],
  );
}

Map<String, dynamic> convertCalendarEventToJson(CalendarEventData event) {
  return {
    'title': event.title,
    'date': event.date.toIso8601String(),
    'startTime': event.startTime!.toIso8601String(),
    'endTime': event.endTime!.toIso8601String(),
    'description': event.description,
  };
}

List<Calendar> calendars = [];

DeviceCalendarPlugin _deviceCalendarPlugin = DeviceCalendarPlugin();

List<CalendarEventData> usersCalendarEventsList = [];

final eventControllerProvider =
    StateProvider<EventController>((ref) => EventController());

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  late EventController _eventController;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        _eventController = ref.watch(eventControllerProvider);
        _loadEvents().then((loadedEvents) {
          _eventController.addAll(loadedEvents);
        });

        return CalendarControllerProvider(
          controller: _eventController,
          child: MaterialApp(
            home: Scaffold(
              appBar: AppBar(
                actions: <Widget>[
                  PopupMenuButton<String>(
                    onSelected: (String result) {
                      if (result == 'import') {
                        readUsersCalendar(ref); //Funktion zum Importieren!
                        _eventController.addAll(usersCalendarEventsList);
                      }
                    },
                    itemBuilder: (BuildContext context) =>
                        <PopupMenuEntry<String>>[
                      const PopupMenuItem<String>(
                        value: 'import',
                        child: Text('Kalendereinträge importieren'),
                      ),
                      // hier weitere Einträge
                    ],
                  ),
                ],
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => Navigator.pop(context),
                ),
                title: const Text('Calendar Screen'),
              ),
              body: MonthView(
                onEventTap: (event, dateTime) =>
                    _showEventDetails(context, event, ref),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () => _showAddEventDialog(context, ref),
                child: const Icon(Icons.add),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<List<CalendarEventData>> _loadEvents() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> eventStrings = prefs.getStringList('events') ?? [];
    return eventStrings
        .map((e) => convertJsonToCalendarEvent(jsonDecode(e)))
        .toList();
  }

  readUsersCalendar(WidgetRef ref) async {
    var permissionGranted = await _deviceCalendarPlugin.hasPermissions();
    if (permissionGranted.isSuccess && (permissionGranted.data ?? false)) {
      permissionGranted = await _deviceCalendarPlugin.requestPermissions();
      if (!permissionGranted.isSuccess || !(permissionGranted.data ?? false)) {
        return;
      }
    }
    final startDate = DateTime.now().add(Duration(days: -20));
    final endDate = DateTime.now().add(Duration(days: 20));
    final calResult = await _deviceCalendarPlugin.retrieveCalendars();
    calendars = calResult.data ?? [];

    for (int i = 0; i < calendars.length; i++) {
      final calEvents = await _deviceCalendarPlugin.retrieveEvents(
          calendars[i].id,
          RetrieveEventsParams(startDate: startDate, endDate: endDate));
      if (calEvents.data!.isNotEmpty) {
        for (Event event in calEvents.data!) {
          CalendarEventData newEvent = CalendarEventData(
            title: event.title.toString(),
            date: event.start ??
                DateTime.now(), //Problems with convertation: to fix!
            startTime: event.start,
            endTime: event.end,
            description:
                event.description ?? 'default value', //TODO: save problems
          );

          usersCalendarEventsList.add(newEvent);

          _addEvent(newEvent.title, newEvent.date, newEvent.startTime!,
              newEvent.endTime!, newEvent.description, context, ref);

          // Save event to local storage
          SharedPreferences prefs = await SharedPreferences.getInstance();
          List<String> events = prefs.getStringList('events') ?? [];
          events.add(jsonEncode(convertCalendarEventToJson(
              newEvent))); // Convert CalendarEventData to Map and then to JSON string
          await prefs.setStringList('events', events);
        }
      }
    }
  }

  void _addEvent(
    String title,
    DateTime date,
    DateTime startTime,
    DateTime endTime,
    String description,
    BuildContext context,
    WidgetRef ref,
  ) async {
    final event = CalendarEventData(
      title: title,
      date: date,
      startTime: startTime,
      endTime: endTime,
      description: description,
    );

    ref.read(eventControllerProvider).add(event);

    // Save event to local storage
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> events = prefs.getStringList('events') ?? [];
    events.add(jsonEncode(convertCalendarEventToJson(
        event))); // Convert CalendarEventData to Map and then to JSON string
    await prefs.setStringList('events', events);
  }

  Future<void> _showAddEventDialog(BuildContext context, WidgetRef ref) async {
    TextEditingController titleController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();

    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (selectedDate == null) return;

    TimeOfDay? selectedStartTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      helpText: 'Select Start Time',
    );
    if (selectedStartTime == null) return;

    TimeOfDay? selectedEndTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      helpText: 'Select End Time',
    );
    if (selectedEndTime == null) return;

    DateTime startTime = DateTime(selectedDate.year, selectedDate.month,
        selectedDate.day, selectedStartTime.hour, selectedStartTime.minute);
    DateTime endTime = DateTime(selectedDate.year, selectedDate.month,
        selectedDate.day, selectedEndTime.hour, selectedEndTime.minute);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Event'),
          content: Column(
            children: <Widget>[
              TextField(
                controller: titleController,
                decoration: const InputDecoration(hintText: "Title"),
              ),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(hintText: "Description"),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Add'),
              onPressed: () {
                _addEvent(
                  titleController.text,
                  selectedDate,
                  startTime,
                  endTime,
                  descriptionController.text,
                  context,
                  ref,
                );
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showEventDetails(
      BuildContext context, CalendarEventData event, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(event.title),
          content: Column(
            children: <Widget>[
              Text(
                  'Date: ${event.date.day}.${event.date.month}.${event.date.year}'),
              Text('Start Time: ${event.date.hour}:${event.date.minute}'),
              Text('End Time: ${event.endDate.hour}:${event.endDate.minute}'),
              Text('Description: ${event.description}'),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Delete'),
              onPressed: () {
                _deleteEvent(event, ref);
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _deleteEvent(CalendarEventData event, WidgetRef ref) async {
    // Remove event from EventController
    ref.read(eventControllerProvider).remove(event);

    // Load events from SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> eventStrings = prefs.getStringList('events') ?? [];

    // Convert each event string to CalendarEventData and remove the event
    List<CalendarEventData> events = eventStrings
        .map((e) => convertJsonToCalendarEvent(jsonDecode(e)))
        .toList();
    events.removeWhere((e) =>
        e.title == event.title &&
        e.date == event.date &&
        e.endDate == event.endDate &&
        e.description == event.description);

    // Convert the remaining events back to strings and save them
    List<String> updatedEventStrings =
        events.map((e) => jsonEncode(convertCalendarEventToJson(e))).toList();
    await prefs.setStringList('events', updatedEventStrings);
  }
}
