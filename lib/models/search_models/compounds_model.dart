class CompoundModel{
int? id;
int? areaId;
String? name;
String? imagePath;
CompoundModel({this.id,this.areaId,this.name,this.imagePath});
CompoundModel.fromjson(Map<String,dynamic> json){
  id=json['id'];
  areaId=json['area_id'];
  name=json['name'];
  imagePath=json['image_path'];

}
}