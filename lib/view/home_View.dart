import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shope/constance.dart';
import 'package:shope/core/view_model/control_view_model.dart';
import 'package:shope/core/view_model/home_view_model.dart';
import 'package:shope/view/cart_view.dart';
import 'package:shope/view/deatilas_view.dart';
import 'package:shope/view/widget/custom_text.dart';
import 'package:shope/view/widget/search_view.dart';

import '../all_products.dart';
import '../core/view_model/auth_view_model.dart';
import '../model/category_model.dart';
import 'auth/login_screen.dart';

class HomeView extends StatelessWidget {
  final List<String> names = <String>[
    '1',
    '1',
    '1',
    '1',
    '1',
  ];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeViewModel>(
      init: HomeViewModel(),
      builder: (controller) => controller.loading.value
          ? Center(child: CircularProgressIndicator())
          : Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(top: 100, left: 20, right: 20),
            child: Column(
              children: [
                _loadBottom(),
                _searchTextFormField(),
                SizedBox(height: 50,),
                _listViewCategory(),
                SizedBox(height: 30,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      text: "Best Selling",
                      fontSize: 18,
                    ),
                    GestureDetector(
                      child: CustomText(
                        text: "See all",
                        fontSize: 16,
                      ),
                      onTap: () {
                        Get.to(AllProducts());
                      },
                    ),
                  ],
                ),
                SizedBox(height: 30,),
                _listViewProducts(),
              ],
            ),
          ),
        ),
        bottomNavigationBar: bottomNavigationBar(),
      ),
    );
  }

  Widget _listViewCategory() {
    return GetBuilder<HomeViewModel>(
      init: HomeViewModel(),
      builder: (controller) => Column(
        children: [
          CustomText(
            text: "Categories",
            fontSize: 24,
          ),
          SizedBox(height: 30,),
          Container(
            height: 100,
            child: ListView.separated(
              itemCount: controller.categoryModel.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final category = controller.categoryModel[index];
                return GestureDetector(
                  onTap: () {
                    Get.to(ProductsByCategory(category: category));
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * .25,
                    child: Column(
                      children: [
                        SizedBox(height: 20,),
                        CustomText(
                          text: category.name,
                          alignment: Alignment.bottomCenter,
                        )
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) =>
                  SizedBox(width: 20,),
            ),
          ),
        ],
      ),
    );
  }

  Widget _searchTextFormField() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.grey.shade100,
      ),
      child: TextFormField(
        decoration: InputDecoration(
          border: InputBorder.none,
          prefixIcon: Icon(
            Icons.search,
            color: Colors.black,
          ),
          hintText: "Search",
        ),
        onFieldSubmitted: (value) {
          Get.to(SearchView(value));
        },
      ),

    );
  }

  Widget _listViewProducts() {
    return GetBuilder<HomeViewModel>(
      builder: (controller) => Container(
        height: 500,
        child: ListView.separated(
          itemCount: controller.productModel.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            final product = controller.productModel[index];
            final price = double.tryParse(product.price) ?? 0.0;

            return GestureDetector(
              onTap: () {
                Get.to(ProductDetailView(controller.productModel[index]));
              },
              child: Container(
                width: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.grey.shade100,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(
                            product.image,
                            fit: BoxFit.fill
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.name,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            product.descritption,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 4),
                          Text(
                            "\$${price.toStringAsFixed(2)}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          separatorBuilder: (context, index) => SizedBox(width: 20),
        ),
      ),
    );
  }

  Widget bottomNavigationBar() {
    return GetBuilder<ControlViewModel>(
      init: ControlViewModel(),
      builder: (controller) => BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            activeIcon: Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Text(
                "Explore",
                style: TextStyle(
                  color: primaryColor,
                ),
              ),
            ),
            icon: Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Icon(Icons.home),
            ),
            label: "",
          ),
          BottomNavigationBarItem(
            activeIcon: Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Text(
                "Profile",
                style: TextStyle(
                  color: primaryColor,
                ),
              ),
            ),
            icon: Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Icon(Icons.person),
            ),
            label: "",
          ),
          BottomNavigationBarItem(
            activeIcon: Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Text(
                "Cart",
                style: TextStyle(
                  color: primaryColor,
                ),
              ),
            ),
            icon: Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Icon(Icons.shopping_cart),
            ),
            label: "",
          ),
        ],
        currentIndex: controller.navigatorValue,
        onTap: (index) {
          controller.changeSelectedValue(index);
        },
        elevation: 0,
        selectedItemColor: Colors.black,
        backgroundColor: Colors.grey.shade50,
      ),
    );
  }

  Widget _loadBottom() {
    return GetBuilder<ControlViewModel>(
      init: ControlViewModel(),
      builder: (controller) => Text(""),
    );
  }
}

class ProductsByCategory extends StatelessWidget {
  final CategoryModel category;

  const ProductsByCategory({required this.category});

  @override
  Widget build(BuildContext context) {
    // Fetch products belonging to the selected category using the category ID
    // and display them in a list view or grid view
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(category.name),
      ),
      body: Container(
        // Implement your product list view/grid view here
        child: Center(
          child: Text('Products of ${category.name}'),
        ),
      ),
    );
  }
}
