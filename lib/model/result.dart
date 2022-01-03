class Result {
  int id;
  int corrAns;
  int totalCb;
  int protCb;
  int deutCb;
  double corrAnsPer;
  double totalCbPer;
  double protCbPer;
  double deutCbPer;


  Result(this.id, this.corrAns, this.totalCb, this.protCb, this.deutCb,
      this.corrAnsPer, this.totalCbPer, this.protCbPer, this.deutCbPer);

  Map<String, Object> toMap() {
    var map = <String, Object>{
      'user_id': id.toString(),
      'corr_ans': corrAns.toString(),
      'total_cb': totalCb.toString(),
      'prot_cb': protCb.toString(),
      'deut_cb': deutCb.toString(),
      'corr_ans_per': corrAnsPer.toString(),
      'total_cb_per': totalCbPer.toString(),
      'prot_cb_per': protCbPer.toString(),
      'deut_cb_per': deutCbPer.toString()
    };
    return map;
  }

  Result.fromMapObject(Map<String, dynamic> map) {
    this.id = map['user_id'];
    this.corrAns = map['corr_ans'];
    this.totalCb = map['total_cb'];
    this.protCb = map['prot_cb'];
    this.deutCb = map['deut_cb'];
    this.corrAnsPer = map['corr_ans_per'];
    this.totalCbPer = map['total_cb_per'];
    this.protCbPer = map['prot_cb_per'];
    this.deutCbPer = map['deut_cb_per'];
  }

}
