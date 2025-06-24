import 'package:flutter/material.dart' hide CarouselController;
import 'package:flutter_getx_base/app/core/di/di.dart';
import 'package:flutter_getx_base/app/core/theme/app_colors.dart';
import 'package:flutter_getx_base/app/core/theme/app_size.dart';
import 'package:flutter_getx_base/app/core/utils/size_config.dart';
import 'package:flutter_getx_base/app/core/widgets/app_smart_refresher.widget.dart';
import 'package:flutter_getx_base/app/core/widgets/app_text_form_field.widget.dart';
import 'package:flutter_getx_base/app/core/widgets/image_view.widget.dart';
import 'package:flutter_getx_base/app/core/widgets/message.util.dart';
import 'package:flutter_getx_base/app/core/widgets/shimmer_loading.widget.dart';
import 'package:flutter_getx_base/app/data/repository/app_setting.repository.dart';
import 'package:flutter_getx_base/generated/locales.g.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class UnPlashImagePickerWidget extends StatefulWidget {
  final Function onChoose;
  const UnPlashImagePickerWidget({super.key, required this.onChoose});

  @override
  State<UnPlashImagePickerWidget> createState() =>
      _UnPlashImagePickerWidgetState();
}

class _UnPlashImagePickerWidgetState extends State<UnPlashImagePickerWidget> {
  final AppSettingRepository appSettingRepository =
      getIt<AppSettingRepository>();
  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  TextEditingController query = TextEditingController();
  int page = 1;
  int perPage = 100;
  List<String> photos = [];
  bool isLoading = true;

  @override
  void initState() {
    getUnPlashImages();
    super.initState();
  }

  @override
  void dispose() {
    refreshController.dispose();
    super.dispose();
  }

  Future<void> getUnPlashImages() async {
    isLoading = true;
    final response = await appSettingRepository.getUnPlashImages(
        query.text.trim(), page, perPage);
    isLoading = false;
    response.fold(
      (failed) {
        showSnackBarError(message: failed.message);
      },
      (result) {
        setState(() {
          photos.addAll(result);
        });
      },
    );
    refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        _buildSearch(),
        Expanded(
          child: _buildSmartRefresher(),
        ),
      ],
    ));
  }

  AppSmartRefresherWidget _buildSmartRefresher() {
    return AppSmartRefresherWidget(
      refreshController: refreshController,
      onRefresh: () {
        refreshController.refreshCompleted();
      },
      onLoading: _onLoading,
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: SizeConfig.isTablet ? 4 : 3,
          mainAxisSpacing: 4.0,
          crossAxisSpacing: 4.0,
        ),
        itemCount: photos.length + 8,
        itemBuilder: (context, index) {
          if (index < photos.length) {
            return GestureDetector(
              onTap: () {
                widget.onChoose(photos[index]);
                Get.back();
              },
              child: GridTile(
                child: ImageViewWidget(
                  photos[index],
                  fit: BoxFit.cover,
                ),
              ),
            );
          } else {
            if (isLoading) {
              return const ShimmerLoading(
                width: double.infinity,
                height: double.infinity,
              );
            }
          }
          return null;
        },
        physics: const AlwaysScrollableScrollPhysics(),
      ),
    );
  }

  Widget _buildSearch() {
    return Container(
      margin: const EdgeInsets.only(
        bottom: AppSize.kSpacing4,
        left: AppSize.kHorizontalSpace,
        right: AppSize.kHorizontalSpace,
      ),
      child: TextFieldWidget(
        controller: query,
        hintText: LocaleKeys.texts_search_hint.tr,
        textInputAction: TextInputAction.done,
        suffixIcon: const Icon(
          Icons.search_rounded,
          color: AppColors.kDark3,
        ),
        onFieldSubmitted: (value) async {
          page = 1;
          photos.clear();
          getUnPlashImages();
          await _onLoading();
        },
      ),
    );
  }

  Future<void> _onLoading() async {
    page++;
    await getUnPlashImages();
  }
}
