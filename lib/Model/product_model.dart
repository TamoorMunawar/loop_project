class ProductModel {
  int? code;
  String? msg;
  List<Data>? data;

  ProductModel({this.code, this.msg, this.data});

  ProductModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? itemId;
  String? merchantId;
  String? itemName;
  String? itemDescription;
  String? itemNameTrans;
  String? itemDescriptionTrans;
  String? status;
  String? price;
  String? photo;
  int? discount;
  String? dish;
  String? size;
  String? qtyForPrice;
  String? promotionStartDate;
  String? promotionEndDate;
  String? category;
  String? categoryName;
  bool? multiplePrice;
  List<String>? prices2;
  bool? addedAsFavorite;
  String? prices;
  List<String>? prices1;
  String? catId;
  String? dishImage;
  String? qty;

  Data(
      {this.itemId,
        this.merchantId,
        this.itemName,
        this.itemDescription,
        this.itemNameTrans,
        this.itemDescriptionTrans,
        this.status,
        this.price,
        this.photo,
        this.discount,
        this.dish,
        this.size,
        this.qtyForPrice,
        this.promotionStartDate,
        this.promotionEndDate,
        this.category,
        this.categoryName,
        this.multiplePrice,
        this.prices2,
        this.addedAsFavorite,
        this.prices,
        this.prices1,
        this.catId,
        this.dishImage,
        this.qty});

  Data.fromJson(Map<String, dynamic> json) {
    itemId = json['item_id'];
    merchantId = json['merchant_id'];
    itemName = json['item_name'];
    itemDescription = json['item_description'];
    itemNameTrans = json['item_name_trans'];
    itemDescriptionTrans = json['item_description_trans'];
    status = json['status'];
    price = json['price'];
    photo = json['photo'];
    discount = json['discount'];
    dish = json['dish'];
    size = json['size'];
    qtyForPrice = json['qty_for_price'];
    promotionStartDate = json['promotion_start_date'];
    promotionEndDate = json['promotion_end_date'];
    category = json['category'];
    categoryName = json['categoryName'];
    multiplePrice = json['multiple_price'];
    prices2 = json['prices2'].cast<String>();
    addedAsFavorite = json['added_as_favorite'];
    prices = json['prices'];
    prices1 = json['prices1'].cast<String>();
    catId = json['cat_id'];
    dishImage = json['dish_image'];
    qty = json['qty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['item_id'] = this.itemId;
    data['merchant_id'] = this.merchantId;
    data['item_name'] = this.itemName;
    data['item_description'] = this.itemDescription;
    data['item_name_trans'] = this.itemNameTrans;
    data['item_description_trans'] = this.itemDescriptionTrans;
    data['status'] = this.status;
    data['price'] = this.price;
    data['photo'] = this.photo;
    data['discount'] = this.discount;
    data['dish'] = this.dish;
    data['size'] = this.size;
    data['qty_for_price'] = this.qtyForPrice;
    data['promotion_start_date'] = this.promotionStartDate;
    data['promotion_end_date'] = this.promotionEndDate;
    data['category'] = this.category;
    data['categoryName'] = this.categoryName;
    data['multiple_price'] = this.multiplePrice;
    data['prices2'] = this.prices2;
    data['added_as_favorite'] = this.addedAsFavorite;
    data['prices'] = this.prices;
    data['prices1'] = this.prices1;
    data['cat_id'] = this.catId;
    data['dish_image'] = this.dishImage;
    data['qty'] = this.qty;
    return data;
  }
}
