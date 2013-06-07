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
            $('#logoutNow').click(function() {
                $.ajax({
                    type: 'get',
                    url: '{/literal}{$baseUrl}{literal}login/logout.php',
                    dataType: 'json',
                    success: function(data) {
                        window.location = '{/literal}{$baseUrl}{literal}';
                    },
                    error: function(jqXHR, textStatus, errorThrown) {
                        console.log(textStatus);
                    }
                });
            })
        });
    </script>
    {/literal}
</head>

<body>
<h1>Video-Collection - Control-Center</h1>
<p>
    Logged in!<br />
    {if $userType != 'Guest'}
        <a href="{$baseUrl}control-center/user/">User management</a><br /><br />
    {/if}
    <button type="button" id="logoutNow">Log out</button>
</p>
</body>
</html>