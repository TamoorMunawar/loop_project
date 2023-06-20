class categoryModel {
  int? code;
  String? msg;
  List<Data>? data;

  categoryModel({this.code, this.msg, this.data});

  categoryModel.fromJson(Map<String, dynamic> json) {
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
  String? mainCat;
  String? parentCatsId;
  String? catId;
  String? subCatId;
  String? categoryName;
  String? categoryDescription;
  String? categoryPic;

  Data(
      {this.mainCat,
        this.parentCatsId,
        this.catId,
        this.subCatId,
        this.categoryName,
        this.categoryDescription,
        this.categoryPic});

  Data.fromJson(Map<String, dynamic> json) {
    mainCat = json['main_cat'];
    parentCatsId = json['parent_cats_id'];
    catId = json['cat_id'];
    subCatId = json['sub_cat_id'];
    categoryName = json['category_name'];
    categoryDescription = json['category_description'];
    categoryPic = json['category_pic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['main_cat'] = this.mainCat;
    data['parent_cats_id'] = this.parentCatsId;
    data['cat_id'] = this.catId;
    data['sub_cat_id'] = this.subCatId;
    data['category_name'] = this.categoryName;
    data['category_description'] = this.categoryDescription;
    data['category_pic'] = this.categoryPic;
    return data;
  }
}
