class StudyData {
  StudyData({
    required this.userId,
    required this.name,
    required this.timestamp,
    required this.data,
  });

  final String userId;
  final String name;
  final String timestamp;
  final Map<String, dynamic> data;

  StudyData copyWith({
    String? userId,
    String? name,
    String? timestamp,
    Map<String, dynamic>? data,
  }) {
    return StudyData(
      userId: userId ?? this.userId,
      name: name ?? this.name,
      timestamp: timestamp ?? this.timestamp,
      data: data ?? this.data,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'name': name,
      'timestamp': timestamp,
      'data': data,
    };
  }

  factory StudyData.fromMap(Map<String, dynamic> map) {
    return StudyData(
      userId: map['userId'] ?? '',
      name: map['name'] ?? '',
      timestamp: map['timestamp'] ?? '',
      data: Map<String, dynamic>.from(map['data']), // map['data'] ?? '', //
      //awards: List<String>.from(map['awards']),
    );
  }

  @override
  String toString() {
    return 'UserModel( userId: $userId, name: $name, timestamp: $timestamp, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is StudyData &&
        other.userId == userId &&
        other.name == name &&
        other.timestamp == timestamp &&
        other.data == data;
  }

  @override
  int get hashCode {
    return userId.hashCode ^ name.hashCode ^ timestamp.hashCode ^ data.hashCode;
  }
}
