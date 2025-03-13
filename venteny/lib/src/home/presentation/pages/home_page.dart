import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:venteny/common/bloc/theme/theme_bloc.dart';
import 'package:venteny/common/common_widget/alert_error.dart';
import 'package:venteny/common/common_widget/alert_loading.dart';
import 'package:venteny/common/common_widget/alert_success.dart';
import 'package:venteny/common/common_widget/custom_button.dart';
import 'package:venteny/core/config/color_app.dart';
import 'package:venteny/core/utils/status_task.dart';
import 'package:venteny/src/home/presentation/bloc/task/delete_task/delete_task_bloc.dart';
import 'package:venteny/src/home/presentation/bloc/task/search/search_bloc.dart';
import 'package:venteny/src/home/presentation/pages/create_update.dart';
import 'package:venteny/src/home/presentation/pages/search_page.dart';
import '../../../../common/bloc/status/status_bloc.dart';
import '../../../../common/common_widget/custom_textfield.dart';
import '../bloc/task/get_taks/get_tasks_bloc.dart';

class HomePage extends StatefulWidget {
  static const String route = "home-page";
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _title = TextEditingController();

  int? _selectedValue;

  final Map<String, int> statusMap = {
    "PENDING": 1,
    "IN PROGRESS": 2,
    "COMPLETED": 3,
  };
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<GetTasksBloc>().add(const GetTasksEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: ColorApp.brand500,
          onPressed: () {
            context.pushNamed(CreateUpdatePage.route);
          },
          child: Icon(
            Icons.add,
            color: ColorApp.white,
          ),
        ),
        appBar: AppBar(
          title: const Text('Home'),
        ),
        body: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BlocBuilder<StatusBloc, StatusState>(
                    builder: (context, state) {
                      return CustomTextFormField(
                        hintText: "Search title",
                        hintStyle: TextStyle(
                            color: ColorApp.slate400,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                        controller: _title,
                        onChanged: (v) {
                          // setState(() {
                          //   _title.text = v;
                          // });
                          context
                              .read<SearchBloc>()
                              .add(SearchEvent(title: v, status: state.id));
                        },
                      );
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BlocBuilder<StatusBloc, StatusState>(
                        builder: (context, state) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              DropdownButton<int>(
                                value: state.id,
                                hint: Text("Filter as status"),
                                items: statusMap.entries.map((entry) {
                                  return DropdownMenuItem<int>(
                                    value: entry.value, // Ambil angka dari Map
                                    child: Text(entry
                                        .key), // Ambil nama status dari Map
                                  );
                                }).toList(),
                                onChanged: (int? newValue) {
                                  if (newValue != null) {
                                    context
                                        .read<StatusBloc>()
                                        .add(StatusEvent(status: newValue));
                                    context.read<SearchBloc>().add(SearchEvent(
                                        status: newValue, title: _title.text));
                                  }
                                },
                              ),
                              context.watch<StatusBloc>().state.id != null
                                  ? CustomButton(
                                    onPressed: (){
                                      context.read<StatusBloc>().add(StatusEvent(status: null));
                                      context.read<SearchBloc>().add(SearchEvent(title: _title.text));
                                    },
                                    title: "Reset Status", fontSize: 10,colorTitle: ColorApp.black,width: 100,height: 30,borderColor: ColorApp.black,borderRadius: 5,widthBorder: 0.3,)
                                  : SizedBox()
                            ],
                          );
                        },
                      ),
                      BlocBuilder<ThemeBloc, ThemeState>(
                        builder: (context, state) {
                          return IconButton(
                              onPressed: () async {
                                context.read<ThemeBloc>().add(ThemeEvent());
                              },
                              icon: state.isModeDark
                                  ? Icon(Icons.toggle_on_outlined)
                                  : Icon(Icons.toggle_off_outlined));
                        },
                      )
                    ],
                  )
                ],
              ),
            ),
            context.watch<SearchBloc>().state.title.isNotEmpty ||
                    context.watch<StatusBloc>().state.id != null
                ? Expanded(
                    child: BlocBuilder<SearchBloc, SearchState>(
                      builder: (context, state) {
                        if (state.status == StatusSearch.success) {
                          if (state.taskEntity.isEmpty) {
                            return Center(
                              child: Text('Task not found'),
                            );
                          }
                          return ListView.builder(
                            itemCount: state.taskEntity.length,
                            itemBuilder: (BuildContext context, int index) {
                              final item = state.taskEntity[index];

                              return InkWell(
                                  onTap: () {
                                    context.pushNamed(CreateUpdatePage.route,
                                        extra: state.taskEntity[index]);
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 10),
                                    child: ListTile(
                                      shape: RoundedRectangleBorder(
                                        side: const BorderSide(
                                            color: Colors.blue, width: 1),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      title: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            item.title,
                                            style:
                                                const TextStyle(fontSize: 20),
                                          ),
                                          Text(
                                            StatusTask.statusTask(
                                                status: item.status),
                                            style: TextStyle(
                                                color:
                                                    StatusTask.colorStatusTask(
                                                        status: item.status)),
                                          )
                                        ],
                                      ),
                                      subtitle: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("${item.description}"),
                                          Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text("Date : ${item.dueDate}"),
                                              const SizedBox(width: 3),
                                            ],
                                          ),
                                          Text("Time: ${item.dueDate}"),
                                        ],
                                      ),
                                      trailing: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Expanded(
                                            child: InkWell(
                                                onTap: () {
                                                  context.pushNamed(
                                                      "create-update-page",
                                                      extra: state
                                                          .taskEntity[index]);
                                                },
                                                child: const Icon(Icons.edit)),
                                          ),
                                          const SizedBox(height: 20),
                                          BlocListener<DeleteTaskBloc,
                                              DeleteTaskState>(
                                            listener: (context, state) {
                                              // TODO: implement listener
                                              if (state.status ==
                                                  StatusDelete.loading) {
                                                AlertLoading.show(
                                                    context, "Please wait");
                                              } else if (state.status ==
                                                  StatusDelete.success) {
                                                AlertLoading.hide(context);
                                                AlertSuccess.show(
                                                    context, "Success Deleted");
                                                context
                                                    .read<GetTasksBloc>()
                                                    .add(const GetTasksEvent());
                                              } else if (state.status ==
                                                  StatusDelete.failure) {
                                                AlertError.show(
                                                    context, "failure");
                                              }
                                            },
                                            child: Expanded(
                                              child: InkWell(
                                                  onTap: () {
                                                    context
                                                        .read<DeleteTaskBloc>()
                                                        .add(DeleteTaskEvent(
                                                            id: state
                                                                .taskEntity[
                                                                    index]
                                                                .id));
                                                  },
                                                  child:
                                                      const Icon(Icons.delete)),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ));
                            },
                          );
                        } else if (state.status == StatusSearch.loading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (state.status == StatusSearch.failure) {
                          return const Center(
                            child: Text("Failure"),
                          );
                        } else {
                          return Container();
                        }
                      },
                    ),
                  )
                : Expanded(
                    child: BlocBuilder<GetTasksBloc, GetTasksState>(
                      builder: (context, state) {
                        if (state.status == StatusGetTasks.success) {
                          if (state.taskEntity.isEmpty) {
                            return Center(
                              child: Text("Create your first task"),
                            );
                          }
                          return ListView.builder(
                            itemCount: state.taskEntity.length,
                            itemBuilder: (BuildContext context, int index) {
                              final item = state.taskEntity[index];
                              return InkWell(
                                  onTap: () {
                                    context.pushNamed(CreateUpdatePage.route,
                                        extra: state.taskEntity[index]);
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 10),
                                    child: ListTile(
                                      shape: RoundedRectangleBorder(
                                        side: const BorderSide(
                                            color: Colors.blue, width: 1),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      title: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            item.title,
                                            style:
                                                const TextStyle(fontSize: 20),
                                          ),
                                          Text(
                                            StatusTask.statusTask(
                                                status: item.status),
                                            style: TextStyle(
                                                color:
                                                    StatusTask.colorStatusTask(
                                                        status: item.status)),
                                          )
                                        ],
                                      ),
                                      subtitle: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("${item.description}"),
                                          Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text("Date : ${item.dueDate}"),
                                              const SizedBox(width: 3),
                                            ],
                                          ),
                                          Text("Time: ${item.dueDate}"),
                                        ],
                                      ),
                                      trailing: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Expanded(
                                            child: InkWell(
                                                onTap: () {
                                                  context.pushNamed(
                                                      CreateUpdatePage.route,
                                                      extra: state
                                                          .taskEntity[index]);
                                                },
                                                child: const Icon(Icons.edit)),
                                          ),
                                          const SizedBox(height: 20),
                                          BlocListener<DeleteTaskBloc,
                                              DeleteTaskState>(
                                            listener: (context, state) {
                                              // TODO: implement listener
                                              if (state.status ==
                                                  StatusDelete.loading) {
                                                AlertLoading.show(
                                                    context, "Please wait");
                                              } else if (state.status ==
                                                  StatusDelete.success) {
                                                AlertLoading.hide(context);
                                                AlertSuccess.show(
                                                    context, "Success Deleted");
                                                context
                                                    .read<GetTasksBloc>()
                                                    .add(const GetTasksEvent());
                                              } else if (state.status ==
                                                  StatusDelete.failure) {
                                                AlertError.show(
                                                    context, "failure");
                                              }
                                            },
                                            child: Expanded(
                                              child: InkWell(
                                                  onTap: () {
                                                    context
                                                        .read<DeleteTaskBloc>()
                                                        .add(DeleteTaskEvent(
                                                            id: state
                                                                .taskEntity[
                                                                    index]
                                                                .id));
                                                  },
                                                  child:
                                                      const Icon(Icons.delete)),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ));
                            },
                          );
                        } else if (state.status == StatusGetTasks.loading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (state.status == StatusGetTasks.failure) {
                          return const Center(
                            child: Text("Failure"),
                          );
                        } else {
                          return Container();
                        }
                      },
                    ),
                  ),
          ],
        ));
  }
}
