import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:latlong2/latlong.dart';
import 'package:taba/domain/entities/gempa_entity.dart';
import 'package:taba/presentation/pages/maps_page/maps_cubit.dart';
import 'package:taba/utils/style_config.dart';
import 'package:taba/utils/utils.dart';
import 'package:flutter/cupertino.dart';

class MapsPage extends StatefulWidget {
  const MapsPage({super.key});

  @override
  State<MapsPage> createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<MapsCubit>().getListGempa());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Peta Bencana di Indonesia'),
        ),
        body: BlocBuilder<MapsCubit, MapsState>(builder: (context, state) {
          if (state is MapsLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is MapsLoaded) {
            return FlutterMap(
              options: MapOptions(
                center: LatLng(-2.600029, 118.015776),
                zoom: 4.0,
                slideOnBoundaries: true,
                screenSize: MediaQuery.of(context).size,
                maxBounds: LatLngBounds(LatLng(-90, -180), LatLng(90, 180)),
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                ),
                MarkerLayer(
                  markers: state.result.map(
                    (gempa) {
                      final coordinates =
                          listStringToDoubleConverter(gempa.coordinates);
                      return Marker(
                        point: LatLng(coordinates[0], coordinates[1]),
                        builder: (context) {
                          // ignore: sized_box_for_whitespace
                          return Container(
                            height: 80.h,
                            width: 80.w,
                            child: IconButton(
                              onPressed: () {
                                showGeneralDialog(
                                  context: context,
                                  barrierDismissible: true,
                                  barrierLabel:
                                      MaterialLocalizations.of(context)
                                          .modalBarrierDismissLabel,
                                  pageBuilder:
                                      (context, animation, secondaryAnimation) {
                                    return SimpleDialog(
                                      contentPadding:
                                          EdgeInsets.symmetric(vertical: 8.h),
                                      children: [
                                        popUpWindow(context, gempa),
                                      ],
                                    );
                                  },
                                );
                              },
                              icon: const Icon(
                                Icons.location_on,
                                color: Colors.red,
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ).toList(),
                )
              ],
            );
          } else if (state is MapsError) {
            return Center(
              child: Text(state.message),
            );
          }
          return Container();
        }),
      ),
    );
  }

  Widget popUpWindow(BuildContext context, GempaEntity gempa) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 8.h),
            color: ColorSystem.secondary,
            child: Text(
              'GEMPA',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'opensans',
                fontWeight: FontWeight.w900,
                fontSize: 18.sp,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(height: 8.h,),
          Text(
            gempa.wilayah,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'opensans',
              fontWeight: FontWeight.w900,
              fontSize: 14.sp,
              color: Theme.of(context).focusColor,
            ),
          ),
          SizedBox(height: 8.h,),
          Table(
            columnWidths: const {
              0: FlexColumnWidth(3),
              1: FlexColumnWidth(1),
              2: FlexColumnWidth(5),
            },
            children: [
              TableRow(
                children: [
                  Text(
                    'Magnitude',
                    style: TextStyle(
                      fontFamily: 'opensans',
                      fontWeight: FontWeight.w500,
                      fontSize: 14.sp,
                      color: Theme.of(context).focusColor,
                    ),
                  ),
                  Text(
                    ':',
                    style: TextStyle(
                      fontFamily: 'opensans',
                      fontWeight: FontWeight.w500,
                      fontSize: 14.sp,
                      color: Theme.of(context).focusColor,
                    ),
                  ),
                  Text(
                    gempa.magnitude,
                    style: TextStyle(
                      fontFamily: 'opensans',
                      fontWeight: FontWeight.w700,
                      fontSize: 14.sp,
                      color: Theme.of(context).focusColor,
                    ),
                  ),
                ],
              ),
              TableRow(
                children: [
                  Text(
                    'Kedalaman',
                    style: TextStyle(
                      fontFamily: 'opensans',
                      fontWeight: FontWeight.w500,
                      fontSize: 14.sp,
                      color: Theme.of(context).focusColor,
                    ),
                  ),
                  Text(
                    ':',
                    style: TextStyle(
                      fontFamily: 'opensans',
                      fontWeight: FontWeight.w500,
                      fontSize: 14.sp,
                      color: Theme.of(context).focusColor,
                    ),
                  ),
                  Text(
                    gempa.kedalaman,
                    style: TextStyle(
                      fontFamily: 'opensans',
                      fontWeight: FontWeight.w700,
                      fontSize: 14.sp,
                      color: Theme.of(context).focusColor,
                    ),
                  ),
                ],
              ),
              TableRow(
                children: [
                  Text(
                    'Waktu',
                    style: TextStyle(
                      fontFamily: 'opensans',
                      fontWeight: FontWeight.w500,
                      fontSize: 14.sp,
                      color: Theme.of(context).focusColor,
                    ),
                  ),
                  Text(
                    ':',
                    style: TextStyle(
                      fontFamily: 'opensans',
                      fontWeight: FontWeight.w500,
                      fontSize: 14.sp,
                      color: Theme.of(context).focusColor,
                    ),
                  ),
                  Text(
                    '${gempa.tanggal}, ${gempa.jam}',
                    style: TextStyle(
                      fontFamily: 'opensans',
                      fontWeight: FontWeight.w700,
                      fontSize: 14.sp,
                      color: Theme.of(context).focusColor,
                    ),
                  ),
                ],
              ),
              TableRow(
                children: [
                  Text(
                    'Potensi',
                    style: TextStyle(
                      fontFamily: 'opensans',
                      fontWeight: FontWeight.w500,
                      fontSize: 14.sp,
                      color: Theme.of(context).focusColor,
                    ),
                  ),
                  Text(
                    ':',
                    style: TextStyle(
                      fontFamily: 'opensans',
                      fontWeight: FontWeight.w500,
                      fontSize: 14.sp,
                      color: Theme.of(context).focusColor,
                    ),
                  ),
                  Text(
                    gempa.potensi,
                    style: TextStyle(
                      fontFamily: 'opensans',
                      fontWeight: FontWeight.w700,
                      fontSize: 14.sp,
                      color: Theme.of(context).focusColor,
                    ),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
