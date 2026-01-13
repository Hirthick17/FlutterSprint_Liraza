/// Firestore collection and field constants
class FirestoreConstants {
  // Collection Names
  static const String usersCollection = 'users';
  static const String therapistsCollection = 'therapists';
  
  // Subcollection Names
  static const String moodLogsSubcollection = 'mood_logs';
  static const String chatSessionsSubcollection = 'chat_sessions';
  static const String messagesSubcollection = 'messages';
  static const String behaviorPatternsSubcollection = 'behavior_patterns';
  static const String insightsSubcollection = 'insights';
  
  // User Fields
  static const String userEmail = 'email';
  static const String userDisplayName = 'displayName';
  static const String userPhotoUrl = 'photoUrl';
  static const String userCreatedAt = 'createdAt';
  static const String userLastActive = 'lastActive';
  static const String userTotalChatSessions = 'totalChatSessions';
  static const String userAverageMoodScore = 'averageMoodScore';
  static const String userCurrentStreak = 'currentStreak';
  
  // Mood Log Fields
  static const String moodLogId = 'id';
  static const String moodLogScore = 'moodScore';
  static const String moodLogEmotion = 'dominantEmotion';
  static const String moodLogConfidence = 'confidence';
  static const String moodLogTriggers = 'triggers';
  static const String moodLogAnalysis = 'analysis';
  static const String moodLogTimestamp = 'timestamp';
  static const String moodLogSessionRef = 'sessionRef';
  
  // Chat Session Fields
  static const String sessionId = 'id';
  static const String sessionStartTime = 'startTime';
  static const String sessionEndTime = 'endTime';
  static const String sessionMessageCount = 'messageCount';
  static const String sessionMoodAtStart = 'moodAtStart';
  static const String sessionMoodAtEnd = 'moodAtEnd';
  static const String sessionAvgResponseTime = 'avgResponseTime';
  static const String sessionCrisisDetected = 'crisisDetected';
  
  // Message Fields
  static const String messageId = 'id';
  static const String messageContent = 'content';
  static const String messageSender = 'sender';
  static const String messageTimestamp = 'timestamp';
  static const String messageMoodScore = 'moodScore';
  static const String messageEmotion = 'emotion';
  
  // Message Sender Types
  static const String senderUser = 'user';
  static const String senderAI = 'ai';
  
  // Behavior Pattern Fields
  static const String patternId = 'id';
  static const String patternWeekStart = 'weekStart';
  static const String patternWeekEnd = 'weekEnd';
  static const String patternMostActiveTime = 'mostActiveTime';
  static const String patternAverageMoodScore = 'averageMoodScore';
  static const String patternMoodTrend = 'moodTrend';
  static const String patternCommonEmotions = 'commonEmotions';
  static const String patternConversationTopics = 'conversationTopics';
  static const String patternSuggestedActions = 'suggestedActions';
  static const String patternRiskFactors = 'riskFactors';
  static const String patternConsecutiveGoodDays = 'consecutiveGoodDays';
  static const String patternConsecutiveBadDays = 'consecutiveBadDays';
  static const String patternGeneratedAt = 'generatedAt';
  
  // Mood Trend Values
  static const String trendImproving = 'improving';
  static const String trendDeclining = 'declining';
  static const String trendStable = 'stable';
  
  // Insight Fields
  static const String insightId = 'id';
  static const String insightType = 'type';
  static const String insightTitle = 'title';
  static const String insightMessage = 'message';
  static const String insightActionable = 'actionable';
  static const String insightActionText = 'actionText';
  static const String insightActionRoute = 'actionRoute';
  static const String insightCreatedAt = 'createdAt';
  static const String insightRead = 'read';
  static const String insightPriority = 'priority';
  
  // Insight Types
  static const String insightTypeAchievement = 'achievement';
  static const String insightTypeWarning = 'warning';
  static const String insightTypeTip = 'tip';
  static const String insightTypeMilestone = 'milestone';
  static const String insightTypeCrisis = 'crisis';
  
  // Therapist Fields
  static const String therapistId = 'id';
  static const String therapistName = 'name';
  static const String therapistSpecialty = 'specialty';
  static const String therapistBio = 'bio';
  static const String therapistExperience = 'experience';
  static const String therapistRating = 'rating';
  static const String therapistReviewCount = 'reviewCount';
  static const String therapistLocation = 'location';
  static const String therapistAddress = 'address';
  static const String therapistCity = 'city';
  static const String therapistGmeetLink = 'gmeetLink';
  static const String therapistAvailability = 'availability';
  static const String therapistPriceRange = 'priceRange';
  static const String therapistVerified = 'verified';
  static const String therapistPhone = 'phone';
  static const String therapistEmail = 'email';
  static const String therapistLanguages = 'languages';
  static const String therapistPhotoUrl = 'photoUrl';
}
