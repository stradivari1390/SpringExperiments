document.addEventListener('DOMContentLoaded', function () {
    const downloadButton = document.getElementById('downloadButton');
    const myPopup = document.getElementById('myPopup');
    const myPopupClose = document.getElementById('myPopup__close');
    const myOverlay = document.getElementById('myOverlay');

    downloadButton.addEventListener('click', function (event) {
        event.preventDefault();
        myPopup.style.display = 'block';
        myOverlay.style.display = 'block';
    });

    myPopupClose.addEventListener('click', function () {
        myPopup.style.display = 'none';
        myOverlay.style.display = 'none';
    });

    myOverlay.addEventListener('click', function () {
        myPopup.style.display = 'none';
        myOverlay.style.display = 'none';
    });
});