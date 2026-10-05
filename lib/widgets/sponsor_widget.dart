import 'package:flutter/material.dart';
import 'package:football/controller/home_controller.dart';
import 'package:football/utils/dio_connector.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class SponsorWidget extends GetView<HomeController> {
  const SponsorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.sponsors.isEmpty) {
        return const SizedBox.shrink();
      }

      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "OUR SPONSORS",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 5),

            const Text(
              "Our valued partners",
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),

            const SizedBox(height: 16),

            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.sponsors.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 18,
                childAspectRatio: 0.85,
              ),
              itemBuilder: (context, index) {
                final sponsor = controller.sponsors[index];

                final String name = sponsor.name ?? "Sponsor";
                final String website = sponsor.website ?? "";

                String logo = sponsor.logo?.url ?? "";

                if (logo.isNotEmpty && !logo.startsWith("http")) {
                  logo =
                      DioConnector.dio.options.baseUrl.replaceAll(
                        "/api/",
                        "/",
                      ) +
                      logo;
                }

                return InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () async {
                    if (website.isEmpty) return;

                    String url = website.trim();

                    if (!url.startsWith("http://") &&
                        !url.startsWith("https://")) {
                      url = "https://$url";
                    }

                    final Uri uri = Uri.parse(url);

                    await launchUrl(uri, mode: LaunchMode.externalApplication);
                  },
                  child: Column(
                    children: [
                      Container(
                        height: 130,
                        width: double.infinity,
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.08),
                              blurRadius: 8,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),

                        child: logo.isNotEmpty
                            ? Image.network(
                                logo,
                                fit: BoxFit.contain,
                                errorBuilder: (context, error, stackTrace) {
                                  return const Icon(Icons.business, size: 45);
                                },
                              )
                            : const Icon(Icons.business, size: 45),
                      ),

                      const SizedBox(height: 8),

                      Text(
                        name,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      );
    });
  }
}
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:football/controller/home_controller.dart';

// class SponsorWidget extends GetView<HomeController> {
//   const SponsorWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Obx(() {
//       if (controller.sponsors.isEmpty) {
//         return const SizedBox.shrink();
//       }

//       return Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text(
//               "Our Sponsors",
//               style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//             ),

//             const SizedBox(height: 5),

//             const Text(
//               "Fueling the future of football.",
//               style: TextStyle(fontSize: 14, color: Colors.grey),
//             ),

//             const SizedBox(height: 16),

//             GridView.builder(
//               shrinkWrap: true,
//               physics: const NeverScrollableScrollPhysics(),
//               itemCount: controller.sponsors.length,
//               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2,
//                 crossAxisSpacing: 12,
//                 mainAxisSpacing: 18,
//                 childAspectRatio: 0.85,
//               ),
//               itemBuilder: (context, index) {
//                 final sponsor = controller.sponsors[index];

//                 final String name = sponsor.name ?? "Sponsor";
//                 final String website = sponsor.website ?? "";

//                 final logoData = sponsor.logo;
//                 String logo = "";

//                 if (logoData is Map) {
//                   final String logo = sponsor.logo?.url ?? "";
//                 }

//                 if (logo.isNotEmpty && !logo.startsWith("http")) {
//                   logo = "https://nepalschoolfootballleague.com/$logo";
//                 }

//                 return Column(
//                   children: [
//                     Container(
//                       height: 130,
//                       width: double.infinity,
//                       padding: const EdgeInsets.all(18),
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(12),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black.withOpacity(0.08),
//                             blurRadius: 8,
//                             offset: const Offset(0, 3),
//                           ),
//                         ],
//                       ),
//                       child: logo.isNotEmpty
//                           ? Image.network(
//                               logo,
//                               fit: BoxFit.contain,
//                               errorBuilder: (context, error, stackTrace) {
//                                 return const Icon(Icons.business, size: 45);
//                               },
//                             )
//                           : const Icon(Icons.business, size: 45),
//                     ),

//                     const SizedBox(height: 8),

//                     Text(
//                       name,
//                       textAlign: TextAlign.center,
//                       maxLines: 2,
//                       overflow: TextOverflow.ellipsis,
//                       style: const TextStyle(
//                         fontSize: 13,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),

//                     if (website.isNotEmpty) ...[
//                       const SizedBox(height: 3),
//                       Text(
//                         website,
//                         maxLines: 1,
//                         overflow: TextOverflow.ellipsis,
//                         style: const TextStyle(
//                           fontSize: 10,
//                           color: Colors.grey,
//                         ),
//                       ),
//                     ],
//                   ],
//                 );
//               },
//             ),
//           ],
//         ),
//       );
//     });
//   }
// }
