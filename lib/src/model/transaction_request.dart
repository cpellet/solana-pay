import 'dart:convert';

class TransactionRequest {
  String link;
  String? label;
  String? message;
  TransactionRequest({
    required this.link,
    this.label,
    this.message,
  });

  TransactionRequest copyWith({
    String? link,
    String? label,
    String? message,
  }) {
    return TransactionRequest(
      link: link ?? this.link,
      label: label ?? this.label,
      message: message ?? this.message,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'link': link,
      'label': label,
      'message': message,
    };
  }

  factory TransactionRequest.fromMap(Map<String, dynamic> map) {
    return TransactionRequest(
      link: map['link'] ?? '',
      label: map['label'],
      message: map['message'],
    );
  }

  String toJson() => json.encode(toMap());

  factory TransactionRequest.fromJson(String source) =>
      TransactionRequest.fromMap(json.decode(source));

  @override
  String toString() =>
      'TransactionRequest(link: $link, label: $label, message: $message)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TransactionRequest &&
        other.link == link &&
        other.label == label &&
        other.message == message;
  }

  @override
  int get hashCode => link.hashCode ^ label.hashCode ^ message.hashCode;
}
