# Solana Pay

Solana Pay is a standard protocol and set of reference implementations that enable developers to incorporate decentralized payments into their apps and services.

The Solana blockchain confirms transactions in less than a second and costs on average $0.0005, providing users a seamless experience with no intermediaries.

[Read the docs to get started.](https://docs.solanapay.com)

## Supporting Wallets

- **Phantom †** ([iOS](https://apps.apple.com/us/app/phantom-solana-wallet/id1598432977), [Android](https://play.google.com/store/apps/details?id=app.phantom&hl=en_US&gl=US))
- **Solflare †** ([iOS](https://apps.apple.com/us/app/solflare/id1580902717), [Android](https://play.google.com/store/apps/details?id=com.solflare.mobile))
- Glow ([iOS](https://apps.apple.com/app/id1599584512))
- Slope ([iOS](https://apps.apple.com/us/app/slope-wallet/id1574624530), [Android](https://play.google.com/store/apps/details?id=com.wd.wallet&hl=en_US&gl=US))
- Crypto Please ([iOS](https://apps.apple.com/us/app/crypto-please/id1559625715), [Android](https://play.google.com/store/apps/details?id=com.pleasecrypto.flutter))
- FTX ([iOS](https://apps.apple.com/us/app/ftx-trade-btc-eth-shib/id1095564685), [Android](https://play.google.com/store/apps/details?id=com.blockfolio.blockfolio))

## Features

Use this plugin in your Dart/Flutter app to:

* Generate transaction and transfer request URLs using Solana Pay
* Display QR codes for such URLS to enable quick P2P transactions (coming soon)
* Embed a "Pay with Solana" button in your apps to incorporate decentralised payments (coming soon)
* Track the progress of transactions in real time and keep your users updated (coming soon)

## Getting started

This package bundles everything needed to get started with Solana Pay. Once you have created a wallet and have a public address on the Solana network, you will be able to author transaction requests directly in-app, with no server required.

## Usage

To generate a transfer request URL:

```dart
String requestURL = encodeTransferRequestURL(TransferRequest(
          recipient: "your-wallet-address",
          amount: 3, // in SOL by default
          splToken: "mint-address-of-spl-token", // specify this to use SPL accounts
          reference: [],
          label: "Your amazing store",
          message: "Donuts",
          memo: "spl-memo"));
```

## Additional information

[Solana Pay website](https://solanapay.com)

[Solana Pay documentation](https://docs.solanapay.com)

[Solana Pay specification](https://github.com/solana-labs/solana-pay/blob/master/SPEC.md)

[Original JS package](https://github.com/solana-labs/solana-pay)

## DISCLAIMER

This package and its contributors are neither affiliated with, nor endorsed by the Solana Foundation. This software is provided as-is, without a warranty of any kind. 