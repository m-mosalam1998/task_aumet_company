import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_company/controller/providers.dart';
import 'package:task_company/global/colors.dart';

class UserPic extends ConsumerWidget {
  const UserPic({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pic = ref.watch(userPictureProvider);

    return CircleAvatar(
      maxRadius: 50,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          border: Border.all(
            color: AppColors.textAndIconColor,
          ),
          image: pic != null ? DecorationImage(image: MemoryImage(pic)) : null,
        ),
        child: Align(
          alignment: Alignment.bottomRight,
          child: IconButton(
              onPressed: () async {
                final result = await FilePicker.platform.pickFiles(
                  allowMultiple: false,
                  type: FileType.image,
                );

                if (result != null) {
                  ref.watch(userPictureProvider.notifier).state =
                      result.files.first.bytes;
                }
              },
              icon: Icon(
                Icons.add_a_photo,
                color: AppColors.textAndIconColor,
              )),
        ),
      ),
    );
  }
}
