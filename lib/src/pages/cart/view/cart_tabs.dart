import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greengrocer/src/pages/cart/controller/cart_controller.dart';
import 'package:greengrocer/src/config/custom_colors.dart';
import 'package:greengrocer/src/pages/cart/view/components/cart_tile.dart';
import 'package:greengrocer/src/services/utils_services.dart';

class CartTab extends StatefulWidget {
  const CartTab({super.key});

  @override
  State<CartTab> createState() => _CartTabState();
}

class _CartTabState extends State<CartTab> {
  final UtilsServices utilsServices = UtilsServices();
  final cartController = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Carrinho',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: [
          Expanded(
            child: GetBuilder<CartController>(
              builder: (controller) {
                if (controller.cartItems.isEmpty) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.remove_shopping_cart,
                        size: 40,
                        color: CustomColors.customSwatchColor,
                      ),
                      Text('Não há itens no carrinho'),
                    ],
                  );
                }
                return ListView.builder(
                  itemCount: controller.cartItems.length,
                  itemBuilder: (_, i) {
                    return CartTile(
                      cartItem: controller.cartItems[i],
                    );
                  },
                );
              },
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  blurRadius: 3,
                  spreadRadius: 2,
                ),
              ],
              color: Colors.white,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(30),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Total Geral',
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
                GetBuilder<CartController>(
                  builder: (controller) {
                    return Text(
                      utilsServices.priceToCurrency(controller.cartTotalPrice()),
                      style: TextStyle(
                        fontSize: 23,
                        color: CustomColors.customSwatchColor,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: 50,
                  child: GetBuilder<CartController>(
                    builder: (controller) {
                      return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                        ),
                        onPressed: (controller.isCheckoutLoading || controller.cartItems.isEmpty)
                            ? null
                            : () async {
                                bool? result = await showOrderConfirmation();
                                if (result ?? false) {
                                  cartController.checkoutCart();
                                } else {
                                  utilsServices.showToast(message: 'Pedido não confirmado');
                                }
                              },
                        child: controller.isCheckoutLoading
                            ? CircularProgressIndicator()
                            : const Text(
                                'Concluir pedido',
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                      );
                    },
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Future<bool?> showOrderConfirmation() {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Confirmação'),
          content: const Text('Deseja realmente concluir o pedido?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
                utilsServices.showToast(message: 'Pedido não confirmado', isError: true);
              },
              child: const Text(
                'Não',
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, true);
                utilsServices.showToast(message: 'Pedido não confirmado', isError: true);
              },
              child: const Text(
                'Sim',
              ),
            ),
          ],
        );
      },
    );
  }
}
