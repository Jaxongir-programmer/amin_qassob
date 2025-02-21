import 'package:amin_qassob/utils/utils.dart';
import 'package:amin_qassob/view/shimmers.dart';
// import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

import '../../../generated/assets.dart';
import '../../../provider/providers.dart';
import '../../../utils/app_colors.dart';
import '../../../view/order_item_view.dart';
import '../home/home_viewmodel.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  _OrdersScreenState createState() => _OrdersScreenState();

}

class _OrdersScreenState extends State<OrdersScreen> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      builder: (context,viewModel, child) {
        return Consumer<Providers>(builder: (context, provider, child) {
          return Scaffold(
              appBar: AppBar(
                title: Text("Buyurtmalar"),
              ),
              body: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  return RefreshIndicator(
                      onRefresh: () async {
                        viewModel.getOrderList();
                      },
                      child: SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        child: ConstrainedBox(
                          constraints: BoxConstraints(minHeight: constraints.maxHeight),
                          child: viewModel.orderProgress
                              ? orderShimmer(context: context)
                              : (viewModel.orderList.length != 0)
                                  ? ListView.builder(
                                      shrinkWrap: true,
                                      primary: false,
                                      itemCount: viewModel.orderList.length,
                                      itemBuilder: (ctx, index) {
                                        var item = viewModel.orderList[index];
                                        return OrderItemView(item);
                                      })
                                  : Center(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            Assets.imagesNorOrder,
                                            width: 200,
                                            height: 200,
                                          ),
                                          const SizedBox(
                                            height: 12,
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.symmetric(horizontal: 24.0),
                                            child: Text(
                                              "Sizda faol buyurtmalar mavjud emas!",
                                              style: TextStyle(
                                                  color: Colors.blueGrey, fontWeight: FontWeight.w500, fontSize: 16),
                                              textAlign: TextAlign.center,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                        ),
                      ));
                },
              ));
        });
      },
      viewModelBuilder: () {
        return HomeViewModel();
      },
      onViewModelReady: (viewModel) {
        viewModel.getOrderList();

        viewModel.errorData.listen((event) {
          showError(context, event);
        });
      },
    );
  }
}
