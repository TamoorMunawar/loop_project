import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import '../routes/app_route_constant.dart';
import '../state/categories_state.dart';

final catProvider =
    StateNotifierProvider<CategroyNotifier, CategroyState>((ref) {
  return CategroyNotifier(httpClient: http.Client());
});

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(catProvider.notifier).getCategroy();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Categroy Screen"),
      ),
      body: Center(
        child: Consumer(
          builder: ((context, ref, child) {
            CategroyState state = ref.watch(catProvider);
            if (state is CInitialState) {
              return const Text('No data Available');
            } else if (state is CLoadingState) {
              return const CircularProgressIndicator();
            } else if (state is CLoadedState) {
              return _categroyCard(state);
            } else if (state is CErrorState) {
              return Text(state.message);
            } else {
              return const Text('Nothing');
            }
          }),
        ),
      ),
    );
  }

  Widget _categroyCard(CLoadedState state) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: state.categries.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Set the number of columns in the grid
              crossAxisSpacing: 10.0, // Set the horizontal spacing between items
              mainAxisSpacing: 10.0, // Set the vertical spacing between items
            ),
            itemBuilder: ((context, index) {
              var cat = state.categries[index];
              print("product length ${state.categries.length}");
              return InkWell(
                onTap: (){
                  context.pushNamed(AppRoutesConstant.productRoute);
                },
                child: Container(
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
                            imageUrl: "${cat.categoryPic ?? ""}",
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
                          cat.catId ?? "",
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 10.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            })),
      ),
    );
  }
}
