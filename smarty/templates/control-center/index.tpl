<!DOCTYPE HTML>

<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <title>Video-Collection</title>

    <link rel="stylesheet" type="text/css" href="{$javascriptDir}/jquery-ui-1.10.3.custom/css/smoothness/jquery-ui-1.10.3.custom.css" />
    <link rel="stylesheet" type="text/css" href="{$baseUrl}style.css" />

    <script type="text/javascript" src="{$javascriptDir}/jquery-1.10.1.js"></script>
    <script type="text/javascript" src="{$javascriptDir}/jquery-ui-1.10.3.custom/js/jquery-ui-1.10.3.custom.js"></script>
    <script type="text/javascript" src="{$javascriptDir}/DataTables-1.9.4/media/js/jquery.dataTables.js"></script>
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
                vcMain.logoutNow('login/logout.php');
            });

            $('#userManagement').click(function() {
                vcMain.showMainView('control-center/user/');
            });

            $('#genreManagement').click(function() {
                vcMain.showMainView('control-center/genre/');
            });

            $('#actorManagement').click(function() {
                vcMain.showMainView('control-center/actor/');
            });

            $('#directorManagement').click(function() {
                vcMain.showMainView('control-center/director/');
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
        <ul class="mainMenu">
            <li id="movieManagement">Movie management</li>
            <li id="genreManagement">Genre management</li>
            <li id="actorManagement">Actor management</li>
            <li id="directorManagement">Director management</li>
            <li id="typeManagement">Type management</li>
            <li id="storageManagement">Storage management</li>
            <li id="userManagement">User management</li>
            <li id="logoutNow">Log out</li>
        </ul>
    {else}
        <ul class="mainMenu">
            <li id="logoutNow">Log out</li>
        </ul>
    {/if}
</div>
<div id="mainContainer" style="display: none;">
</div>
</body>
</html>