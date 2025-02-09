// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name =
        (locale.countryCode?.isEmpty ?? false)
            ? locale.languageCode
            : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Categories`
  String get categories {
    return Intl.message('Categories', name: 'categories', desc: '', args: []);
  }

  /// `Products`
  String get products {
    return Intl.message('Products', name: 'products', desc: '', args: []);
  }

  /// `Add to Cart`
  String get addToCart {
    return Intl.message('Add to Cart', name: 'addToCart', desc: '', args: []);
  }

  /// `Price`
  String get price {
    return Intl.message('Price', name: 'price', desc: '', args: []);
  }

  /// `Description`
  String get description {
    return Intl.message('Description', name: 'description', desc: '', args: []);
  }

  /// `See more`
  String get seeMore {
    return Intl.message('See more', name: 'seeMore', desc: '', args: []);
  }

  /// `See less`
  String get seeLess {
    return Intl.message('See less', name: 'seeLess', desc: '', args: []);
  }

  /// `Cart`
  String get cart {
    return Intl.message('Cart', name: 'cart', desc: '', args: []);
  }

  /// `Payment Method`
  String get paymentMethod {
    return Intl.message(
      'Payment Method',
      name: 'paymentMethod',
      desc: '',
      args: [],
    );
  }

  /// `Cash on delivery`
  String get cod {
    return Intl.message('Cash on delivery', name: 'cod', desc: '', args: []);
  }

  /// `Order Info`
  String get orderInfo {
    return Intl.message('Order Info', name: 'orderInfo', desc: '', args: []);
  }

  /// `Subtotal`
  String get subTotal {
    return Intl.message('Subtotal', name: 'subTotal', desc: '', args: []);
  }

  /// `Shipping cost`
  String get shippingCost {
    return Intl.message(
      'Shipping cost',
      name: 'shippingCost',
      desc: '',
      args: [],
    );
  }

  /// `Total`
  String get total {
    return Intl.message('Total', name: 'total', desc: '', args: []);
  }

  /// `Checkout`
  String get checkout {
    return Intl.message('Checkout', name: 'checkout', desc: '', args: []);
  }

  /// `Edit Product`
  String get editProduct {
    return Intl.message(
      'Edit Product',
      name: 'editProduct',
      desc: '',
      args: [],
    );
  }

  /// `Title`
  String get title {
    return Intl.message('Title', name: 'title', desc: '', args: []);
  }

  /// `EGP`
  String get egp {
    return Intl.message('EGP', name: 'egp', desc: '', args: []);
  }

  /// `Update`
  String get update {
    return Intl.message('Update', name: 'update', desc: '', args: []);
  }

  /// `Product title`
  String get productTitle {
    return Intl.message(
      'Product title',
      name: 'productTitle',
      desc: '',
      args: [],
    );
  }

  /// `Product price`
  String get productPrice {
    return Intl.message(
      'Product price',
      name: 'productPrice',
      desc: '',
      args: [],
    );
  }

  /// `Enter product title`
  String get enterProductTitle {
    return Intl.message(
      'Enter product title',
      name: 'enterProductTitle',
      desc: '',
      args: [],
    );
  }

  /// `Enter product price`
  String get enterProductPrice {
    return Intl.message(
      'Enter product price',
      name: 'enterProductPrice',
      desc: '',
      args: [],
    );
  }

  /// `Product updated successfully`
  String get productUpdatedSuccessfully {
    return Intl.message(
      'Product updated successfully',
      name: 'productUpdatedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Product added to cart successfully`
  String get productAddedToCartSuccessfully {
    return Intl.message(
      'Product added to cart successfully',
      name: 'productAddedToCartSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Empty cart`
  String get emptyCart {
    return Intl.message('Empty cart', name: 'emptyCart', desc: '', args: []);
  }

  /// `Order Confirmed!`
  String get orderConfirmed {
    return Intl.message(
      'Order Confirmed!',
      name: 'orderConfirmed',
      desc: '',
      args: [],
    );
  }

  /// `Your order has been confirmed, we will send you confirmation email shortly.`
  String get orderConfirmedDescription {
    return Intl.message(
      'Your order has been confirmed, we will send you confirmation email shortly.',
      name: 'orderConfirmedDescription',
      desc: '',
      args: [],
    );
  }

  /// `Continue Shopping`
  String get ContinueShopping {
    return Intl.message(
      'Continue Shopping',
      name: 'ContinueShopping',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
