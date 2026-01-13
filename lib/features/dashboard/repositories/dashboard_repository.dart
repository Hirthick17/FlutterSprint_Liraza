import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/dashboard_models.dart';

class DashboardRepository {
  FirebaseFirestore? _firestore;

  FirebaseFirestore? get firestore {
    try {
      _firestore ??= FirebaseFirestore.instance;
      return _firestore;
    } catch (e) {
      print('Firebase not initialized: $e');
      return null;
    }
  }

  Future<List<MoodLog>> getMoodLogs(String userId, DateTime startDate) async {
    final db = firestore;
    if (db == null) return [];

    try {
      final snapshot = await db
          .collection('users')
          .doc(userId)
          .collection('mood_logs')
          .where('timestamp', isGreaterThanOrEqualTo: startDate)
          .orderBy('timestamp', descending: true)
          .get();

      return snapshot.docs.map((doc) {
        final data = doc.data();
        return MoodLog(
          id: doc.id,
          timestamp: (data['timestamp'] as Timestamp).toDate(),
          score: data['score'] as int,
          emotion: data['emotion'] as String,
          note: data['note'] as String? ?? '',
          activities: List<String>.from(data['activities'] ?? []),
        );
      }).toList();
    } catch (e) {
      print('Error fetching mood logs: $e');
      return [];
    }
  }

  Future<List<ChatSession>> getChatSessions(String userId, DateTime startDate) async {
    final db = firestore;
    if (db == null) return [];

    try {
       final snapshot = await db
          .collection('users')
          .doc(userId)
          .collection('chat_sessions')
          .where('startTime', isGreaterThanOrEqualTo: startDate)
          .orderBy('startTime', descending: true)
          .get();

      return snapshot.docs.map((doc) {
        final data = doc.data();
        return ChatSession(
          id: doc.id,
          startTime: (data['startTime'] as Timestamp).toDate(),
          durationMinutes: data['durationMinutes'] as int,
          topics: List<String>.from(data['topics'] ?? []),
        );
      }).toList();
    } catch (e) {
      print('Error fetching chat sessions: $e');
      return [];
    }
  }
}
