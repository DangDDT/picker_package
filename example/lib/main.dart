import 'package:core_picker/core/core.dart';
import 'package:example/config/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:vif_flutter_base/vif_flutter_base.dart';

import 'fade_slide_transition.dart';
import 'translator.dart';
import 'vif_base/vif_base.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  VIFBase.I.init(
    dialog: VIFDialog(),
    downloader: VIFDownloader(),
    fileHelper: VIFFileHelper(),
    uploader: VIFUploader(),
    mediaHelper: VIFMediaHelper(),
    dateTimePicker: VIFPicker(),
    toast: VIFToast(),
    loadingIndicator: VIFLoadingIndicator(),
    baseWidgets: VIFBaseWidgets(),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: CoreTheme.lightTheme,
      home: const MyHomePage(title: 'CorePicker Demo'),
      getPages: CorePicker.pageRoutes,
      initialRoute: '/',
      debugShowCheckedModeBanner: false,
      translations: Translator(),
      locale: Get.deviceLocale,
      fallbackLocale: SupportedLocales.defaultLocale,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<void> _onTap1() async {
    final result = await CorePicker.showPickerMenu(
      isShowLog: true,
      attachmentTypes: [
        AttachmentType.media,
      ],
      mediaPickerOption: MediaPickerOption(
        mediaPickerTypes: [
          MediaPickerType.image,
        ],
        isUseCaptionField: false,
      ),
    );
    Logger.logOK("result: $result");
    return;
  }

  Future<void> _onTap2() async {
    final result = await CorePicker.goCamera(logger: true, cameraModes: [
      CameraMode.photo,
    ]);
    Logger.logOK("result: ${result.toString()}");
  }

  List<FeatureItem> get _features => [
        FeatureItem(
          title: "CorePicker",
          description:
              "Tính năng này sẽ hiển thị bottom sheet chứa danh sách các tab, mỗi tab là một loại tệp được chọn,",
          onTap: () => _onTap1(),
        ),
        FeatureItem(
          title: "CameraScreen",
          description:
              "Tính năng này sẽ hiển thị màn hình chụp ảnh, có thể chụp ảnh hoặc quay video, sau khi chụp xong sẽ trả về kết quả.",
          onTap: () => _onTap2(),
        ),
      ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          backgroundColor: Theme.of(context).colorScheme.primary,
          actions: const [
            _LanguageButton(),
          ],
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          child: Container(
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.only(top: 30, left: 16, right: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Danh sách tính năng",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 16),
                TextField(
                  autofocus: false,
                  decoration: InputDecoration(
                    hintText: "Nhập gì đó",
                    hintStyle: Theme.of(context).textTheme.bodyMedium,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    isDense: true,
                  ),
                  onChanged: (value) {},
                ),
                const SizedBox(height: 16),
                Builder(builder: (context) {
                  return ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemBuilder: (context, index) =>
                        FadeSlideTransition(child: _features[index]),
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 16),
                    itemCount: _features.length,
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class FeatureItem extends StatelessWidget {
  const FeatureItem({
    super.key,
    required this.title,
    required this.description,
    required this.onTap,
  });

  final String title;
  final String description;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    ///use Card Material 3
    return Card(
      elevation: 0,
      color: Theme.of(context).colorScheme.surfaceVariant,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                ),
                onPressed: onTap,
                child: Text(
                  "Xem chi tiết",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LanguageButton extends StatelessWidget {
  const _LanguageButton();

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      label: Text(
        Get.locale?.languageCode ?? "vi",
        style: Theme.of(context)
            .textTheme
            .bodyMedium
            ?.copyWith(color: Colors.white),
      ),
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => const _LanguageDialog(),
        );
      },
      icon: const Icon(Icons.language, color: Colors.white),
    );
  }
}

class _LanguageDialog extends StatelessWidget {
  const _LanguageDialog();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("Chọn ngôn ngữ"),
            const SizedBox(height: 16),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: Language.values.map((e) {
                return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                  ),
                  onPressed: () {
                    Get.back();
                    Get.updateLocale(e.locale);
                  },
                  child: Text(
                    e.title,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
