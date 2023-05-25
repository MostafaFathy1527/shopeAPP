import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shope/view/deatilas_view.dart';
import 'package:shope/view/widget/CustomText2.dart';

import '../../constance.dart';
import '../../core/view_model/home_view_model.dart';
import '../../model/productmodel.dart';

class SearchView extends StatefulWidget {
  final String? searchValue;

  SearchView(this.searchValue);

  @override
  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  String? _searchValue;

  @override
  void initState() {
    _searchValue = widget.searchValue!.toLowerCase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<ProductModel> _searchProducts = _searchValue == ''
        ? []
        : Get.find<HomeViewModel>()
        .productModel
        .where(
            (product) => product.name.toLowerCase().contains(_searchValue!))
        .toList();

    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 130,
            child: Padding(
              padding: EdgeInsets.only(bottom: 24, left: 16, right: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints(),
                    onPressed: () {
                      Get.back();
                    },
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.black,
                    ),
                  ),
                  CustomText2(
                    text: 'Search',
                    fontSize: 20,
                    alignment: Alignment.bottomCenter,
                  ),
                  Container(
                    width: 24,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              height: 49,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(45),
              ),
              child: TextFormField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                ),
                initialValue: _searchValue,
                onFieldSubmitted: (value) {
                  setState(() {
                    _searchValue = value.toLowerCase();
                  });
                },
              ),
            ),
          ),
          SizedBox(
            height: 24,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: 16, left: 16, bottom: 24),
              child: GetBuilder<HomeViewModel>(
                init: Get.find<HomeViewModel>(),
                builder: (controller) => GridView.builder(
                  padding: const EdgeInsets.all(0),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 15,
                    mainAxisExtent: 320,
                  ),
                  itemCount: _searchProducts.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Get.to(
                          ProductDetailView(_searchProducts[index]),
                        );
                      },
                      child: Container(
                        width: 164,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: Colors.white,
                              ),
                              height: 240,
                              width: 164,
                              child: Image.network(
                                _searchProducts[index].image,
                                fit: BoxFit.cover,
                              ),
                            ),
                            CustomText2(
                              text: _searchProducts[index].name,
                              fontSize: 16,
                            ),
                            CustomText2(
                              text: _searchProducts[index].descritption,
                              fontSize: 12,
                              color: Colors.grey,
                              maxLines: 1,
                            ),
                            CustomText2(
                              text: '\$${_searchProducts[index].price}',
                              fontSize: 16,
                              color: primaryColor,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
