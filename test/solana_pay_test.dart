import 'package:solana/solana.dart';
import 'package:solana_pay/solana_pay.dart';
import 'package:solana_pay/src/model/transaction_request.dart';
import 'package:solana_pay/src/model/transfer_request.dart';
import 'package:test/test.dart';

Future<String> randomPublicKey() async {
  return (await (await Ed25519HDKeyPair.random()).extractPublicKey())
      .toBase58();
}

void main() {
  group('encode URLS', () {
    test('Encodes a transfer request URL', () async {
      String recipient = await randomPublicKey();
      String splToken = await randomPublicKey();
      List<String> references = [
        await randomPublicKey(),
        await randomPublicKey()
      ];
      String res = encodeTransferRequestURL(TransferRequest(
          recipient: recipient,
          amount: 0.000000001,
          splToken: splToken,
          reference: references,
          label: "label",
          message: "message",
          memo: "memo"));
      expect(
          res,
          equals(
              'solana:$recipient?amount=0.000000001&spl-token=$splToken&reference=${references[0]}&reference=${references[1]}&label=label&message=message&memo=memo'));
    });

    test("Encodes a transaction request URL", () async {
      String link = "https://www.example.com?userid=1";
      String label = "label";
      String message = "message";
      String res = encodeTransactionRequestURL(
          TransactionRequest(link: link, label: label, message: message));
      expect(
          res,
          equals(
              'solana:${Uri.encodeComponent(link)}?label=$label&message=$message'));
    });
  });

  group("decode URLs", () {
    test("Parses a transfer request URL", () async {
      String url =
          "solana:mvines9iiHiQTysrwkJjGf2gb9Ex9jXJX8ns3qwf2kN?amount=0.000000001&spl-token=82ZJ7nbGpixjeDCmEhUcmwXYfvurzAgGdtSMuHnUgyny&reference=82ZJ7nbGpixjeDCmEhUcmwXYfvurzAgGdtSMuHnUgyny&label=Michael&message=Thanks%20for%20all%20the%20fish&memo=OrderId5678";
      TransferRequest res = parseURL(url);
      expect(res, isNotNull);
      expect(
          res.recipient, equals("mvines9iiHiQTysrwkJjGf2gb9Ex9jXJX8ns3qwf2kN"));
      expect(res.amount, equals(0.000000001));
      expect(
          res.splToken, equals("82ZJ7nbGpixjeDCmEhUcmwXYfvurzAgGdtSMuHnUgyny"));
      expect(res.reference, hasLength(equals(1)));
      expect(res.reference![0],
          equals("82ZJ7nbGpixjeDCmEhUcmwXYfvurzAgGdtSMuHnUgyny"));
      expect(res.label, equals("Michael"));
      expect(res.message, equals("Thanks for all the fish"));
      expect(res.memo, equals("OrderId5678"));
    });
    test("Parses a transaction request URL", () async {
      String url =
          "solana:https%3A%2F%2Fexample.com%2Fsolana-pay%3Forder%3D12345?label=Customer3&message=Hello";
      TransactionRequest res = parseURL(url);
      expect(res, isNotNull);
      expect(res.link, equals("https://example.com/solana-pay?order=12345"));
      expect(res.label, equals("Customer3"));
      expect(res.message, equals("Hello"));
    });

    test("Throws errors accordingly", () {
      List<String> urls = [
        "solanapay:https%3A%2F%2Fexample.com%2Fsolana-pay%3Forder%3D12345?label=Customer3&message=Hello",
        "solana:OxFF29&amount=3.6",
        "solana:mvines9iiHiQTysrwkJjGf2gb9Ex9jXJX8ns3qwf2kN?amount=10USDT",
        "solana:mvines9iiHiQTysrwkJjGf2gb9Ex9jXJX8ns3qwf2kN?amount=0.000000001&spl-token=USDT",
        "solana:mvines9iiHiQTysrwkJjGf2gb9Ex9jXJX8ns3qwf2kN?amount=0.000000001&spl-token=82ZJ7nbGpixjeDCmEhUcmwXYfvurzAgGdtSMuHnUgyny&reference=ref1"
      ];
      for (var url in urls) {
        expect(() => parseURL(url), throwsA(anything));
      }
    });
  });
}
