import 'package:solana/solana.dart';
import 'package:solana_pay/src/constants.dart';
import 'package:solana_pay/src/model/transaction_request.dart';
import 'package:solana_pay/src/model/transfer_request.dart';

/// Decodes a base-58 encoded Solana Pay transaction or transfer request url.
/// Returns a TransactionRequest or TransferRequest object
dynamic parseURL(String url) {
  Uri uri = Uri.parse(url);
  if (uri.scheme != SOLANA_PROTOCOL) {
    throw ArgumentError("url protocol is invalid");
  }
  return uri.queryParameters.containsKey("amount")
      ? parseTransferRequestURL(url)
      : parseTransactionRequestURL(url);
}

/// Decodes a base-58 encoded Solana Pay transfer request url.
/// More info on https://docs.solanapay.com/core/transfer-request/overview
TransferRequest parseTransferRequestURL(String url) {
  Uri uri = Uri.parse(url);
  String recipient = Ed25519HDPublicKey.fromBase58(uri.path).toBase58();
  TransferRequest res = TransferRequest(recipient: recipient);
  String? amountParam = uri.queryParameters["amount"];
  if (amountParam != null) {
    double amount = double.parse(amountParam);
    if (amount.isNaN || amount.isNegative) {
      throw RangeError("amount must be a valid number");
    }
    res.amount = amount;
  }
  String? splTokenParam = uri.queryParameters['spl-token'];
  if (splTokenParam != null) {
    String splToken = Ed25519HDPublicKey.fromBase58(splTokenParam).toBase58();
    res.splToken = splToken;
  }
  List<String>? referenceParam = uri.queryParametersAll['reference'];
  if (referenceParam != null) {
    List<String> reference = referenceParam
        .map((e) => Ed25519HDPublicKey.fromBase58(e).toBase58())
        .toList();
    res.reference = reference;
  }
  res.label = uri.queryParameters['label'];
  res.message = uri.queryParameters['message'];
  res.memo = uri.queryParameters['memo'];
  return res;
}

/// Decodes a base-58 encoded Solana Pay transaction request url.
/// More info on https://docs.solanapay.com/core/transaction-request/overview
TransactionRequest parseTransactionRequestURL(String url) {
  Uri uri = Uri.parse(url);
  String link = Uri.decodeComponent(uri.path);
  TransactionRequest res = TransactionRequest(link: link);
  if (Uri.parse(link).scheme != HTTPS_PROTOCOL) {
    throw ArgumentError(
        "transaction request link argument must have https protocol");
  }
  res.label = uri.queryParameters["label"];
  res.message = uri.queryParameters["message"];
  return res;
}
