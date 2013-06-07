<!DOCTYPE HTML>

<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <title>Video-Collection</title>

    <link rel="stylesheet" type="text/css" href="{$javascriptDir}/jquery-ui-1.10.3.custom/css/smoothness/jquery-ui-1.10.3.custom.css" />

    <script type="text/javascript" src="{$javascriptDir}/jquery-1.10.1.js"></script>
    <script type="text/javascript" src="{$javascriptDir}/jquery-ui-1.10.3.custom/js/jquery-ui-1.10.3.custom.js"></script>
    <script type="text/javascript" src="{$javascriptDir}/sha1.js"></script>
    <script type="text/javascript" src="{$javascriptDir}/vc-main.js"></script>
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
<div id="menu">
    {if $userType == 'Administrator' OR if $userType == 'Standard'}
        <a href="{$baseUrl}control-center/user/">User management</a><br />
        <a href="{$baseUrl}control-center/genre/">Genre management</a><br /><br />
    {/if}
    <a href="{$baseUrl}control-center/genre/">Genre management</a><br /><br />
    <button type="button" id="logoutNow">Log out</button>
</div>
<div id="main">
</div>
</body>
</html>