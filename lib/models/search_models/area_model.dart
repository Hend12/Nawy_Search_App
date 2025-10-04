class AreaModel{
  int? id;
  String? name;
  AreaModel({this.id,this.name});
  AreaModel.fromjson(Map<String,dynamic> json){
    id=json['id'];
    name=json['name'];
  }
}