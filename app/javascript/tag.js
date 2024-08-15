document.addEventListener("turbo:load", () => {
  const tagNameInput = document.querySelector("#post_form_tag_name");
  if (tagNameInput) {
    const inputElement = document.getElementById("post_form_tag_name");
    inputElement.addEventListener("input", () => {
      const keyword = document.getElementById("post_form_tag_name").value;
      const XHR = new XMLHttpRequest();
      XHR.open("GET", `/posts/search/?keyword=${keyword}`, true);
      XHR.responseType = "json";
      XHR.send();
      XHR.onload = () => {
        const searchResult = document.getElementById("search-result");
        searchResult.innerHTML = "";
        if (XHR.response) {
          const tagName = XHR.response.keyword;
          tagName.forEach((tag) => {
            const childElement = document.createElement("div");
            childElement.setAttribute("class", "child");
            childElement.setAttribute("id", tag.id);
            childElement.innerHTML = tag.tag_name;
            searchResult.appendChild(childElement);
            const clickElement = document.getElementById(tag.id);
            clickElement.addEventListener("click", () => {
              document.getElementById("post_form_tag_name").value = clickElement.textContent;
              clickElement.remove();
            });
          });
        }
      };
    });
  }

  if (!window.map) {
    window.map = L.map('map').setView([35.681236, 139.767125], 13);

    L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
      attribution: '© OpenStreetMap contributors'
    }).addTo(window.map);

    let marker;

    window.map.on('click', function(e) {
      const coord = e.latlng;
      const lat = coord.lat;
      const lng = coord.lng;
      if (marker) {
        window.map.removeLayer(marker);
      }
      marker = L.marker([lat, lng]).addTo(window.map);

      document.getElementById('latitude').value = lat.toFixed(6);
      document.getElementById('longitude').value = lng.toFixed(6);
    });

    document.querySelector('input[type="file"]').addEventListener('change', function(event) {
      const file = event.target.files[0];
      if (file) {
        EXIF.getData(file, function() {
          const lat = EXIF.getTag(this, 'GPSLatitude');
          const lon = EXIF.getTag(this, 'GPSLongitude');
          if (lat && lon) {
            const latitude = lat[0] + lat[1] / 60 + lat[2] / 3600;
            const longitude = lon[0] + lon[1] / 60 + lon[2] / 3600;
            document.getElementById('latitude').value = latitude.toFixed(6);
            document.getElementById('longitude').value = longitude.toFixed(6);
            window.map.setView([latitude, longitude], 13);
            if (marker) {
              window.map.removeLayer(marker);
            }
            marker = L.marker([latitude, longitude]).addTo(window.map);
          }
        });
      }
    });
  }
});