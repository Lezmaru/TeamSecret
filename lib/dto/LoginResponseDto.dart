class LoginResponseDto {
  final String? username;
  final String? password;

  LoginResponseDto({
    this.username,
    this.password,
  });

  factory LoginResponseDto.fromJson(Map<String, dynamic> json) {
    return LoginResponseDto(
      username: json['username'] as String?,
      password: json['password'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['password'] = password;
    return data;
  }
}
