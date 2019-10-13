import 'package:fabu_utils/fabu_utils.dart';
import 'package:flutter/widgets.dart';

abstract class View<ViewModel> extends StatefulWidget {
  View({Key key}) : super(key: key);

  @override
  _ViewState<ViewModel> createState() => _ViewState();

  Widget build(BuildContext context, ViewModel viewModel);

  @protected
  ViewModel initViewModel(ViewModel oldViewModel) => null;

  @protected
  bool needsUpdate(View oldView, ViewModel viewModel) => false;
}

class _ViewState<ViewModel> extends State<View> {
  @override
  void initState() {
    super.initState();
    this._vm = widget.initViewModel(null);
  }

  ViewModel _vm ;
  ViewModel get vm => _vm ?? (_vm = Ioc().get());

  @override
  void didUpdateWidget(View oldView) {
    super.didUpdateWidget(oldView);
    if (widget.needsUpdate(oldView, vm))
      _vm = widget.initViewModel(vm);
  }

  @override
  Widget build(BuildContext context) {
    return widget.build(context, vm);
  }

  @override
  void dispose() {
    if (_vm is Disposable)
      (_vm as Disposable).dispose();
    super.dispose();
  }
}
