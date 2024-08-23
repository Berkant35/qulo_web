/// [en] It is an enumeration used to determine the order of the pads in the game.
/// [tr] Sıralama tipini belirliyoruz padlerin sıralı mı gitsin rasgele mi gitsin
/// sequential yaptığında kullanıcı belirleyecek sırayı
/// custom belki ileride özel modlar olur ona göre hazır seçilir vs diye yaptım
enum ChallengeType {
  sequential,
  random,
  custom
}