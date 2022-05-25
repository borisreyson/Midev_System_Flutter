class CounterHazard {
  int? waiting;
  int? approve;
  int? cancel;
  int? allWaiting;
  int? allDisetujui;
  int? allDibatalkan;

  CounterHazard(
      {this.waiting,
      this.approve,
      this.cancel,
      this.allWaiting,
      this.allDisetujui,
      this.allDibatalkan});

  CounterHazard.fromJson(Map<String, dynamic> json) {
    waiting = json['waiting'];
    approve = json['approve'];
    cancel = json['cancel'];
    allWaiting = json['allWaiting'];
    allDisetujui = json['allDisetujui'];
    allDibatalkan = json['allDibatalkan'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['waiting'] = waiting;
    data['approve'] = approve;
    data['cancel'] = cancel;
    data['allWaiting'] = allWaiting;
    data['allDisetujui'] = allDisetujui;
    data['allDibatalkan'] = allDibatalkan;
    return data;
  }
}
