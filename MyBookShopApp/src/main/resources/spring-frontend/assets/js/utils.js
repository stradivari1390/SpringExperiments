$(document).ajaxSend(function(event, xhr, options) {
    var token = localStorage.getItem('jwtToken');
    if (token) {
        xhr.setRequestHeader('Authorization', 'Bearer ' + token);
    }
});