// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../../home/model/product_model.dart';
import 'details_product_reviews_model.dart';
import 'product_details_product_model.dart';
import 'seller_profile.dart';

class ProductDetailsModel extends Equatable {
  final int id;
  final int totalProductReviewQty;
  final ProductDetailsProductModel product;
  final List<GalleryModel?> gallery;
  final List<ProductDetailsProductModel> relatedProducts;
  final List<DetailsProductReviewModel> productReviews;
  final List<ProductDetailsProductModel> thisSellerProducts;
  //"is_seller_product": true,
  final bool isSellerProduct;
  final String tags;
  final int? sellerTotalProducts;
  final int? sellerReviewQty;
  final int? sellerTotalReview;
  final SellerInfoProfile? sellerProfile;

  const ProductDetailsModel({
    required this.id,
    required this.totalProductReviewQty,
    required this.product,
    required this.gallery,
    required this.relatedProducts,
    required this.productReviews,
    required this.thisSellerProducts,
    required this.sellerTotalProducts,
    required this.sellerReviewQty,
    required this.sellerTotalReview,
    required this.sellerProfile,
    required this.isSellerProduct,
    required this.tags,
  });

  // final List<ProductVariantModel> productVariants;

  ProductDetailsModel copyWith({
    int? id,
    int? totalProductReviewQty,
    ProductDetailsProductModel? product,
    List<GalleryModel?>? gallery,
    List<ProductDetailsProductModel>? relatedProducts,
    List<DetailsProductReviewModel>? productReviews,
    List<ProductDetailsProductModel>? thisSellerProducts,
    int? sellerTotalProducts,
    int? sellerReviewQty,
    int? sellerTotalReview,
    SellerInfoProfile? sellerProfile,
    bool? isSellerProduct,
    String? tags,
  }) {
    return ProductDetailsModel(
      id: id ?? this.id,
      totalProductReviewQty:
          totalProductReviewQty ?? this.totalProductReviewQty,
      product: product ?? this.product,
      gallery: gallery ?? this.gallery,
      relatedProducts: relatedProducts ?? this.relatedProducts,
      productReviews: productReviews ?? this.productReviews,
      thisSellerProducts: thisSellerProducts ?? this.thisSellerProducts,
      sellerTotalProducts: sellerTotalProducts ?? this.sellerTotalProducts,
      sellerReviewQty: sellerReviewQty ?? this.sellerReviewQty,
      sellerTotalReview: sellerTotalReview ?? this.sellerTotalReview,
      sellerProfile: sellerProfile ?? this.sellerProfile,
      isSellerProduct: isSellerProduct ?? this.isSellerProduct,
      tags: tags ?? this.tags,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'totalProductReviewQty': totalProductReviewQty,
      'product': product.toMap(),
      'gellery': gallery.map((x) => x?.toMap()).toList(),
      'relatedProducts': relatedProducts.map((x) => x.toMap()).toList(),
      'productReviews': productReviews.map((x) => x.toMap()).toList(),
      'this_seller_products': thisSellerProducts.map((x) => x.toMap()).toList(),
      'sellerTotalProducts': sellerTotalProducts,
      'sellerReviewQty': sellerReviewQty,
      'sellerTotalReview': sellerTotalReview,
      'is_seller_product': isSellerProduct,
      'tags': tags,
      'seller': sellerProfile!.toMap(),
    };
  }

  factory ProductDetailsModel.fromMap(Map<String, dynamic> map) {
    return ProductDetailsModel(
      id: map['id'] ?? 0,
      totalProductReviewQty: map['totalProductReviewQty'] ?? 0,
      product: ProductDetailsProductModel.fromMap(
          map['product'] as Map<String, dynamic>),
      gallery: List<GalleryModel?>.from(
        (map['gellery'] as List<dynamic>).map<GalleryModel?>(
          (x) => GalleryModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      relatedProducts: List<ProductDetailsProductModel>.from(
        (map['relatedProducts'] as List<dynamic>)
            .map<ProductDetailsProductModel>(
          (x) => ProductDetailsProductModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      productReviews: List<DetailsProductReviewModel>.from(
        (map['productReviews'] as List<dynamic>).map<DetailsProductReviewModel>(
          (x) => DetailsProductReviewModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      thisSellerProducts: List<ProductDetailsProductModel>.from(
        (map['this_seller_products'] as List<dynamic>)
            .map<ProductDetailsProductModel>(
          (x) => ProductDetailsProductModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      sellerTotalProducts: map['sellerTotalProducts'] ?? 0,
      sellerReviewQty: map['sellerReviewQty'] ?? 0,
      sellerTotalReview: map['sellerTotalReview'] !=null ?  int.parse("${map['sellerTotalReview']}") : 0,
      sellerProfile: map['seller'] != null
          ? SellerInfoProfile.fromMap(
              map['seller'] as Map<String, dynamic>)
          : null,
        isSellerProduct: map['is_seller_product']??false,
        tags: map['tags']??'',
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductDetailsModel.fromJson(String source) =>
      ProductDetailsModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      totalProductReviewQty,
      product,
      gallery,
      relatedProducts,
      productReviews,
      thisSellerProducts,
      sellerTotalProducts!,
      sellerReviewQty!,
      sellerTotalReview!,
      sellerProfile!,
    ];
  }
}
