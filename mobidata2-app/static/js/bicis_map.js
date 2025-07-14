const map1 = L.map('map1').setView([-12.97, -38.45], 13);

//Estações Bicicletas GEOJSON
L.tileLayer('https://tile.openstreetmap.org/{z}/{x}/{y}.png', {
	attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
}).addTo(map1);

fetch('/static/geojson/estacoes_bicicletas.geojson').then(res => res.json())
	.then(data => {
		L.geoJSON(data, {
			style: {
				color: 'blue',
				weight: 4
			},
			onEachFeature: function (feature, layer) {
				if (feature.properties && feature.properties.name) {
					layer.bindPopup(feature.properties.name);
				}
			}
		}).addTo(map1);
	});
	

const map2 = L.map('map2').setView([-12.92, -38.43], 12);

L.tileLayer('https://tile.openstreetmap.org/{z}/{x}/{y}.png', {
	attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
}).addTo(map2);

fetch('/static/geojson/ciclovias.geojson').then(res => res.json())
	.then(data => {
		L.geoJSON(data, {
			style: {
				color: 'blue',
				weight: 4
			},
			onEachFeature: function (feature, layer) {
				if (feature.properties && feature.properties.name) {
					layer.bindPopup(feature.properties.name);
				}
			}
		}).addTo(map2);
	});

const map3 = L.map('map3').setView([-12.97, -38.45], 13);

L.tileLayer('https://tile.openstreetmap.org/{z}/{x}/{y}.png', {
	attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
}).addTo(map3);

fetch('/static/geojson/infraestrutura_msvb/bicicletarios.geojson').then(res => res.json())
	.then(data => {
		L.geoJSON(data, {
			style: {
				color: 'blue',
				weight: 4
			},
			onEachFeature: function (feature, layer) {
				if (feature.properties && feature.properties.name) {
					layer.bindPopup(feature.properties.name);
				}
			}
		}).addTo(map3);
	});