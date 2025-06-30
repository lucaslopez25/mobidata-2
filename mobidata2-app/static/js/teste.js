document.addEventListener("DOMContentLoaded", function () {
    var map = L.map('map').setView([-12.9714, -38.5014], 12); // Centro de Salvador

    L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
        maxZoom: 18,
        attribution: '&copy; OpenStreetMap contributors'
    }).addTo(map);

    // Os dados são passados pelo template como variável global `window.pontos`
    /*
    if (window.pontos) {
        window.pontos.forEach(function (ponto) {
            L.marker([ponto.lat, ponto.lng])
                .addTo(map)
                .bindPopup(`<b>${ponto.nome}</b>`);
        });
    }
    */
});