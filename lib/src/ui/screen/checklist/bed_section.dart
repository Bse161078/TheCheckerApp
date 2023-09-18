import 'dart:io';

import 'package:checkerapp/src/controllers/checklist_controller.dart';
import 'package:checkerapp/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../widget/answer_yes_no_widget.dart';
import '../../widget/checker.dart';
import '../../widget/tap_widget.dart';
import 'widgets/add_photos_view.dart';

class BedSection extends GetView<CheckListController> {
  TextEditingController controllerReport = TextEditingController();

  BedSection({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<CheckListController>(initState: (_) {
      controllerReport.text = controller.bedDamageReport.value;
    }, builder: (_) {
      if (controllerReport.text.isEmpty) {
        controllerReport.text = controller.bedDamageReport.value;
      }
      _.isLoading;
      return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'bed'.tr,
              style: Get.textTheme.titleMedium,
            ).setStyle(size: 18, weight: FontWeight.bold),
            16.ph,
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 110,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Get.theme.splashColor,
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'is_bed_made_up'.tr,
                          style: Get.textTheme.titleMedium,
                        ).setStyle(size: 16),
                        10.ph,
                        AnswerYesNoWidget(
                            state: controller.bedIsMadeUp.value,
                            onChangeValue: (newState) =>
                                controller.bedIsMadeUp.value = newState)
                      ],
                    ),
                  ),
                ),
                16.pw,
                Tap(
                  onTap: () async {
                    final XFile? photo = await ImagePicker()
                        .pickImage(source: ImageSource.gallery);
                    if (photo == null) {
                      return;
                    }
                    _.bedIsMadeUpPhoto.add(photo.path);
                  },
                  child: Container(
                    child: _.bedIsMadeUpPhoto.isNotEmpty
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.file(
                              File(_.bedIsMadeUpPhoto.last),
                              width: 170,
                              height: 110,
                              fit: BoxFit.cover,
                            ))
                        : Container(
                            width: 170,
                            height: 110,
                            decoration: BoxDecoration(
                                color: Get.theme.splashColor,
                                borderRadius: BorderRadius.circular(8)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.photo,
                                  color: Get.theme.primaryColor,
                                  size: 30,
                                ),
                                8.ph,
                                Text('add_photos'.tr)
                                    .setStyle(color: Colors.white, size: 16)
                              ],
                            ),
                          ),
                  ),
                )
              ],
            ),
            22.ph,
            Text(
              'comments'.tr,
              style: Get.textTheme.titleMedium,
            ).setStyle(size: 14),
            8.ph,
            Container(
              // height: 110,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Get.theme.splashColor,
              ),
              // padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Checker(
                        label: 'bed_not_fresh'.tr,
                        state: controller.bedNotFresh.value,
                        type: CheckerType.Check,
                        onChanged: (newValue) =>
                            controller.bedNotFresh.value = newValue,
                      ),
                      AddPhotosView(
                          onSelectPhoto: (photoPath) {
                            _.bedNotFreshPhoto.add(photoPath);
                            _.isLoading = true;
                            _.isLoading = false;
                          },
                          photos: _.bedNotFreshPhoto),
                    ],
                  ).paddingOnly(top: 6, bottom: 4),
                  const Divider(
                    height: 4,
                  ).paddingSymmetric(horizontal: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Checker(
                          label: 'bed_not_tightened'.tr,
                          state: controller.bedNotTightened.value,
                          type: CheckerType.Check,
                          onChanged: (newValue) =>
                              controller.bedNotTightened.value = newValue),
                      AddPhotosView(
                          onSelectPhoto: (photoPath) {
                            _.bedNotTightenedPhoto.add(photoPath);
                            _.isLoading = true;
                            _.isLoading = false;
                          },
                          photos: _.bedNotTightenedPhoto),
                    ],
                  ).paddingOnly(top: 6, bottom: 4),
                  const Divider(
                    height: 4,
                  ).paddingSymmetric(horizontal: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Checker(
                          label: 'extra_bed_status'.tr,
                          state: controller.bedExtraBed.value,
                          type: CheckerType.Check,
                          onChanged: (newValue) =>
                              controller.bedExtraBed.value = newValue),
                      AddPhotosView(
                          onSelectPhoto: (photoPath) {
                            _.bedExtraBedPhoto.add(photoPath);
                            _.isLoading = true;
                            _.isLoading = false;
                          },
                          photos: _.bedExtraBedPhoto),
                    ],
                  ).paddingOnly(top: 6, bottom: 4),
                ],
              ),
            ),
            22.ph,
            Text(
              'damage_report'.tr,
              style: Get.textTheme.titleMedium,
            ).setStyle(size: 14),
            8.ph,
            Container(
              // height: 130,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Get.theme.splashColor,
              ),
              // padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    textInputAction: TextInputAction.newline,
                    controller: controllerReport,
                    textAlign: TextAlign.left,
                    onChanged: (t) {
                      controller.bedDamageReport.value = t;
                    },
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.transparent,
                      counterText: "",
                      contentPadding: const EdgeInsets.only(
                        left: 16,
                        right: 16,
                        top: 12,
                        bottom: 0,
                      ),
                      hintText: 'enter_additional_report'.tr,
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      hintStyle: TextStyle(
                          fontWeight: FontWeight.w300,
                          color: Get.theme.hintColor,
                          fontSize: 14),
                    ),
                    maxLines: 4,
                    keyboardType: TextInputType.multiline,
                    maxLength: 500,
                  ),
                  6.ph,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      AddPhotosView(
                          onSelectPhoto: (photoPath) {
                            _.bedDamageReportPhoto.add(photoPath);
                            _.isLoading = true;
                            _.isLoading = false;
                          },
                          photos: _.bedDamageReportPhoto),
                    ],
                  ),
                  6.ph,
                ],
              ),
            ),
            68.ph,
          ],
        ).paddingOnly(left: 22, right: 22, top: 22),
      );
    });
  }
}
