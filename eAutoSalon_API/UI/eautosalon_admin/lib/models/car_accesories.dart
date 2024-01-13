
import 'package:json_annotation/json_annotation.dart';
part 'car_accesories.g.dart';

@JsonSerializable()
class DodatnaOprema{
  int? opremaId;
  bool? klima;
  bool? tempomat;
  bool? parkingSenzori;
  bool? parkingKamera;
  bool? zracniJastuk;
  bool? navigacija;
  bool? abskocinice;
  bool? alarm;
  bool? naslonjacRuka;
  bool? usbport;
  bool? bluetooth;
  bool? komandeVolan;
  bool? startStop;
  bool? podizaciStakala;

  DodatnaOprema(this.opremaId,this.klima,this.tempomat,this.parkingSenzori,this.parkingKamera,
                this.zracniJastuk,this.navigacija, this.abskocinice,this.alarm,this.naslonjacRuka,
                this.usbport,this.bluetooth,this.komandeVolan,this.startStop,this.podizaciStakala);

  factory DodatnaOprema.fromJson(Map<String,dynamic> json) => _$DodatnaOpremaFromJson(json);

  Map<String,dynamic> toJson() => _$DodatnaOpremaToJson(this);
}


