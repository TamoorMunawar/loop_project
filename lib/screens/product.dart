import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:loop_project/state/product_state.dart';
import 'package:http/http.dart' as http;
final productProvider =
StateNotifierProvider<ProductNotifier, ProductState>((ref) {
  return ProductNotifier(httpClient: http.Client());
});


class ProductScreen extends ConsumerStatefulWidget {
  const ProductScreen({super.key});

  @override
  ConsumerState<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends ConsumerState<ProductScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(productProvider.notifier).getProduct();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Product Screen"),),
      body: Center(
        child: Consumer(
          builder: ((context, ref, child) {
            ProductState state = ref.watch(productProvider);
            if (state is PInitialState) {
              return const Text('No data Available');
            } else if (state is PLoadingState) {
              return const CircularProgressIndicator();
            } else if (state is PLoadedState) {
              return _productCard(state);
            } else if (state is PErrorState) {
              return Text(state.message);
            } else {
              return const Text('Nothing');
            }
          }),
        ),
      ),
    );
  }
  Widget _productCard(PLoadedState state) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: state.product.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0,
            ),
            itemBuilder: ((context, index) {
              var cat = state.product[index];
              print("product length ${state.product.length}");
              return Container(
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(10), // Set the border radius
                ),
                child: Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(7.0),
                        child: CachedNetworkImage(
                          key: UniqueKey(),
                          cacheManager: CacheManager(Config(
                            "customKey",
                            stalePeriod: Duration(days: 15),
                            maxNrOfCacheObjects: 100,
                          )),
                          imageUrl: "${cat.photo ?? ""}",
                          fit: BoxFit.cover,
                          width: 120,
                          height: 100,
                          errorWidget: (context,
                              url,
                              error) =>
                              Image.asset(
                                'assets/image/placeholder.jpg',
                                fit: BoxFit
                                    .cover,
                              ),
                          placeholder: (context,
                              url) =>
                              Image.asset(
                                'assets/image/placeholder.jpg',
                                fit: BoxFit
                                    .cover,
                              ),
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        cat.categoryName ?? "",
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        cat.price ?? "",
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 10.0,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            })),
      ),
    );
  }
}
