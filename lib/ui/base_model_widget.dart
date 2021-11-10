import 'package:flutter/material.dart';
import 'package:flutter_base_architecture/exception/base_error.dart';
import 'package:flutter_base_architecture/exception/base_error_handler.dart';
import 'package:flutter_base_architecture/exception/base_error_parser.dart';
import 'package:flutter_base_architecture/extensions/widget_extensions.dart';
import 'package:flutter_base_architecture/ui/base_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';

abstract class BaseModelWidget<T extends ChangeNotifier, ErrorParser extends BaseErrorParser>
    extends Widget {
  ErrorHandler<ErrorParser>? _errorHandler;

  final ProviderBase<Object?, T> providerBase;

  final ProviderBase<Object?, ErrorHandler<ErrorParser>?> errorHandlerProviderBase;

  BaseModelWidget(this.providerBase, this.errorHandlerProviderBase);


  @protected
  Widget build(BuildContext context, T model);

  @override
  DataProviderElement<T, ErrorParser> createElement() =>
      DataProviderElement<T, ErrorParser>(this,this.providerBase,this.errorHandlerProviderBase);

  void showToastMessage(String message,
      {required Toast toastLength,
      required ToastGravity gravity,
      required Color backgroundColor,
      required int timeInSecForIos,
      required Color textColor,
      required double fontSize}) {
    toastMessage(message,
        toastLength: toastLength,
        gravity: gravity,
        timeInSecForIos: timeInSecForIos,
        backgroundColor: backgroundColor,
        textColor: textColor,
        fontSize: fontSize);
  }

  String getErrorMessage(BuildContext context, BaseError error) {
    return _errorHandler?.parseErrorType(context, error) ?? '';
  }

}

class DataProviderElement<T extends ChangeNotifier, ErrorParser extends BaseErrorParser>
    extends ComponentElement {
  DataProviderElement(BaseModelWidget widget,this.providerBase,this.errorHandlerProviderBase) : super(widget);

  final ProviderBase<Object?, T> providerBase;

  final ProviderBase<Object?, ErrorHandler<ErrorParser>?> errorHandlerProviderBase;


  @override
  BaseModelWidget get widget => super.widget as BaseModelWidget;

  @override
  Widget build() {
    widget._errorHandler = this.read(errorHandlerProviderBase);
    return BaseWidget<T>(
      providerBase: providerBase,
      builder: (context, model, child) {
        return widget.build(this, model);
      },
    );
  }

  @override
  void update(BaseModelWidget newWidget) {
    super.update(newWidget);
    assert(widget == newWidget);
    rebuild();
  }
}
