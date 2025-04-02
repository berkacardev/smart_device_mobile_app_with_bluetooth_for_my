import 'package:esp32_bluetooth_project/product/themes/app_colors.dart';
import 'package:esp32_bluetooth_project/product/widgets/dialogs/custom_bluetooth_device_dialog.dart';
import 'package:flutter/material.dart';

class CustomMainAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomMainAppBar({super.key, required this.bodyContext, required this.title});
  final BuildContext bodyContext;
  final String title;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      shadowColor: Colors.transparent,
      iconTheme: IconThemeData(color: AppColors.BLACK),
      title: Text(title, style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700)),
      actions: [
        IconButton(
          icon: Container(decoration: BoxDecoration(color: Colors.black, shape: BoxShape.circle), child: Icon(Icons.add, color: Colors.white)),
          onPressed: () {
            CustomBluetoothDeviceDialog.showDialog(context);
          },
        )
      ],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(MediaQuery.of(bodyContext).viewPadding.top + 36);
}
