import 'package:proj_passion_shoot/features/data/datasource/remote_datasouce/api_service.dart';
import 'package:proj_passion_shoot/features/data/model/event_calender/get_event.dart';

class EventService {
  final Service service = Service();

  Future<void> displayEvents() async {
    try {
      List<GetEvent> events = await service.getEvents();
      for (var event in events) {
        print(
            'Event: ${event.title}, Date: ${event.date}, Time: ${event.time}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}

void main() async {
  EventService eventService = EventService();

  await eventService.displayEvents();
}
