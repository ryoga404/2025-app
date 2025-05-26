import 'package:flutter/material.dart';
import 'package:mark_and_check/go_router/app_router.dart';

class MarkModeSelectView extends StatelessWidget {
  const MarkModeSelectView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Select Mark Mode')),
      body: Center(
        child: Padding(
          //TODO 個別のPadding
          padding: EdgeInsets.all(20),
          child: Column(
            spacing: 12,
            children: [
              SizedBox(//TODO 個別のSizedBox
                width: double.infinity,
                child: FilledButton(
                  onPressed: () => AppRouter.toCreateMarkSheet(context),
                  child:
                  const Text('Create Mark Sheet',),
                ),
              ),
              SizedBox(//TODO　個別のSizedBox
                width: double.infinity,
                child: FilledButton(
                  onPressed: () => AppRouter.toCreateMarkSheet(context),
                  child: const Text('Select Free Mode'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
