import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BaseWidget<T extends ChangeNotifier> extends StatefulWidget {
  final Widget Function(BuildContext context, T model, Widget? child) builder;
  final ProviderBase<Object?, T> providerBase;
  final Widget? child;
  final Function(T)? onModelReady;
  Duration duration;
  final bool animate;

  BaseWidget(
      {Key? key,
        required this.builder,
        required this.providerBase,
        this.child, this.onModelReady,
        this.duration: const Duration(
          milliseconds: 600,
        ),
        this.animate: false})
      : super(key: key);

  @override
  _BaseWidget<T> createState() => _BaseWidget<T>();
}

class _BaseWidget<T extends ChangeNotifier> extends State<BaseWidget<T>>
    with SingleTickerProviderStateMixin {
  T? _model;
  Duration? duration;
  AnimationController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this,
        duration: widget.animate ? widget.duration : Duration(milliseconds: 0));
    _controller?.forward(from: 0.0);
    _model = context.read(widget.providerBase);
    duration = widget.duration;

    if (_model != null) {
      if(widget.onModelReady!=null){
        widget.onModelReady!(_model!);
      }
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, child) {
        _controller?.forward(from: 0.0);
        _model = watch(widget.providerBase);
        return AnimatedBuilder(
            builder: (context, child) {
              return Opacity(
                opacity: _controller?.value ?? 0,
                child: child,
              );
            },
            animation: _controller!,
            child: widget.builder(context, _model!, child));
      },
      child: widget.child,
    );
  }
}