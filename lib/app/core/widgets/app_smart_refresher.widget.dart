import 'package:flutter/widgets.dart';
import 'package:flutter_getx_base/app/core/theme/app_colors.dart';
import 'package:flutter_getx_base/app/core/theme/text_styles.dart';
import 'package:flutter_getx_base/generated/locales.g.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class AppSmartRefresherWidget extends StatelessWidget {
  final bool enablePullDown;
  final bool enablePullUp;
  final RefreshController refreshController;
  final Widget child;
  final Function() onRefresh;
  final Function() onLoading;
  const AppSmartRefresherWidget({
    super.key,
    this.enablePullUp = true,
    this.enablePullDown = true,
    required this.refreshController,
    required this.onRefresh,
    required this.onLoading,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      enablePullDown: enablePullDown,
      enablePullUp: enablePullUp,
      header: _buildWaterDropHeader(),
      footer: _buildCustomFooter(),
      controller: refreshController,
      onRefresh: onRefresh,
      onLoading: onLoading,
      child: child,
    );
  }

  WaterDropHeader _buildWaterDropHeader() {
    return WaterDropHeader(
      refresh: _buildText(LocaleKeys.texts_refreshing.tr),
      complete: _buildText(LocaleKeys.texts_refresh_completed.tr),
    );
  }

  CustomFooter _buildCustomFooter() {
    return CustomFooter(
      builder: (BuildContext context, LoadStatus? mode) {
        Widget body;
        if (mode == LoadStatus.idle) {
          body = _buildText(LocaleKeys.texts_pull_up_load_more.tr);
        } else if (mode == LoadStatus.loading) {
          body = _buildText(LocaleKeys.texts_loading.tr);
        } else if (mode == LoadStatus.failed) {
          body = _buildText(LocaleKeys.texts_load_failed.tr);
        } else if (mode == LoadStatus.canLoading) {
          body = _buildText(LocaleKeys.texts_release_to_load_more.tr);
        } else {
          body = _buildText(LocaleKeys.texts_no_more_data.tr);
        }
        return SizedBox(
          height: 20.0,
          child: Center(child: body),
        );
      },
    );
  }

  Widget _buildText(String value) {
    return Text(
      value,
      style: AppStyles.body14.copyWith(
        color: AppColors.kDark6,
      ),
    );
  }
}
