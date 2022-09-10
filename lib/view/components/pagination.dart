import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_company/model/university.dart';
import 'package:task_company/view/widget/text_field.dart';
import 'package:task_company/view/widget/unviresity.dart';

import '../../controller/providers.dart';

class PaginationUnversity extends ConsumerWidget {
  PaginationUnversity({Key? key}) : super(key: key);
  int page = 0;
  TextEditingController textFillterController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final streamAsyncValue = ref.watch(universitys);
    final pagePagination = ref.watch(pageinPaginationUnversity);
    final pagesFillter = ref.watch(filtterPageinPaginationUnversity);
    final refreshPagination = ref.watch(updatePagination);
    return streamAsyncValue.when(
      data: (item) {
        ScrollController _scrollController = ScrollController();
        int mainLength =
            pagesFillter.isEmpty ? item.length : pagesFillter.length;

        int lenght = mainLength >= 20
            ? ((pagePagination * 15) +
                (min(15, mainLength - (pagePagination * 15))))
            : mainLength;

        return Column(
          children: [
            TitleWithField(
              validator: null,
              textController: textFillterController,
              title: 'Enter text to filtter result ',
              widthTitle: 160,
              textInputType: TextInputType.text,
              disableMaxLen: true,
              formater: [],
              onChange: (value) {
                if (value != null) {
                  if (value.isEmpty) {
                    ref
                        .refresh(filtterPageinPaginationUnversity.notifier)
                        .state
                        .clear();
                    ref.read(pageinPaginationUnversity.notifier).state = 0;
                    print("object");
                  } else {
                    List<University> _unv = [];
                    for (var element in item) {
                      if (element.name
                          .toLowerCase()
                          .contains(value.toLowerCase())) {
                        _unv.add(element);
                      }
                    }
                    ref
                        .refresh(filtterPageinPaginationUnversity.notifier)
                        .state = List.from(_unv);
                    ref.read(pageinPaginationUnversity.notifier).state = 0;
                  }
                }
              },
            ),
            Expanded(
              child: NotificationListener<ScrollUpdateNotification>(
                child: ListView.builder(
                  controller: _scrollController,
                  // gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  //   childAspectRatio: 5 / 3,
                  //   maxCrossAxisExtent: 200,
                  //   crossAxisSpacing: 10,
                  // ),
                  itemCount: lenght,
                  itemBuilder: (_, index) {
                    return Center(
                      child: CardUnversity(
                        changSave: (value) {
                          bool temp = refreshPagination;
                          ref.read(updatePagination.notifier).state = true;
                          Timer(const Duration(milliseconds: 10), () {
                            ref.read(updatePagination.notifier).state = temp;
                          });
                        },
                        university: pagesFillter.isEmpty
                            ? item.elementAt(index)
                            : pagesFillter.elementAt(index),
                      ),
                    );
                  },
                ),
                onNotification: (t) {
                  if (t.metrics.extentAfter == 0) {
                    if (lenght != item.length) {
                      ref.read(updatePagination.notifier).state = true;
                      Timer(const Duration(milliseconds: 500), () {
                        ref.read(updatePagination.notifier).state = false;
                        ref.read(pageinPaginationUnversity.notifier).state++;
                      });
                    }
                  }

                  return false;
                },
              ),
            ),
            Visibility(
                visible: refreshPagination,
                child: const CircularProgressIndicator()),
          ],
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, st) => Center(child: Text(e.toString())),
    );
  }
}
