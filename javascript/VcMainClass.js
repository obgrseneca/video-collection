function VcMainClass(baseUrl) {
    this.baseUrl = baseUrl;
}

VcMainClass.prototype.showMainView = function(urlPart) {
    $.ajax({
        type: 'get',
        url: this.baseUrl + urlPart,
        dataType: 'text',
        success: function(data) {
            $('#mainContainer').html(data).css({display: 'block'});
        },
        error: function(jqXHR, textStatus, errorThrown) {
            console.log(textStatus);
            console.log(jqXHR);
            console.log(errorThrown);
        }
    });
};

VcMainClass.prototype.logoutNow = function(logoutUrl) {
    $.ajax({
        type: 'get',
        url: logoutUrl,
        dataType: 'json',
        success: function(data) {
            window.location = this.baseUrl;
        },
        error: function(jqXHR, textStatus, errorThrown) {
            console.log(textStatus);
        }
    });
};