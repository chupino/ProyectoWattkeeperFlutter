import 'package:flutter/material.dart';
import 'package:wattkeeperr/components/devices/details/header/headerExpanded.dart';
import 'package:wattkeeperr/components/devices/details/header/headerMini.dart';
import 'package:wattkeeperr/models/DeviceDetails.dart';

class DevicesHeader extends SliverPersistentHeaderDelegate {
  final DeviceDetails deviceDetails;
  final Size size;
  final String token;
  final Function()? reload;

  DevicesHeader(
      {required this.deviceDetails,
      required this.size,
      required this.token,
      this.reload});
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final scaleFactor = 1 - shrinkOffset / 200;
    final isCollapsed = shrinkOffset > 100;

    return Container(
      height: maxExtent,
      child: Stack(
        children: <Widget>[
          AnimatedOpacity(
              opacity: isCollapsed ? 0.0 : 1.0,
              duration: const Duration(milliseconds: 200),
              child: DeviceDetailsExpandedHeader(
                shrinkOffset: shrinkOffset,
                device: deviceDetails,
              )),
          AnimatedOpacity(
              opacity: isCollapsed ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 200),
              child: DevicesDetailsHeaderMini(
                deviceDetails: deviceDetails,
                token: token,
                reload: reload,
              )),
        ],
      ),
    );
  }

  @override
  // TODO: implement maxExtent
  double get maxExtent => size.height * 0.40;

  @override
  // TODO: implement minExtent
  double get minExtent => size.height * 0.11;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    // TODO: implement shouldRebuild
    return false;
  }
}
