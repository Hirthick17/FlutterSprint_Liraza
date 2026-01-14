/// A client-side privacy filter to scrub Personal Identifiable Information (PII)
/// and detect crisis keywords locally before sending data to external APIs.
class PIIFilter {
  /// Extract and anonymize personal information before sending to AI
  static Map<String, dynamic> filterMessage(String message) {
    // Store extracted entities
    Map<String, String> extractedPII = {};
    String anonymized = message;
    
    // 1. Name Detection (Simple pattern matching)
    // Matches: "I am [Name]", "I'm [Name]", "My name is [Name]", "Call me [Name]"
    final namePattern = RegExp(
      r"\b(I am|I'm|My name is|Call me|This is)\s+([A-Z][a-z]+(?:\s+[A-Z][a-z]+)?)\b",
      caseSensitive: false,
    );
    
    anonymized = anonymized.replaceAllMapped(namePattern, (match) {
      final name = match.group(2)!;
      extractedPII['NAME'] = name;
      return '${match.group(1)} [PERSON]';
    });
    
    // 2. Location Detection
    // Matches: "from [Location]", "in [Location]", "at [Location]"
    // Note: This is basic regex. A full NLP library would be heavier but more accurate.
    final locationPattern = RegExp(
      r'\b(?:from|in|at|live in)\s+([A-Z][a-z]+(?:\s+[A-Z][a-z]+)?)\b',
    );
    
    anonymized = anonymized.replaceAllMapped(locationPattern, (match) {
      final location = match.group(1)!;
      extractedPII['LOCATION'] = location;
      return '${match.group(0)?.split(' ').first} [LOCATION]';
    });
    
    // 3. Email Detection
    final emailPattern = RegExp(
      r'\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b',
    );
    
    anonymized = anonymized.replaceAll(emailPattern, '[EMAIL]');
    
    // 4. Phone Number Detection
    final phonePattern = RegExp(
      r'\b(?:\+?\d{1,3}[-.\s]?)?\(?\d{3}\)?[-.\s]?\d{3}[-.\s]?\d{4}\b',
    );
    
    anonymized = anonymized.replaceAll(phonePattern, '[PHONE]');
    
    // 5. Age Detection
    final agePattern = RegExp(r'\b(\d{1,2})\s*(?:years old|yr old|y\.o\.)\b');
    anonymized = anonymized.replaceAll(agePattern, '[AGE]');
    
    return {
      'original': message,
      'anonymized': anonymized,
      'extracted_pii': extractedPII,
      'has_pii': extractedPII.isNotEmpty || anonymized != message,
    };
  }
  
  /// Simple emotion detection using keyword matching
  static String detectEmotion(String message) {
    final lowerMsg = message.toLowerCase();
    
    // Crisis - Highest Priority
    if (_containsAny(lowerMsg, ['suicide', 'kill myself', 'end it all', 'want to die', 'harm myself', 'no point living'])) {
      return 'CRISIS';
    }
    
    // Negative Emotions
    if (_containsAny(lowerMsg, ['anxious', 'worried', 'nervous', 'panic', 'scared', 'afraid'])) {
      return 'anxiety';
    }
    if (_containsAny(lowerMsg, ['sad', 'depressed', 'hopeless', 'down', 'cry', 'lonely', 'grief'])) {
      return 'sadness';
    }
    if (_containsAny(lowerMsg, ['angry', 'frustrated', 'mad', 'furious', 'irritated', 'hate'])) {
      return 'anger';
    }
    
    // Positive Emotions
    if (_containsAny(lowerMsg, ['happy', 'joyful', 'excited', 'great', 'good', 'love', 'wonderful', 'better'])) {
      return 'joy';
    }
    if (_containsAny(lowerMsg, ['calm', 'peaceful', 'relaxed', 'okay', 'fine'])) {
      return 'calm';
    }
    
    return 'neutral';
  }
  
  /// Calculate sentiment score (-5 to +5)
  static double calculateSentiment(String message) {
    final lowerMsg = message.toLowerCase();
    double score = 0.0;
    
    // Positive keywords
    final positiveWords = ['happy', 'good', 'great', 'better', 'love', 'wonderful', 'thanks', 'thank', 'awesome', 'enjoy', 'calm'];
    final negativeWords = ['bad', 'terrible', 'awful', 'hate', 'worst', 'horrible', 'sad', 'pain', 'hurt', 'hard', 'tired'];
    
    for (var word in positiveWords) {
      if (lowerMsg.contains(word)) score += 1.0;
    }
    
    for (var word in negativeWords) {
      if (lowerMsg.contains(word)) score -= 1.0;
    }
    
    return score.clamp(-5.0, 5.0);
  }
  
  static bool _containsAny(String text, List<String> keywords) {
    return keywords.any((keyword) => text.contains(keyword));
  }
}
