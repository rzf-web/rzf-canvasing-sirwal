enum CustomerType {
  member,
  nonMember;

  static CustomerType fromJson(String json) {
    switch (json.toLowerCase()) {
      case 'member':
        return CustomerType.member;
      default:
        return CustomerType.nonMember;
    }
  }

  bool get isMember => this == CustomerType.member;
}
