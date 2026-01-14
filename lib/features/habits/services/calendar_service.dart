import 'package:googleapis/calendar/v3.dart' as calendar;
import 'package:googleapis_auth/auth_io.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class CalendarService {
  static const _scopes = [calendar.CalendarApi.calendarScope];
  
  calendar.CalendarApi? _calendarApi;
  
  /// Initialize with OAuth2 (using Google Sign-In token)
  Future<void> initialize(String accessToken) async {
    final credentials = AccessCredentials(
      AccessToken('Bearer', accessToken, DateTime.now().add(const Duration(hours: 1))),
      null,
      _scopes,
    );
    
    final client = authenticatedClient(http.Client(), credentials);
    _calendarApi = calendar.CalendarApi(client);
  }
  
  /// Add habit to Google Calendar
  Future<bool> addHabitToCalendar({
    required String habitName,
    required String time, // "08:00"
    required String frequency, // "daily"
    String? description,
  }) async {
    if (_calendarApi == null) return false;
    
    try {
      // Parse time
      final timeParts = time.split(':');
      final hour = int.parse(timeParts[0]);
      final minute = int.parse(timeParts[1]);
      
      // Create event for tomorrow
      final now = DateTime.now();
      final startTime = DateTime(now.year, now.month, now.day + 1, hour, minute);
      
      final event = calendar.Event()
        ..summary = '🌟 $habitName'
        ..description = description ?? 'Suggested by LIRAZA for mental wellbeing'
        ..start = (calendar.EventDateTime()
          ..dateTime = startTime
          ..timeZone = 'UTC') // Ideally use local timezone, but UTC is safe default
        ..end = (calendar.EventDateTime()
          ..dateTime = startTime.add(const Duration(minutes: 30))
          ..timeZone = 'UTC');
      
      // Add recurrence for daily habits
      if (frequency.toLowerCase() == 'daily') {
        event.recurrence = ['RRULE:FREQ=DAILY'];
      }
      
      await _calendarApi!.events.insert(event, 'primary');
      return true;
    } catch (e) {
      print('Calendar error: $e');
      return false;
    }
  }
  
  /// Open Google Calendar web app (fallback)
  Future<void> openGoogleCalendar() async {
    final url = Uri.parse('https://calendar.google.com');
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }
}
