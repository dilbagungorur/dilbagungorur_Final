// Fetches the Json result and returns it
async function fetchresults(url){
	let response = await fetch(url, {
		headers: {
		  'X-Master-Key': '$2b$10$f6xDF6.Xd8./3xX7KoZ3E.PA58hY.dvwcfdiMShGHeMku1RbnDAHG'
		}});
	let result = await response.json(); 
	return result;
}


async function toGeoJson(json){
	// GeoJson'ı başlat
	let geoJson = '{ "type": "FeatureCollection", "features": [';
	let lat;
	let lon;
	let _id;
	let park_name;
	let location_name;
	let park_type_id;
	let park_type_desc;
	let capacity_of_park;
	let working_time;
	let county_name;
	let rank;

	// Her eleman için
	json.forEach(element => {
			// Koordinatlarını lat ve lon içerisine al
			lat = element['LATITUDE'];
			lon = element['LONGITUDE'];
			// Özelliklerini de birer değişkene ver(Burda sadece isim aldım örnek olarak) 
			_id = element['_id'];
			park_name = element['PARK_NAME'];
			location_name = element['LOCATION_NAME'];
			park_type_id = element['PARK_TYPE_ID'];
			park_type_desc = element['PARK_TYPE_DESC'];
			capacity_of_park = element['CAPACITY_OF_PARK'];
			working_time = element['WORKING_TIME'];
			county_name = element ['COUNTY_NAME'];
			rank = element['rank'];
			// Sonra bunları geojson'a birer feature olarak ekle
            geoJson += '{ "type": "Feature","geometry": { "type": "Point", "coordinates":[' + lon + ',' + lat + ']},"properties": {"PARK_NAME":' + '"' + park_name + '"' + "," + '"LOCATION_NAME":' + '"' + location_name + '"' + "," + '"PARK_TYPE_ID":' + '"' + park_type_id + '"' + "," + '"PARK_TYPE_DESC":' + '"' + park_type_desc + '"' + "," + '"CAPACITY_OF_PARK":' + '"' + capacity_of_park + '"' + "," + '"WORKING_TIME":' + '"' + working_time + '"' + "," + '"COUNTY_NAME":' + '"' + county_name + '"' + "," + '"rank":' + '"' + rank + '"' + "} },";
		});
	// En son elemandan sonraki virgülü kaldır
	geoJson = geoJson.slice(0, -1);
	// GeoJson'ı kapat
	geoJson += "]}";
	// Içerisinde linebreak(yeni satır) varsa kaldır
	geoJson = geoJson.replaceAll("\r\n" , ""); 
	// Json olarak geri çevir
	return JSON.parse(geoJson);
}


// Gets the result, converts it to geojson and prints it
async function getAndPrintResultsacikotopark(){
    let url = 'https://api.jsonbin.io/v3/b/62fa3934a1610e6386ff206a';
    let response = await fetchresults(url);
    let geoJson = await toGeoJson(response.record.result.records);
	return(geoJson);
	
}