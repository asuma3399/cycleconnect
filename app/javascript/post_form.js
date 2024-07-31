<script>
document.addEventListener("DOMContentLoaded", function() {
  const imageInput = document.querySelector('input[type="file"][name="post[image]"]');
  imageInput.addEventListener('change', function(event) {
    const file = event.target.files[0];
    if (file) {
      EXIF.getData(file, function() {
        const lat = EXIF.getTag(this, "GPSLatitude");
        const lon = EXIF.getTag(this, "GPSLongitude");

        if (lat && lon) {
          // 緯度と経度を度数で取得
          const latitude = convertDMSToDD(lat[0], lat[1], lat[2], EXIF.getTag(this, "GPSLatitudeRef"));
          const longitude = convertDMSToDD(lon[0], lon[1], lon[2], EXIF.getTag(this, "GPSLongitudeRef"));

          // マップを更新する関数（後で定義）
          updateMap(latitude, longitude);
        }
      });
    }
  });

  // 度、分、秒を度数に変換する関数
  function convertDMSToDD(degrees, minutes, seconds, direction) {
    let dd = degrees + minutes / 60 + seconds / (60 * 60);
    if (direction == "S" || direction == "W") {
      dd = dd * -1;
    }
    return dd;
  }
});
</script>