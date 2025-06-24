import 'package:flutter/material.dart';
import 'package:flutter_getx_base/app/core/theme/app_colors.dart';
import 'package:flutter_getx_base/app/core/theme/app_size.dart';
import 'package:flutter_getx_base/app/core/theme/text_styles.dart';
import 'package:flutter_getx_base/app/data/enum/user.enum.dart';
import 'package:flutter_getx_base/generated/locales.g.dart';
import 'package:get/get.dart';

class RoleOptionWidget extends StatefulWidget {
  final String roleSelected;
  final Function onChanged;

  const RoleOptionWidget(
      {super.key, required this.roleSelected, required this.onChanged});

  @override
  RoleOptionWidgetState createState() => RoleOptionWidgetState();
}

class RoleOptionWidgetState extends State<RoleOptionWidget> {
  late String _roleSelected;

  @override
  void initState() {
    super.initState();
    _roleSelected =
        widget.roleSelected; // Initialize with the provided selected role
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.kDark3, width: 0.5),
        borderRadius: BorderRadius.circular(AppSize.kRadius12),
      ),
      child: Stack(
        children: [
          AnimatedPositioned(
            left: _roleSelected == RoleEnum.user
                ? 0
                : MediaQuery.of(context).size.width / 2 - 30,
            right: _roleSelected == RoleEnum.admin
                ? 0
                : MediaQuery.of(context).size.width / 2 - 30,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            child: Container(
              width: MediaQuery.of(context).size.width / 2 - 10,
              height: 40, // Add a fixed height here
              decoration: BoxDecoration(
                color: AppColors.kBlue5,
                borderRadius: BorderRadius.circular(AppSize.kRadius12),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildButton(LocaleKeys.register_user.tr, RoleEnum.user,
                  _roleSelected == RoleEnum.user),
              _buildButton(LocaleKeys.register_store_owner.tr, RoleEnum.admin,
                  _roleSelected == RoleEnum.admin),
            ],
          ),
        ],
      ),
    );
  }

  Expanded _buildButton(
    String text,
    String userRole,
    bool isSelected,
  ) {
    return Expanded(
      child: GestureDetector(
        onTap: () => _onRoleChanged(userRole),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSize.kSpacing16,
            vertical: AppSize.kSpacing10,
          ),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(AppSize.kRadius12),
          ),
          alignment: Alignment.center,
          child: Text(
            text,
            style: AppStyles.button16.copyWith(
              color: isSelected ? AppColors.kWhite : AppColors.kDark6,
            ),
          ),
        ),
      ),
    );
  }

  void _onRoleChanged(String newRole) {
    setState(() {
      _roleSelected = newRole;
    });
    widget.onChanged(newRole); // Call the onChanged callback
  }
}
