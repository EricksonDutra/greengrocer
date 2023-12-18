import 'package:flutter/material.dart';
import 'package:greengrocer/src/models/order_model.dart';
import 'package:greengrocer/src/services/utils_services.dart';
import 'package:qr_flutter/qr_flutter.dart';

class PaymentDialog extends StatelessWidget {
  PaymentDialog({super.key, required this.order});

  final OrderModel order;
  final UtilsServices utilsServices = UtilsServices();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Pagamento com PIX',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),

                //QR Code
                QrImageView(
                  data: '1234567890',
                  version: QrVersions.auto,
                  size: 200.0,
                ),

                //Vencimento
                Text(
                  "Vencimento: ${utilsServices.formatDateTime(order.overdueDateTime)}",
                  style: const TextStyle(fontSize: 12),
                ),

                //Total
                Text(
                  "Total: ${utilsServices.priceToCurrency(order.total)}",
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                //copia e cola
                OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    side: const BorderSide(
                      width: 2,
                      color: Colors.green,
                    ),
                  ),
                  onPressed: () {},
                  icon: const Icon(
                    Icons.copy,
                    size: 15,
                  ),
                  label: const Text(
                    'Copiar código PIX',
                    style: TextStyle(
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: 5,
            top: 5,
            child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.close),
            ),
          ),
        ],
      ),
    );
  }
}
