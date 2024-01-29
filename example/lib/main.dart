// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'dart:typed_data';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:screenshot/screenshot.dart';
import 'package:test_package/collage/collage_show.dart';
import 'package:test_package/cubit/collage_cubit_cubit.dart';

void main() {
  BlocOverrides.runZoned(
    () => runApp(const MyApp()),
    blocObserver: AppBlocObserver(),
  );
}

class AppBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CollageCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primaryColor: Colors.blue,
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  ScreenshotController screenshotController = ScreenshotController();
  late CollageCubit collageCubit;

  @override
  void initState() {
    collageCubit = BlocProvider.of<CollageCubit>(context);
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      collageCubit.inistall(selectedCollageType: CollageType.values.first);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Image Collage"),
      ),
      body: BlocBuilder<CollageCubit, CollageCubitState>(
        bloc: collageCubit,
        builder: (context, state) {
          if (state is ImageListState) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Screenshot(
                      controller: screenshotController,
                      child: CollageWidget().commonCollageShow(
                        state: state,
                        collageCubit: collageCubit,
                        images: state.allImageSave[state.selectedCollageType.toString()]?.toList() ?? [],
                        context: context,
                        isDisabled: false,
                        isColorShow: true,
                        selectedCollageType: state.selectedCollageType,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () async {
                      Color selectedColor = await showColorPickerDialog(
                        context,
                        Colors.red,
                        backgroundColor: Colors.white,
                        pickersEnabled: {
                          ColorPickerType.wheel: true,
                          ColorPickerType.both: false,
                          ColorPickerType.accent: false,
                          ColorPickerType.primary: false,
                        },
                        showRecentColors: false,
                      );

                      collageCubit.changeColor(state: state, color: selectedColor);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Frame Color Select'),
                          Container(
                            height: 35,
                            width: 35,
                            decoration: BoxDecoration(
                              color: state.color,
                              border: Border.all(color: Colors.black),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  bottomRowList(state)
                ],
              ),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await screenshotController.capture().then(
            (value) async {
              SnackBar snackBar;
              if (value != null) {
                var isDone = await ImageGallerySaver.saveImage(
                  Uint8List.fromList(value),
                  quality: 100,
                );
                if (isDone != null) {
                  snackBar = const SnackBar(
                    content: Text('File saved successfully'),
                  );
                } else {
                  snackBar = const SnackBar(
                    content: Text('Can\'t save the file? Try again.'),
                  );
                }
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
            },
          );
        },
        child: const Icon(Icons.save),
      ),
    );
  }

  Widget bottomRowList(ImageListState state) {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        itemCount: state.allImageSave.length,
        shrinkWrap: false,
        primary: true,
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        itemBuilder: (context, index) {
          String currentKey = state.allImageSave.keys.elementAt(index);
          return Container(
            margin: const EdgeInsets.all(5),
            padding: EdgeInsets.all(state.selectedCollageType.toString() == currentKey ? 1 : 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: state.selectedCollageType.toString() == currentKey
                  ? Colors.black.withOpacity(0.8)
                  : Colors.grey.withOpacity(0.1),
            ),
            child: GestureDetector(
              onTap: () {
                collageCubit.blankList(
                  selectedCollageType: CollageType.values.where((element) => element.toString() == currentKey).first,
                  state: state,
                );
              },
              child: Center(
                child: SizedBox(
                  child: CollageWidget().commonCollageShow(
                    collageCubit: collageCubit,
                    images: state.allImageSave.values.elementAt(index),
                    selectedCollageType: CollageType.values.where((element) => element.toString() == currentKey).first,
                    isColorShow: false,
                    state: state,
                    context: context,
                    isDisabled: true,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
