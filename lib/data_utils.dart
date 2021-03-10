abstract class DataUtils {
  static String getUserImage(String userName) {
    return _getImageUrl(userName);
  }

  static String getChannelImage() => _getImageUrl('');

  static String _getImageUrl(String value) =>
      'https://ui-avatars.com/api/?rounded=true&name=$value&random=true';
}
