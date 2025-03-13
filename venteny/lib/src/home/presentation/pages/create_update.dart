import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:venteny/common/bloc/date/date_bloc.dart';
import 'package:venteny/common/common_widget/alert_error.dart';
import 'package:venteny/common/common_widget/alert_loading.dart';
import 'package:venteny/common/common_widget/alert_success.dart';
import 'package:venteny/common/common_widget/custom_button.dart';
import 'package:venteny/core/utils/notification_api.dart';
import 'package:venteny/core/utils/status_task.dart';
import 'package:venteny/src/home/domain/entities/home_entity.dart';
import 'package:venteny/src/home/presentation/bloc/task/create_task/create_task_bloc.dart';
import 'package:venteny/src/home/presentation/bloc/task/get_taks/get_tasks_bloc.dart';
import 'package:venteny/src/home/presentation/pages/home_page.dart';

import '../../../../common/bloc/status/status_bloc.dart';
import '../../../../common/common_widget/custom_textfield.dart';
import '../../../../core/config/color_app.dart';
import '../bloc/task/update_task/update_task_bloc.dart';

class CreateUpdatePage extends StatefulWidget {
  static const String route = "create-update-page";
  CreateUpdatePage({super.key, this.taskEntity});
  final TaskEntity? taskEntity;

  @override
  State<CreateUpdatePage> createState() => _CreateUpdatePageState();
}

class _CreateUpdatePageState extends State<CreateUpdatePage> {
  final _key = GlobalKey<FormState>();

  final Map<String, int> statusMap = {
    "PENDING": 1,
    "IN PROGRESS": 2,
    "COMPLETED": 3,
  };

  int? _selectedValue;

  late TextEditingController _title = TextEditingController();

  late TextEditingController _desc = TextEditingController();

  late TextEditingController _dueDate = TextEditingController();

  Future<DateTime?> showDateTimePicker({
    required BuildContext context,
    DateTime? initialDate,
    DateTime? firstDate,
    DateTime? lastDate,
  }) async {
    initialDate ??= DateTime.now();
    firstDate ??= initialDate.subtract(const Duration(days: 365 * 100));
    lastDate ??= firstDate.add(const Duration(days: 365 * 200));

    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );

    if (selectedDate == null) return null;

    if (!context.mounted) return selectedDate;

    final TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(initialDate),
    );

    return selectedTime == null
        ? selectedDate
        : DateTime(
            selectedDate.year,
            selectedDate.month,
            selectedDate.day,
            selectedTime.hour,
            selectedTime.minute,
          );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.taskEntity?.id != null) {
      _title = TextEditingController(text: widget.taskEntity?.title);
      _desc = TextEditingController(
          text: widget.taskEntity?.description ?? _desc.text);
      _dueDate = TextEditingController(text: widget.taskEntity?.dueDate ?? "");
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _title.dispose();
    _desc.dispose();
    _dueDate.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _key,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.taskEntity?.id != null
              ? "Update Task Page"
              : "Create Task Page"),
        ),
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomTextFormField(
                hintText: "Title",
                hintStyle: TextStyle(
                    color: ColorApp.slate400,
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
                controller: _title,
                validator: (String? v) {
                  if (v == null || v.isEmpty) {
                    return "Title cannot be empty";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 10,
              ),
              CustomTextFormField(
                hintText: "Description",
                hintStyle: TextStyle(
                    color: ColorApp.slate400,
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
                controller: _desc,
                validator: (String? v) {
                  if (v == null || v.isEmpty) {
                    return "Desription cannot be empty";
                  }
                  return null;
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () async {
                      DateTime? date =
                          await showDateTimePicker(context: context);
                      context
                          .read<DateBloc>()
                          .add(DateEvent(date: date ?? DateTime.now()));
                      await initializeDateFormatting('id_ID', null);
                      _dueDate.text = DateFormat("EE, d MMMM yyyy HH:mm")
                          .format(date ?? DateTime.now());
                    },
                    child: Row(
                      children: [
                        Icon(Icons.date_range_outlined),
                        BlocBuilder<DateBloc, DateState>(
                          builder: (context, state) {
                            return Text(
                              _dueDate.text.isNotEmpty
                                  ? _dueDate.text
                                  : widget.taskEntity?.id != null
                                      ? widget.taskEntity!.dueDate
                                      : "Choose Date",
                              style: TextStyle(fontSize: 15),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  BlocBuilder<StatusBloc, StatusState>(
                    builder: (context, state) {
                      return DropdownButton<int>(
                        value: state.id == null ? state.id : state.id,
                        hint: widget.taskEntity?.status != null
                            ? Text(StatusTask.statusTask(
                                status: widget.taskEntity!.status))
                            : Text("Pilih Status"),
                        items: statusMap.entries.map((entry) {
                          return DropdownMenuItem<int>(
                            value: entry.key.isNotEmpty
                                ? entry.value
                                : widget
                                    .taskEntity?.status, // Ambil angka dari Map
                            child:
                                Text(entry.key), // Ambil nama status dari Map
                          );
                        }).toList(),
                        onChanged: (int? newValue) {
                          if (newValue != null) {
                            context
                                .read<StatusBloc>()
                                .add(StatusEvent(status: newValue));
                          }
                        },
                      );
                    },
                  ),
                ],
              ),
              widget.taskEntity?.id != null
                  ? BlocListener<UpdateTaskBloc, UpdateTaskState>(
                      listener: (context, state) {
                        // TODO: implement listener
                        if (state.status == StatusUpdate.loading) {
                          AlertLoading.show(context, "Please wait");
                        } else if (state.status == StatusUpdate.success) {
                          AlertLoading.hide(context);
                          AlertSuccess.show(context, "Success Update");
                          context.read<StatusBloc>().add(StatusEvent(status: null));
                          context
                              .read<GetTasksBloc>()
                              .add(const GetTasksEvent());
                          context.goNamed(HomePage.route);
                        } else if (state.status == StatusUpdate.failure) {
                          AlertLoading.hide(context);
                          AlertError.show(context, "Failure");
                        }
                      },
                      child: BlocBuilder<DateBloc, DateState>(
                        builder: (context, stateDate) {
                          return CustomButton(
                              onPressed: () async {
                               
                                 if(stateDate.date != null){
                                   await NotificationApi
                                        .showScheduledNotification(
                                            id: UniqueKey().hashCode,
                                            body: "DON'T FORGET YOUR TASK",
                                            title: "Hello",
                                            hour: stateDate.date?.hour,
                                            minutes: stateDate.date!.minute-5,
                                            date: stateDate.date?.day,
                                            month: stateDate.date?.month,
                                            year: stateDate.date?.year);
                                 }
                                TaskEntity taskEntity = TaskEntity(
                                    id: widget.taskEntity!.id,
                                    title: _title.text,
                                    description: _desc.text,
                                    dueDate: _dueDate.text,
                                    status:
                                        context.read<StatusBloc>().state.id ??
                                            widget.taskEntity!.status);
                                context.read<UpdateTaskBloc>().add(
                                    UpdateTaskEvent(taskEntity: taskEntity));
                              },
                              title: "Update Task",
                              fontSize: 16,
                              backgroundColor: ColorApp.brand500,
                              colorTitle: ColorApp.white,
                              fontWeight: FontWeight.w500);
                        },
                      ),
                    )
                  : BlocListener<CreateTaskBloc, CreateTaskState>(
                      listener: (context, state) {
                        // TODO: implement listener
                        if (state.status == StatusCreate.loading) {
                          AlertLoading.show(context, "Please wait");
                        } else if (state.status == StatusCreate.success) {
                          AlertLoading.hide(context);
                          AlertSuccess.show(context, "Success");
                          context
                              .read<GetTasksBloc>()
                              .add(const GetTasksEvent());
                          context.read<StatusBloc>().add(StatusEvent(status: null));
                          context.pop();
                        } else if (state.status == StatusCreate.failure) {
                          AlertLoading.hide(context);
                          AlertError.show(context, "Failure");
                        }
                      },
                      child: BlocBuilder<DateBloc, DateState>(
                        builder: (context, stateDate) {
                          return CustomButton(
                              onPressed: () async {
                                if (_key.currentState!.validate()) {
                                  _key.currentState!.save();
                                  if (_dueDate.text.isNotEmpty &&
                                      _title.text.isNotEmpty &&
                                      context.read<StatusBloc>().state.id !=
                                          null) {
                                    await NotificationApi
                                        .showScheduledNotification(
                                            id: UniqueKey().hashCode,
                                            body: "DON'T FORGET YOUR TASK",
                                            title: "Hello",
                                            hour: stateDate.date?.hour,
                                            minutes: stateDate.date!.minute-5,
                                            date: stateDate.date?.day,
                                            month: stateDate.date?.month,
                                            year: stateDate.date?.year);
                                    TaskEntity taskEntity = TaskEntity(
                                        id: UniqueKey().hashCode,
                                        title: _title.text,
                                        description: _desc.text,
                                        dueDate: _dueDate.text,
                                        status: context
                                            .read<StatusBloc>()
                                            .state
                                            .id!);
                                    context.read<CreateTaskBloc>().add(
                                        CreateTaskEvent(
                                            taskEntity: taskEntity));
                                  }
                                }
                                if (_dueDate.text.isEmpty) {
                                  return AlertError.show(
                                      context, "Date cannot be empty");
                                }
                                if (context.read<StatusBloc>().state.id ==
                                    null) {
                                  return AlertError.show(
                                      context, "Status cannot be empty");
                                }
                                // NotificationApi.showNotif();
                              },
                              title: "Create Task",
                              fontSize: 16,
                              backgroundColor: ColorApp.brand500,
                              colorTitle: ColorApp.white,
                              fontWeight: FontWeight.w500);
                        },
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
