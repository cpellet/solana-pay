import 'package:solana_pay/src/model/transaction_request.dart';
import 'package:solana_pay/src/model/transfer_request.dart';

import 'constants.dart';

/// Returns a base-58 encoded Solana Pay transaction request URL.
/// More info on https://docs.solanapay.com/core/transaction-request/overview
String encodeTransactionRequestURL(TransactionRequest transactionRequest) {
  Map<String, dynamic> queryParameters = {};
  if (transactionRequest.label != null) {
    queryParameters["label"] = transactionRequest.label;
  }
  if (transactionRequest.message != null) {
    queryParameters["message"] = transactionRequest.message;
  }
  return Uri(
          scheme: SOLANA_PROTOCOL,
          path: Uri.encodeComponent(transactionRequest.link),
          queryParameters: queryParameters)
      .toString();
}

/// Returns a base-58 encoded Solana Pay transfer request URL.
/// More info on https://docs.solanapay.com/core/transfer-request/overview
String encodeTransferRequestURL(TransferRequest transferRequest) {
  Map<String, dynamic> queryParameters = {};
  if (transferRequest.amount != null) {
    queryParameters["amount"] =
        transferRequest.amount!.toStringAsFixed(SOL_DECIMALS);
  }
  if (transferRequest.splToken != null) {
    queryParameters["spl-token"] = transferRequest.splToken;
  }
  if (transferRequest.reference != null) {
    queryParameters["reference"] = transferRequest.reference;
  }
  if (transferRequest.label != null) {
    queryParameters["label"] = transferRequest.label;
  }
  if (transferRequest.message != null) {
    queryParameters["message"] = transferRequest.message;
  }
  if (transferRequest.memo != null) {
    queryParameters["memo"] = transferRequest.memo;
  }
  return Uri(
          scheme: SOLANA_PROTOCOL,
          path: transferRequest.recipient,
          queryParameters: queryParameters)
      .toString();
}
