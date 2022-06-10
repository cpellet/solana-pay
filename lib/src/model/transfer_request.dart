import 'dart:convert';

import 'package:collection/collection.dart';

class TransferRequest {
  String recipient;
  double? amount;
  String? splToken;
  List<String>? reference;
  String? label;
  String? message;
  String? memo;
  TransferRequest({
    required this.recipient,
    this.amount,
    this.splToken,
    this.reference,
    this.label,
    this.message,
    this.memo,
  });

  TransferRequest copyWith({
    String? recipient,
    double? amount,
    String? splToken,
    List<String>? reference,
    String? label,
    String? message,
    String? memo,
  }) {
    return TransferRequest(
      recipient: recipient ?? this.recipient,
      amount: amount ?? this.amount,
      splToken: splToken ?? this.splToken,
      reference: reference ?? this.reference,
      label: label ?? this.label,
      message: message ?? this.message,
      memo: memo ?? this.memo,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'recipient': recipient,
      'amount': amount,
      'splToken': splToken,
      'reference': reference,
      'label': label,
      'message': message,
      'memo': memo,
    };
  }

  factory TransferRequest.fromMap(Map<String, dynamic> map) {
    return TransferRequest(
      recipient: map['recipient'] ?? '',
      amount: map['amount']?.toDouble(),
      splToken: map['splToken'],
      reference: List<String>.from(map['reference']),
      label: map['label'],
      message: map['message'],
      memo: map['memo'],
    );
  }

  String toJson() => json.encode(toMap());

  factory TransferRequest.fromJson(String source) =>
      TransferRequest.fromMap(json.decode(source));

  @override
  String toString() {
    return 'TransferRequest(recipient: $recipient, amount: $amount, splToken: $splToken, reference: $reference, label: $label, message: $message, memo: $memo)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is TransferRequest &&
        other.recipient == recipient &&
        other.amount == amount &&
        other.splToken == splToken &&
        listEquals(other.reference, reference) &&
        other.label == label &&
        other.message == message &&
        other.memo == memo;
  }

  @override
  int get hashCode {
    return recipient.hashCode ^
        amount.hashCode ^
        splToken.hashCode ^
        reference.hashCode ^
        label.hashCode ^
        message.hashCode ^
        memo.hashCode;
  }
}
