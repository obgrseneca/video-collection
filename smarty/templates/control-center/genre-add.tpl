<!DOCTYPE HTML>

<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <title>Video-Collection</title>

    <link rel="stylesheet" type="text/css" href="{$javascriptDir}/jquery-ui-1.10.3.custom/css/smoothness/jquery-ui-1.10.3.custom.css" />

    <script type="text/javascript" src="{$javascriptDir}/jquery-1.10.1.js"></script>
    <script type="text/javascript" src="{$javascriptDir}/jquery-ui-1.10.3.custom/js/jquery-ui-1.10.3.custom.js"></script>
    <script type="text/javascript" src="{$javascriptDir}/sha1.js"></script>
    {literal}
    <script type="text/javascript">
        $(document).ready(function() {
            $('#addGenre').click(function() {
                $.ajax({
                    type: 'post',
                    url: '{/literal}{$baseUrl}{literal}control-center/genre/add/add.php',
                    dataType: 'json',
                    data: {
                        genreName: $('#genreName').val()
                    },
                    success: function(data) {
                        if (data) {
                            window.location = '{/literal}{$baseUrl}{literal}control-center/genre/';
                        }
                    },
                    error: function(jqXHR, textStatus, errorThrown) {
                        console.log(textStatus);
                    }
                });
            });
            $('#cancel').click(function() {
                window.location = '{/literal}{$baseUrl}{literal}control-center/genre/';
            });
        });
    </script>
    {/literal}
</head>

<body>
<h1>Video-Collection - New genre</h1>
<p>
    <label for="genreName">Genre name</label>
    <input type="text" id="genreName" /><br /><br />
    <button type="button" id="addGenre">Add genre</button>
    <button type="button" id="cancel">Cancel</button>
</p>
</body>
</html>