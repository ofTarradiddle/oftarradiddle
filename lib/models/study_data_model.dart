/*
class StudyData {
  StudyData({
    required this.userId,
    required this.timestamp,
    required this.data,
  });

  final String userId;
  final String timestamp;
  final Map<String, dynamic> data;

  factory StudyData.fromJson(Map<String, dynamic> json) => StudyData(
        userId: json['userId'] as String,
        timestamp: json['timestamp'] as String,
        data: json['data'] as Map<String, dynamic>,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'userId': userId,
        'timestamp': timestamp,
        'data': data,
      };
}
*/

class StudyData {
  StudyData({
    required this.userId,
    required this.timestamp,
    required this.data,
  });

  final String userId;
  final String timestamp;
  final Map<String, dynamic> data;

  StudyData copyWith({
    String? userId,
    String? timestamp,
    Map<String, dynamic>? data,
  }) {
    return StudyData(
      userId: userId ?? this.userId,
      timestamp: timestamp ?? this.timestamp,
      data: data ?? this.data,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'timestamp': timestamp,
      'data': data,
    };
  }

  factory StudyData.fromMap(Map<String, dynamic> map) {
    return StudyData(
      userId: map['userId'] ?? '',
      timestamp: map['timestamp'] ?? '',
      data: Map<String, dynamic>.from(map['data']), // map['data'] ?? '', //
      //awards: List<String>.from(map['awards']),
    );
  }

  @override
  String toString() {
    return 'UserModel( userId: $userId, timestamp: $timestamp, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is StudyData &&
        other.userId == userId &&
        other.timestamp == timestamp &&
        other.data == data;
  }

  @override
  int get hashCode {
    return userId.hashCode ^ timestamp.hashCode ^ data.hashCode;
  }
}
