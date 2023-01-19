import 'package:flutter/material.dart';
import 'package:ylupi/screens/state_management/multi_provider/resources/balance_shared_state.dart';
import 'package:ylupi/screens/state_management/multi_provider/resources/cart_shared_state.dart';
import 'package:ylupi/screens/state_management/multi_provider/resources/color_shared_state.dart';
import 'package:provider/provider.dart';

class MultiProviderExample extends StatefulWidget {
  final String judulItem;

  const MultiProviderExample({
    super.key,
    required this.judulItem,
  });

  @override
  State<MultiProviderExample> createState() => _MultiProviderExampleState();
}

class _MultiProviderExampleState extends State<MultiProviderExample> {
  TextStyle myTextStyle = const TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => ColorState(),
          ),
          ChangeNotifierProvider(
            create: (context) => BalanceState(),
          ),
          ChangeNotifierProvider(
            create: (context) => CartState(),
          )
        ],
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            toolbarHeight: 100,
            // centerTitle: true,
            title: Consumer<ColorState>(
              builder: (context, colorstate, child) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Multi Provider",
                    style: TextStyle(color: colorstate.getColor),
                  ),
                ],
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    Text("G"),
                    Consumer<ColorState>(
                      builder: (context, colorstate, child) => Switch(
                        value: colorstate.getIsLightGreen,
                        onChanged: ((value) {
                          colorstate.setColor = value;
                        }),
                      ),
                    ),
                    Text("B"),
                  ],
                ),
              ),
            ],
          ),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Consumer<ColorState>(
                    builder: (context, colorstate, child) => Text(
                      "Wallet",
                      style: TextStyle(
                        color: colorstate.getColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Consumer<ColorState>(
                    builder: (context, colorstate, child) =>
                        Consumer<BalanceState>(
                      builder: (context, balancestate, child) =>
                          AnimatedContainer(
                        duration: const Duration(milliseconds: 500),
                        height: MediaQuery.of(context).size.height / 4,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: colorstate.getColor),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Current Balance",
                                style: myTextStyle,
                              ),
                              Text(
                                "${balancestate.getBalance}",
                                style: myTextStyle,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Consumer<ColorState>(
                    builder: (context, colorstate, child) =>
                        Consumer<CartState>(
                      builder: (context, cartstate, child) => Card(
                        color: colorstate.getColor,
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 500),
                          width: MediaQuery.of(context).size.width * 0.8,
                          height: 150,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const SizedBox(
                                height: 5.0,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 20.0,
                                  right: 20.0,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Indomie Goreng (3000)",
                                      style: myTextStyle,
                                    ),
                                    Text(
                                      " x ${cartstate.getQuantity}",
                                      style: myTextStyle,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 5.0,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 20.0,
                                  right: 20.0,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Total Bayar : ",
                                      style: myTextStyle,
                                    ),
                                    Text(
                                      "${cartstate.getQuantity * 3000}",
                                      style: myTextStyle,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 5.0,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          floatingActionButton: Consumer3<ColorState, BalanceState, CartState>(
            builder: (context, colorstate, balancestate, cartstate, child) =>
                FloatingActionButton(
              backgroundColor: colorstate.getColor,
              onPressed: () {
                if (balancestate.getBalance > 0) {
                  balancestate.decreaseBalance(3000);
                  cartstate.addCart();
                }
              },
              child: const Icon(Icons.add_shopping_cart),
            ),
          ),
        ),
      ),
    );
  }
}
