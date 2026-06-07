import 'package:font_awesome_flutter/font_awesome_flutter.dart';

FaIconData? getBrandIcon(String issuer) {
  final name = issuer.toLowerCase();
  if (name.contains('github')) return FontAwesomeIcons.github;
  if (name.contains('google')) return FontAwesomeIcons.google;
  if (name.contains('microsoft')) return FontAwesomeIcons.microsoft;
  if (name.contains('apple')) return FontAwesomeIcons.apple;
  if (name.contains('facebook')) return FontAwesomeIcons.facebook;
  if (name.contains('twitter') || name.contains('x')) {
    return FontAwesomeIcons.xTwitter;
  }
  if (name.contains('instagram')) return FontAwesomeIcons.instagram;
  if (name.contains('discord')) return FontAwesomeIcons.discord;
  if (name.contains('telegram')) return FontAwesomeIcons.telegram;
  if (name.contains('linkedin')) return FontAwesomeIcons.linkedin;
  if (name.contains('amazon') || name.contains('aws')) {
    return FontAwesomeIcons.amazon;
  }
  if (name.contains('binance')) return FontAwesomeIcons.bitcoin;
  if (name.contains('yahoo')) return FontAwesomeIcons.yahoo;
  if (name.contains('dropbox')) return FontAwesomeIcons.dropbox;
  if (name.contains('slack')) return FontAwesomeIcons.slack;

  return null;
}
