$('.x').on('click', function() {
  $('.stanga').hide();
  $('.stangaContent').html('');
});
var map = L.map('map', {
  center: [10.0, 5.0],
  minZoom: 2,
  zoom: 2
});

L.tileLayer('http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
  attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a>',
  subdomains: ['a', 'b', 'c']
}).addTo(map);

var myURL = jQuery('script[src$="leaf-demo.js"]').attr('src').replace('leaf-demo.js', '');

var myIcon = [L.icon({
      iconUrl: myURL + 'pins/black.png',
      iconRetinaUrl: myURL + 'pins/black.png',
      iconSize: [24, 24],
      iconAnchor: [9, 21],
      popupAnchor: [0, -14]
  }),
  L.icon({
      iconUrl: myURL + 'pins/blue.png',
      iconRetinaUrl: myURL + 'pins/blue.png',
      iconSize: [24, 24],
      iconAnchor: [9, 21],
      popupAnchor: [0, -14]
  }),
  L.icon({
      iconUrl: myURL + 'pins/darkred.png',
      iconRetinaUrl: myURL + 'pins/darkred.png',
      iconSize: [24, 24],
      iconAnchor: [9, 21],
      popupAnchor: [0, -14]
  }),
  L.icon({
      iconUrl: myURL + 'pins/grey.png',
      iconRetinaUrl: myURL + 'pins/grey.png',
      iconSize: [24, 24],
      iconAnchor: [9, 21],
      popupAnchor: [0, -14]
  }),
  L.icon({
      iconUrl: myURL + 'pins/lightblue.png',
      iconRetinaUrl: myURL + 'pins/lightblue.png',
      iconSize: [24, 24],
      iconAnchor: [9, 21],
      popupAnchor: [0, -14]
  }),
  L.icon({
      iconUrl: myURL + 'pins/red.png',
      iconRetinaUrl: myURL + 'pins/red.png',
      iconSize: [24, 24],
      iconAnchor: [9, 21],
      popupAnchor: [0, -14]
  })
];

var markerClusters = L.markerClusterGroup({
  iconCreateFunction: function(cluster) {
      var mks = cluster.getAllChildMarkers();
      var cnt = [0, 0, 0, 0, 0, 0];
      mks.forEach(function(entry) {
          cnt[entry.options.tip]++;
      });
      mx = 0;
      ctmx = 0;
      for (var i = 0; i < 6; ++i) {
          if (ctmx < cnt[i]) {
              mx = i;
              ctmx = cnt[i];
          }
      }
      if (mx == 0) {
          return L.divIcon({ html: '<b>' + cluster.getChildCount() + '</b>', className: 'mycluster cluster6', iconSize: L.point(60, 60) });
      } else if (mx == 1) {
          return L.divIcon({ html: '<b>' + cluster.getChildCount() + '</b>', className: 'mycluster cluster5', iconSize: L.point(60, 60) });
      } else if (mx == 2) {
          return L.divIcon({ html: '<b>' + cluster.getChildCount() + '</b>', className: 'mycluster cluster4', iconSize: L.point(60, 60) });
      } else if (mx == 3) {
          return L.divIcon({ html: '<b>' + cluster.getChildCount() + '</b>', className: 'mycluster cluster3', iconSize: L.point(60, 60) });
      } else if (mx == 4) {
          return L.divIcon({ html: '<b>' + cluster.getChildCount() + '</b>', className: 'mycluster cluster2', iconSize: L.point(60, 60) });
      } else {
          return L.divIcon({ html: '<b>' + cluster.getChildCount() + '</b>', className: 'mycluster cluster1', iconSize: L.point(60, 60) });
      }

  }
});
markerClusters.on('clusterclick', function(e) {
  var mks = e.layer.getAllChildMarkers();
  var txt = '';
  var i = 3; // maxim 100
  mks.forEach(function(entry) {
      if (i > 0) {
          var pp = entry.getPopup();
          var ct = '<div class = "container">' + pp.getContent(i) + '</div>';
          txt = txt + '<div style="font-size:30px;">' + ct + '</div>';
          i--;
      }
  });

  $('.stanga').show();
  $('.stangaContent').html(txt);
});

var x = $('#markers');
var markers = JSON.parse($('#markers')[0].innerHTML);

for (var i = 0; i < markers.length; ++i) {
  if (markers[i].latitude >= 90 || markers[i].latitude <= -90) {
      console.log("latitudine incorecta");
  }
  if (markers[i].longitude >= 180 || markers[i].longitude <= -180) {
      console.log("longitudine incorecta");
  }

  var text = markers[i].text.indexOf('RT') != -1 ? markers[i].text.split(':')[1] : markers[i].text;

  var popup = '<div class="up">' +
      '<img src="' + markers[i].pictureURL + '" class="profilePic">' +
      '<div class="tweeterInfos">' +
      '<p class="tweeterAccount">' + markers[i].username + '</p>' +
      '<p class="atTweeter"> @' + markers[i].screenname + '</p>' +
      '</div>' +
      '<img src = "maps/images/tweet.png" class="tweetPic" >' +
      '</div>' +
      '<div class = "tweetContent">' +
      '<p> ' + text + '</p>'
  '</div>';

  var m = L.marker([markers[i].latitude, markers[i].longitude], {
          icon: myIcon[parseInt(markers[i].ID) % 6 + 1],
          tip: parseInt(markers[i].ID) % 6 + 1
      })
      .bindPopup(popup).on('popupopen', function(e) {
          var ct = e.popup._content;
          $('.stanga').show();
          $('.stangaContent').html('<div class="container">' + ct + '</div>');
      }).on('popupclose', function() {
          $('.stanga').hide();
          $('.stangaContent').html('');
      });

  markerClusters.addLayer(m);
}

map.addLayer(markerClusters);