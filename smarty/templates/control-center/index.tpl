<!DOCTYPE HTML>

<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <title>Video-Collection</title>

    <link rel="stylesheet" type="text/css" href="{$javascriptDir}/jquery-ui-1.10.3.custom/css/smoothness/jquery-ui-1.10.3.custom.css" />

    <script type="text/javascript" src="{$javascriptDir}/jquery-1.10.1.js"></script>
    <script type="text/javascript" src="{$javascriptDir}/jquery-ui-1.10.3.custom/js/jquery-ui-1.10.3.custom.js"></script>
    <script type="text/javascript" src="{$javascriptDir}/sha1.js"></script>
    <script type="text/javascript" src="{$javascriptDir}/VcMainClass.js"></script>
    {literal}
    <script type="text/javascript">
        var vcMain;
        {/literal}var baseUrl = '{$baseUrl}';{literal}
        $(document).ready(function() {
            vcMain = new VcMainClass(baseUrl);

            vcMain.showMainView('control-center/movie/');

            $('#logoutNow').click(function() {
                vcMain.logoutNow(baseUrl + 'login/logout.php');
            });

            $('#userManagement').click(function() {
                vcMain.showMainView('control-center/user/');
            });

            $('#genreManagement').click(function() {
                vcMain.showMainView('control-center/genre/');
            });

            $('#movieManagement').click(function() {
                vcMain.showMainView('control-center/movie/');
            });

            $('#typeManagement').click(function() {
                vcMain.showMainView('control-center/type/');
            });

            $('#storageManagement').click(function() {
                vcMain.showMainView('control-center/storage/');
            });
        });
    </script>
    {/literal}
</head>

<body>
<h1>Video-Collection - Control-Center</h1>
<div id="menuContainer">
    {if $userType == 'Administrator' OR $userType == 'Standard'}
        <a href="#" id="movieManagement">Movie management</a><br />
        <a href="#" id="userManagement">User management</a><br />
        <a href="#" id="genreManagement">Genre management</a><br />
        <a href="#" id="typeManagement">Type management</a><br />
        <a href="#" id="storageManagement">Storage management</a><br /><br />
    {/if}
    <button type="button" id="logoutNow">Log out</button>
</div>
<div id="mainContainer" style="display: none;">
</div>
</body>
</html>