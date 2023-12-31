import 'package:greengrocer/src/constants/endpoints.dart';
import 'package:greengrocer/src/models/cart_item_model.dart';
import 'package:greengrocer/src/pages/cart/result/cart_result.dart';
import 'package:greengrocer/src/services/http_manager.dart';

class CartRepository {
  final _httpManager = HttpManager();

  Future<CartResult<List<CartItemModel>>> getCartItems({required String token, required String userId}) async {
    final result = await _httpManager.restRequest(
      url: Endpoints.getCartItems,
      method: HttpMethods.post,
      headers: {
        'X-Parse-Session-Token': token,
      },
      body: {
        'user': userId,
      },
    );

    if (result['result'] != null) {
      List<CartItemModel> data = List<Map<String, dynamic>>.from(result['result']).map(CartItemModel.fromJson).toList();

      return CartResult<List<CartItemModel>>.success(data);
    } else {
      return CartResult.error('Ocorreu um erro ao recuper itens do carrinho');
    }
  }

  Future<bool> changeItemQuantity({
    required String cartItemId,
    required int quantity,
    required String token,
  }) async {
    final result = await _httpManager.restRequest(url: Endpoints.changeItemQuantity, method: HttpMethods.post, body: {
      'CartItemId': cartItemId,
      'quantity': quantity,
    }, headers: {
      'X-Parse-Session-Token': token
    });

    return result.isEmpty;
  }

  Future<CartResult<String>> addItemToCart({
    required String userId,
    required String token,
    required String productId,
    required int quantity,
  }) async {
    final result = await _httpManager.restRequest(
      url: Endpoints.addItemToCart,
      method: HttpMethods.post,
      body: {
        'user': '',
        'quantity': 1,
        'productId': '',
      },
      headers: {
        'X-Parse-Session-Token': token,
      },
    );

    if (result['result'] != null) {
      //adciona produto
      return CartResult<String>.success(result['result']['id']);
    } else {
      // erro
      return CartResult.error('Não foi possível adicionar item ao carrinho');
    }
    ;
  }
}
