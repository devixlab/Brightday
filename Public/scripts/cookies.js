function cookiesConfirmed() {
    // Hide the cookie message.
    
    $('#cookie-msg').hide();
    
    // Create a date that's one year in the future. Then, create the expires string required for the cookie.
    var d =  new Date();
    d.setTime(d.getTime() + (365*24*60*60*1000));
    var expires = "expires="+ d.toUTCString();
    
    // Add a cookie called cookies-accepted to the page using JavaScript.
    document.cookie = "cookies-accepted=true;" + expires;
}
