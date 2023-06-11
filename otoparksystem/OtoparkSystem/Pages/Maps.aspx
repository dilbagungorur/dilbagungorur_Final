﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Maps.aspx.cs" Inherits="OtoparkSystem.Pages.Maps" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
   
<meta charset="utf-8" />
<title>İ S P A R K</title>
<meta name="viewport" content="initial-scale=1,maximum-scale=1,user-scalable=no" />
  <script src="https://cdn.maptiler.com/maplibre-gl-js/v2.1.1/maplibre-gl.js"></script>
    <script src="ispark.js"></script>
    <script src="aciktotopark.js"></script>
 <%-- <script src="C:\Users\Mazlum\Desktop\KAPALI OTOPARK\projeler\YENİ PROJE4\ispark.js"></script>
  <script src="C:\Users\Mazlum\Desktop\KAPALI OTOPARK\projeler\YENİ PROJE4\aciktotopark.js"></script>--%>
  <link href="https://cdn.maptiler.com/maplibre-gl-js/v2.1.1/maplibre-gl.css" rel="stylesheet" />
    
<style>
	body { margin: 0; padding: 0; }
	#map { position: absolute; top: 20px; bottom: 0; left: 0; right: 0; }
  #menu {height: 20px;}

  
  .calculation-box {
height: 75px;
width: 150px;
position: absolute;
bottom: 40px;
left: 10px;
background-color: rgba(255, 255, 255, 0.9);
padding: 15px;
text-align: center;
}
 
p {
font-family: 'Open Sans';
margin: 0;
font-size: 13px;
}

</style>









</head>
<body>
    <asp:HiddenField runat="server" ID="hdnValue" ClientIDMode="Static" />
   <div id="map"></div>  
<div id="menu">
  
  <!-- See a list of Mapbox-hosted public styles at -->
  <!-- https://docs.mapbox.com/api/maps/styles/#mapbox-styles --> 
  <!-- farklı haritalar ekleme -->
  <input id=https://api.maptiler.com/maps/streets/style.json?key=jpWMWTtk3xgoW1jGpIqM type="radio" name="rtoggle" value="satellite" checked="checked">
  <label for="satellite-v9">home</label>

  <input id=https://api.maptiler.com/maps/winter/style.json?key=jpWMWTtk3xgoW1jGpIqM type="radio" name="rtoggle" value="satellite" >
  <label for="satellite-v9">winter</label>

  <input id=https://api.maptiler.com/maps/bright/style.json?key=jpWMWTtk3xgoW1jGpIqM type="radio" name="rtoggle" value="bright"> 
  <label for="light-v10">bright</label>
  
  <input id=https://api.maptiler.com/maps/toner/style.json?key=jpWMWTtk3xgoW1jGpIqM type="radio" name="rtoggle" value="dark">
  <label for="dark-v10">dark</label>
 
  <input id="https://api.maptiler.com/maps/hybrid/style.json?key=jpWMWTtk3xgoW1jGpIqM" type="radio" name="rtoggle" value="hybrid">
  <label for="streets-v11">Hybrid</label>
  
  <input id=https://api.maptiler.com/maps/outdoor/style.json?key=jpWMWTtk3xgoW1jGpIqM type="radio" name="rtoggle" value="outdoors">
  <label for="outdoors-v11">outdoors</label>
  <!--alan hesaplama poligon-->
  </div>
  <script src="https://api.tiles.mapbox.com/mapbox.js/plugins/turf/v3.0.11/turf.min.js"></script>
  <script src="https://api.mapbox.com/mapbox-gl-js/plugins/mapbox-gl-draw/v1.2.0/mapbox-gl-draw.js"> </script>
  <link
  rel="stylesheet"
  href="https://api.mapbox.com/mapbox-gl-js/plugins/mapbox-gl-draw/v1.2.0/mapbox-gl-draw.css"
  type="text/css"
  />
 
  <div class="calculation-box">
  <p>  Çizim araçlarını kullanarak bir çokgen çizin.</p>
  <div id="calculated-area"></div>
  </div>
<script>


    var bounds = [
        [26.327960, 40.242969], // Southwest coordinates// harita sınırı belirleme
        [30.796904, 41.689422] // Northeast coordinates
    ];
    maplibregl.setRTLTextPlugin('https://cdn.maptiler.com/mapbox-gl-js/plugins/mapbox-gl-rtl-text/v0.2.3/mapbox-gl-rtl-text.js');
    var map = new maplibregl.Map({
        container: 'map',
        style: 'https://api.maptiler.com/maps/streets/style.json?key=jpWMWTtk3xgoW1jGpIqM',
        center: [28.84861911179467, 40.99309238186496],
        zoom: 7,
        maxBounds: bounds // Sets bounds as maxv harita sınırının max değeri
    });
    map.addControl(new maplibregl.NavigationControl()); //haritaya pusula ve yakınlaştırma/uzaklaştırma eklendi.

    map.addControl(
        new maplibregl.GeolocateControl({
            positionOptions: {
                enableHighAccuracy: true
            },
            trackUserLocation: true
        })
    );

    const layerList = document.getElementById('menu');
    const inputs = layerList.getElementsByTagName('input');

    for (const input of inputs) {
        input.onclick = (layer) => {
            const layerId = layer.target.id;
            map.setStyle(layerId);
        };
    }

    let isparkData;
    let acikotoparkData;
    var sınır = {
        "type": "FeatureCollection", "features": [{
            "type": "Feature", "geometry": {
                "type": "Polygon", "coordinates": [[
                    [29.13744238, 41.21171059], [29.1469617, 41.21201532], [29.14898709, 41.21750023], [29.15546833, 41.21917609],
                    [29.16134196, 41.21734789], [29.16377244, 41.22481275], [29.17551969, 41.22420342], [29.18767202, 41.22069958],
                    [29.20326753, 41.22176598], [29.21562238, 41.22526977], [29.21319192, 41.23181982], [29.22088841, 41.22999195],
                    [29.22858488, 41.22938266], [29.2411423, 41.22892568], [29.24620577, 41.23227677], [29.2557251, 41.23562767],
                    [29.25856065, 41.2318198], [29.27334598, 41.22938267], [29.28894148, 41.22420342], [29.31810708, 41.21917611],
                    [29.35496917, 41.21262479], [29.37157735, 41.21232007], [29.38879316, 41.21506257], [29.42930095, 41.20378708],
                    [29.48586861, 41.18837818], [29.57944287, 41.17335641], [29.59968336, 41.17579546], [29.61190077, 41.18160317],
                    [29.65343983, 41.16835759], [29.69442064, 41.16500914], [29.71992826, 41.15885336], [29.77202474, 41.16121575],
                    [29.81509539, 41.14626497], [29.84697029, 41.14192889], [29.91652869, 41.14252941], [29.91517164, 41.12685719],
                    [29.90929096, 41.11901967], [29.91471929, 41.10913624], [29.91969522, 41.09891044], [29.95497917, 41.10095574],
                    [29.96357399, 41.09209236], [29.95633626, 41.08015901], [29.93100419, 41.08663739], [29.90476738, 41.08766023],
                    [29.89391076, 41.09175144], [29.88893483, 41.07913605], [29.89300606, 41.07129284], [29.89526785, 41.06140222],
                    [29.88893483, 41.05901461], [29.88124475, 41.05321578], [29.87988766, 41.04195773], [29.86857869, 41.03752221],
                    [29.85998387, 41.02830903], [29.85048435, 41.02319004], [29.83685823, 41.01721665], [29.81700981, 41.01431621],
                    [29.7998202, 41.01772937], [29.7867018, 41.02045977], [29.77629754, 41.02455517], [29.76136972, 41.02455517],
                    [29.74598951, 41.03001529], [29.73468055, 41.03445131], [29.73205638, 41.04271956], [29.7202051, 41.02523772],
                    [29.70799143, 41.02796781], [29.69939661, 41.0228488], [29.71206263, 41.0139749], [29.71975275, 41.00373429],
                    [29.71161028, 40.99622348], [29.69849188, 40.9928092], [29.6881071, 40.97894376], [29.67677869, 40.96241436],
                    [29.6600414, 40.96343913], [29.63968526, 40.96685493], [29.61390084, 40.97744279], [29.60394893, 40.98700452],
                    [29.6120914, 41.00168597], [29.59942534, 41.00271014], [29.5958065, 41.01499887], [29.59852064, 41.02523772],
                    [29.56142725, 41.03615741], [29.54468996, 41.0341101], [29.52795271, 41.03138027], [29.52116733, 41.04332247],
                    [29.51257251, 41.03854584], [29.50307296, 41.02489646], [29.49402578, 41.00851345], [29.50623949, 40.99383354],
                    [29.50623949, 40.98632163], [29.49673996, 40.98188237], [29.485431, 40.97436909], [29.48588335, 40.96343915],
                    [29.46914606, 40.95284906], [29.45512295, 40.95011584], [29.44064749, 40.93986532], [29.45228995, 40.92066885],
                    [29.45228995, 40.90455282], [29.43117347, 40.899776], [29.41979364, 40.88920055], [29.40049893, 40.87000514],
                    [29.37308017, 40.8661654], [29.36694, 40.84353489], [29.37279367, 40.83829932], [29.36555594, 40.82426618],
                    [29.3637465, 40.81502322], [29.35243754, 40.82426618], [29.34474746, 40.81365378], [29.32574841, 40.81433847],
                    [29.30765405, 40.81057245], [29.28909941, 40.81041102], [29.26829885, 40.81023006], [29.25594339, 40.79666868],
                    [29.25689213, 40.83400362], [29.26089652, 40.85567467], [29.25937497, 40.86171629], [29.2441595, 40.87005857],
                    [29.23008521, 40.86804501], [29.20954432, 40.88012544], [29.1847925, 40.88422897], [29.17099355, 40.888049],
                    [29.15982295, 40.89649332], [29.13925596, 40.90072324], [29.115539, 40.92868246], [29.08328391, 40.95161446],
                    [29.05008016, 40.96021198], [29.03197702, 40.96642179], [29.0196572, 40.97890571], [29.01782507, 40.9867138],
                    [29.01446532, 40.99403536], [29.02127365, 40.99293418], [29.01754527, 40.99782815], [29.00700858, 41.00578007],
                    [29.00944013, 41.01336409], [29.007657, 41.01788962], [29.00587387, 41.02473848], [29.02597462, 41.03537726],
                    [29.03845655, 41.04173525], [29.05029006, 41.04931513], [29.05077637, 41.05640518], [29.05482348, 41.06400946],
                    [29.05547484, 41.07202458], [29.06647796, 41.07789998], [29.06810499, 41.09332946], [29.06452837, 41.09611521],
                    [29.06478103, 41.09995934], [29.06655376, 41.10313605], [29.08160722, 41.11037811], [29.09031802, 41.11521388],
                    [29.09719496, 41.12039469], [29.09398574, 41.12937381], [29.08298262, 41.13317229], [29.08023185, 41.14042332],
                    [29.07106259, 41.14456638], [29.07610567, 41.15250659], [29.07243796, 41.1642425], [29.08665034, 41.1718352],
                    [29.08756725, 41.18011714], [29.10544731, 41.18287755], [29.11507503, 41.18839804], [29.11965966, 41.1977128],
                    [29.12607814, 41.20461176], [29.13744238, 41.21171059]]]
            }, "id": "7be42664-ea1b-4d0b-b7d9-f2a687fc5d3c", "properties": { "name": "" }
        }, {
            "type": "Feature", "geometry":
            {
                "type": "Polygon", "coordinates": [[[28.93740412, 40.99999573], [28.94802051, 40.99427241], [28.95560366, 41.00171262],
                [28.9783531, 41.00056805], [28.98896948, 41.00943813], [28.98783203, 41.01716272], [28.97873225, 41.02288406],
                [28.99541517, 41.03346721], [29.01133977, 41.04290481], [29.03371006, 41.05005361], [29.03855427, 41.0605263],
                [29.04636864, 41.06775718], [29.04494785, 41.07525504], [29.04903262, 41.07900365], [29.0557814, 41.08061013],
                [29.05737978, 41.08957892], [29.05471579, 41.09613742], [29.05684698, 41.10523792], [29.06146455, 41.11246389],
                [29.07265331, 41.12236484], [29.07087732, 41.12731476], [29.06501654, 41.13092663], [29.06039896, 41.13614343],
                [29.05578138, 41.13801602], [29.05773375, 41.13924127], [29.05676593, 41.14316585], [29.05267133, 41.14709021],
                [29.04522661, 41.14927653], [29.0426954, 41.15202335], [29.03584625, 41.15594718], [29.04135534, 41.15863766],
                [29.04798116, 41.16115989], [29.05192687, 41.1640183], [29.05751041, 41.16609197], [29.05981828, 41.16990288],
                [29.07092954, 41.17292902], [29.07435412, 41.17707573], [29.07569418, 41.18245485], [29.08358559, 41.19018658],
                [29.08969027, 41.19758129], [29.09683722, 41.2028467], [29.10055958, 41.20508718], [29.10457973, 41.20542324],
                [29.11008884, 41.21113607], [29.11142888, 41.21449633], [29.10606868, 41.21953639], [29.1108333, 41.22636786],
                [29.11612313, 41.22885375], [29.11693295, 41.23245261], [29.11334397, 41.23798894], [29.09920885, 41.24529618],
                [29.08212892, 41.25393094], [29.06622279, 41.25695943], [29.0358902, 41.2575295], [29.03134032, 41.24954808],
                [28.95854213, 41.25980972], [28.90394344, 41.27804861], [28.8228038, 41.29457324], [28.77123838, 41.32647099],
                [28.67891332, 41.34198711], [28.62722692, 41.35703293], [28.51981385, 41.39986786], [28.32661422, 41.47283839],
                [28.24212411, 41.51596828], [28.19244603, 41.55340046], [28.182953, 41.56950085], [28.15700536, 41.58370374],
                [28.13548784, 41.58228359], [28.11298845, 41.56311759], [28.12009216, 41.55142313], [28.11511956, 41.52430516],
                [28.07391803, 41.50781612], [28.06752468, 41.48972653], [28.079601, 41.48600157], [28.09593953, 41.47695436],
                [28.11298845, 41.4535322], [28.11014695, 41.42903633], [28.11725067, 41.41092476], [28.10020175, 41.40239991],
                [28.09380842, 41.37575257], [28.08315285, 41.35016085], [28.08386321, 41.33522768], [28.0767595, 41.31122083],
                [28.07320765, 41.28346853], [28.0447928, 41.26424847], [27.99577717, 41.24181794], [27.99719792, 41.21937969],
                [28.01566759, 41.19907179], [28.0177987, 41.1750148], [28.0007498, 41.16325039], [27.98228014, 41.16164599],
                [27.97943867, 41.14506487], [27.97233496, 41.12045291], [27.97304532, 41.08887187], [27.97588681, 41.05352595],
                [27.97162457, 41.04173975], [27.99506681, 41.03691753], [28.01211573, 41.03048733], [28.03200612, 41.04013234],
                [28.07818025, 41.05566868], [28.12648551, 41.06316763], [28.1605833, 41.07227237], [28.20731181, 41.06785706],
                [28.23093904, 41.07828379], [28.25701343, 41.06066515], [28.39625159, 41.04512108], [28.48025034, 41.01655309],
                [28.53881477, 40.98103537], [28.63132913, 40.95126004], [28.72687682, 40.96385897], [28.76588839, 40.97545679],
                [28.82849093, 40.94782366], [28.88157295, 40.96500423], [28.91493887, 40.97874547], [28.93740412, 40.99999573]]]
            }, "id": "696aca40-6640-4959-8b7d-75826dc35509", "properties": { "name": "" }
        }]
    }


    map.on('load', async function () {


        const isparkData = document.getElementById('<%= hdnValue.ClientID %>').value
        //const isparkData = await getAndPrintResults();
        const acikotoparkData = await getAndPrintResultsacikotopark();


        map.loadImage(
            'https://cdn2.iconfinder.com/data/icons/architecture-interior/24/architecture-interior-10-32.png',
            function (error, image1) {
                if (error) throw error;
                map.addImage('ispark-marker', image1);

                map.loadImage(
                    'https://cdn2.iconfinder.com/data/icons/airport-solid-prepare-for-take-off/512/car_parking-48.png',
                    function (error, image2) {
                        if (error) throw error;
                        map.addImage('acikotopark-marker', image2)
                    });


                map.addSource('ispark', {
                    'type': 'geojson',
                    'data': isparkData,
                });

                map.addSource('acikotopark', {
                    'type': 'geojson',
                    'data': acikotoparkData,
                });


                map.addSource('istanbulİlSınırları', {
                    'type': 'geojson',
                    'data': sınır,
                })

                map.addLayer({
                    'id': 'ispark_locations',
                    'type': 'symbol',
                    'source': 'ispark',
                    'layout': {
                        'icon-image': 'ispark-marker',
                        'text-field': "{PARK_NAME}",
                        "text-offset": [0, 1.5],
                        "text-anchor": "top",
                        'text-font': ["Open Sans Semibold", "Arial Unicode MS Bold"],
                    }
                })
                map.addLayer({
                    'id': 'acikotopark_locations',
                    'type': 'symbol',
                    'source': 'acikotopark',
                    'layout': {
                        'icon-image': 'acikotopark-marker',
                        'text-field': "{PARK_NAME}",
                        "text-offset": [0, 1.5],
                        "text-anchor": "top",
                        'text-font': ["Open Sans Semibold", "Arial Unicode MS Bold"],
                    }
                })

                map.addLayer({
                    'id': 'polygons',
                    'type': 'fill',
                    'source': 'istanbulİlSınırları',
                    'layout': {},
                    'paint': {
                        'fill-color': '#FFAA01',
                        'fill-opacity': 0.5,
                    }

                    //poligon dış çizgileri çizildi.
                })
                map.addLayer({
                    'id': 'outline',
                    'type': 'line',
                    'source': 'istanbulİlSınırları',
                    'layout': {},
                    'paint': {
                        'line-color': '#000000',
                        'line-width': 4
                    }
                });

            });


        map.on('click', 'ispark_locations', function (e) {
            var coordinates = e.features[0].geometry.coordinates.slice();
            var description = e.features[0].properties;


            while (Math.abs(e.lngLat.lng - coordinates[0]) > 180) {
                coordinates[0] += e.lngLat.lng > coordinates[0] ? 360 : -360;
            }

            new maplibregl.Popup()
                .setLngLat(coordinates)
                .setHTML('<h3>' + "İsim" + '</h3><p>' + e.features[0].properties.PARK_NAME + '</p><h3>' + "Adres" + '</h3><p>' + e.features[0].properties.COUNTY_NAME + '</p><h3>' + "Çalışma Saatleri" + '</h3><p>' + e.features[0].properties.WORKING_TIME + '</p><h3>' + "Kapasite" + '</h3><p>' + e.features[0].properties.CAPACITY_OF_PARK + '</p>')
                .addTo(map);
        });



        map.on('mouseenter', 'ispark_locations', function () {
            map.getCanvas().style.cursor = 'pointer';
        });


        map.on('mouseleave', 'ispark_locations', function () {
            map.getCanvas().style.cursor = '';
        });
    });


    // Center the map on the coordinates of any clicked symbol from the 'symbols' layer.//click yaptığımızda konuma uçup merkezleme
    map.on('click', 'ispark_locations', function (e) {
        map.flyTo({
            center: e.features[0].geometry.coordinates
        });
    });

    // Change the cursor to a pointer when the it enters a feature in the 'symbols' layer.
    map.on('mouseenter', 'ispark_locations', function () {
        map.getCanvas().style.cursor = 'pointer';
    });

    // Change it back to a pointer when it leaves.
    map.on('mouseleave', 'ispark_locations', function () {
        map.getCanvas().style.cursor = '';
    });




    map.on('click', 'acikotopark_locations', function (e) {
        var coordinates = e.features[0].geometry.coordinates.slice();
        var description = e.features[0].properties;


        while (Math.abs(e.lngLat.lng - coordinates[0]) > 180) {
            coordinates[0] += e.lngLat.lng > coordinates[0] ? 360 : -360;
        }

        new maplibregl.Popup()
            .setLngLat(coordinates)
            .setHTML('<h3>' + "İsim" + '</h3><p>' + e.features[0].properties.PARK_NAME + '</p><h3>' + "Adres" + '</h3><p>' + e.features[0].properties.COUNTY_NAME + '</p><h3>' + "Çalışma Saatleri" + '</h3><p>' + e.features[0].properties.WORKING_TIME + '</p><h3>' + "Kapasite" + '</h3><p>' + e.features[0].properties.CAPACITY_OF_PARK + '</p>')
            .addTo(map);
    });



    map.on('mouseenter', 'acikotopark_locations', function () {
        map.getCanvas().style.cursor = 'pointer';
    });


    map.on('mouseleave', 'acikotopark_locations', function () {
        map.getCanvas().style.cursor = '';
    });



    // Center the map on the coordinates of any clicked symbol from the 'symbols' layer.//click yaptığımızda konuma uçup merkezleme
    map.on('click', 'acikotopark_locations', function (e) {
        map.flyTo({
            center: e.features[0].geometry.coordinates
        });
    });

    // Change the cursor to a pointer when the it enters a feature in the 'symbols' layer.
    map.on('mouseenter', 'acikotopark_locations', function () {
        map.getCanvas().style.cursor = 'pointer';
    });

    // Change it back to a pointer when it leaves.
    map.on('mouseleave', 'acikotopark_locations', function () {
        map.getCanvas().style.cursor = '';
    });





















    //çizilen bölgenin alanını bulma
    var draw = new MapboxDraw({
        displayControlsDefault: false,
        controls: {
            polygon: true,
            trash: true
        }
    });
    map.addControl(draw);

    map.on('draw.create', updateArea);
    map.on('draw.delete', updateArea);
    map.on('draw.update', updateArea);

    function updateArea(e) {
        var data = draw.getAll();
        var answer = document.getElementById('calculated-area');
        if (data.features.length > 0) {
            var area = turf.area(data);
            // restrict to area to 2 decimal points
            var rounded_area = Math.round(area * 100) / 100;
            answer.innerHTML =
                '<p><strong>' +
                rounded_area +
                '</strong></p><p>square meters</p>';
        } else {
            answer.innerHTML = '';
            if (e.type !== 'draw.delete')
                alert('Use the draw tools to draw a polygon!');
        }
    }




</script>

</body>
</html>
