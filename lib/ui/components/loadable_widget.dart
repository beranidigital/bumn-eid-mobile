import 'package:after_layout/after_layout.dart';
import 'package:bumn_eid/ui/components/custom_error_widget.dart';
import 'package:bumn_eid/ui/components/default_loading_widget.dart';
import 'package:bumn_eid/ui/components/loading_widget.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:flutter/material.dart';

class LoadableWidget<T> extends StatefulWidget {
  final Future<T> Function() fetchFunction;
  final ColorPalette colorPalette;
  final Widget Function(BuildContext, T) buildFunction;
  final T predefinedItems;
  final LoadingWidget customLoadingWidget;
  final bool forceLoading;

  LoadableWidget({
    @required this.fetchFunction,
    @required this.colorPalette,
    @required this.buildFunction,
    this.predefinedItems,
    this.customLoadingWidget,
    this.forceLoading = false,
  });

  @override
  _LoadableWidgetState<T> createState() => _LoadableWidgetState<T>();
}

class _LoadableWidgetState<T> extends State<LoadableWidget>
    with AfterLayoutMixin<LoadableWidget> {
  T currentData;
  bool isError = false;

  bool isDataReady() {
    final ready = currentData != null && !widget.forceLoading;
    return ready;
  }

  @override
  void afterFirstLayout(BuildContext context) {
    fetchData();
  }

  void fetchData() async {
    try {
      setState(() {
        this.isError = false;
        this.currentData = null;
      });
      T data;
      if (widget.predefinedItems != null) {
        data = widget.predefinedItems;
      } else {
        data = await widget.fetchFunction();
      }

      setState(() {
        this.currentData = data;
      });
    } catch (ex) {
      print(ex.toString());
      setState(() {
        this.isError = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return !isDataReady()
        ? isError
            ? CustomErrorWidget(
                onRetry: () => fetchData(),
              )
            : widget.customLoadingWidget == null
                ? DefaultLoadingWidget(
                    colorPalette: widget.colorPalette,
                  )
                : widget.customLoadingWidget
        : widget.buildFunction(context, widget.predefinedItems ?? currentData);
  }
}
