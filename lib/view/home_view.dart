import 'package:flutter/material.dart';
import 'package:football/controller/home_controller.dart';
import 'package:football/widgets/footer_widget.dart';
import 'package:football/widgets/homeheader_widgets.dart';
import 'package:football/widgets/homesection_widgets.dart';
import 'package:football/widgets/league_wirdgets.dart';
import 'package:football/widgets/sponsor_widget.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: RefreshIndicator(
          onRefresh: controller.getHomeData,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                // Header
                const HomeHeader(),

                // First main section
                const HeroSection(),
                Gap(30),

                // League standings
                const LeagueStandings(),
                Gap(30),
                const SponsorWidget(),
                Gap(30),
                const FooterWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
