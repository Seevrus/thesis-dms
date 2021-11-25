import React from 'react';

// react-bootstrap components
function Maps() {
  const mapRef = React.useRef(null);
  React.useEffect(() => {
    const { google } = window;
    let map = mapRef.current;
    const lat = '40.748817';
    const lng = '-73.985428';
    const myLatlng = new google.maps.LatLng(lat, lng);
    const mapOptions = {
      zoom: 13,
      center: myLatlng,
      scrollwheel: false,
      zoomControl: true,
    };

    map = new google.maps.Map(map, mapOptions);

    const marker = new google.maps.Marker({
      position: myLatlng,
      map,
      animation: google.maps.Animation.DROP,
      title: 'Light Bootstrap Dashboard PRO React!',
    });

    const contentString = '<div class="info-window-content"><h2>Light Bootstrap Dashboard PRO React</h2>'
      + '<p>A premium Admin for React-Bootstrap, Bootstrap, React, and React Hooks.</p></div>';

    const infowindow = new google.maps.InfoWindow({
      content: contentString,
    });

    google.maps.event.addListener(marker, 'click', () => {
      infowindow.open(map, marker);
    });
  }, []);
  return (
    <>
      <div className="map-container">
        <div id="map" ref={mapRef} />
      </div>
    </>
  );
}

export default Maps;
