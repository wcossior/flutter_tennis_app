import 'dart:io';
import 'package:flutter_app_tenis/models/sponsor_model.dart';
import 'package:flutter_app_tenis/providers/sponsor_provider.dart';

class SponsorRepository {
  static final SponsorRepository _instancia = new SponsorRepository._internal();

  factory SponsorRepository() {
    return _instancia;
  }

  SponsorRepository._internal();

  List<Sponsor> list = [];
  final SponsorProvider sponsorProvider = SponsorProvider();

  Future getSponsors(String id) async {
    List<Sponsor> resp = await sponsorProvider.getSponsors(id);
    list = resp;
  }

  Future<String> addSponsor(Sponsor sponsor, File img) => sponsorProvider.addSponsor(sponsor, img);
  Future<String> deleteSponsor(String id, String urlImg) => sponsorProvider.deleteSponsor(id, urlImg);

  List<Sponsor> get sponsors => list;
}
