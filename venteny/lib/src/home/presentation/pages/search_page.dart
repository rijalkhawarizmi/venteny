import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../common/common_widget/alert_error.dart';
import '../../../../common/common_widget/alert_loading.dart';
import '../../../../common/common_widget/alert_success.dart';
import '../../../../common/common_widget/custom_textfield.dart';
import '../../../../core/config/color_app.dart';
import '../../../../core/utils/status_task.dart';
import '../bloc/task/delete_task/delete_task_bloc.dart';
import '../bloc/task/get_taks/get_tasks_bloc.dart';
import '../bloc/task/search/search_bloc.dart';
import 'create_update.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});
  static const String route="search-page";

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
   final _title = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<GetTasksBloc>().add(const GetTasksEvent());
  }

  final Map<String, int> statusMap = {
    "PENDING": 1,
    "IN PROGRESS": 2,
    "COMPLETED": 3,
  };

  int? _selectedValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search page"),
      ),
      body: Container(
        margin: EdgeInsets.fromLTRB(10, 40, 10, 0),
        child: Column(
          children: [
            Container(
                margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextFormField(
                      hintText: "Search title",
                      hintStyle: TextStyle(
                          color: ColorApp.slate400,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                      controller: _title,
                      onChanged: (v) {
                        setState(() {
                          _title.text = v;
                        });
                        context
                            .read<SearchBloc>()
                            .add(SearchEvent(title: v, status: _selectedValue));
                      },
                    ),
                    DropdownButton<int>(
                      value: _selectedValue,
                      hint: Text("Filter as status"),
                      items: statusMap.entries.map((entry) {
                        return DropdownMenuItem<int>(
                          value: entry.value, // Ambil angka dari Map
                          child: Text(entry.key), // Ambil nama status dari Map
                        );
                      }).toList(),
                      onChanged: (int? newValue) {
                        if (newValue != null) {
                          setState(() {
                            _selectedValue = newValue;
                            context.read<SearchBloc>().add(SearchEvent(
                                title: _title.text, status: _selectedValue));
                          });
                        }
                      },
                    ),
                  ],
                ),
              ),
            
          ],
        ),
      ),
    );
  }
}
