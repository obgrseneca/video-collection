{*
* Copyright (c) 2013 Oliver Burger obgr_seneca@mageia.org
*
* This file is part of video-collection.
*
* video-collection is free software: you can redistribute it and/or modify
* it under the terms of the GNU General Public License as published by
* the Free Software Foundation, either version 3 of the License, or
* (at your option) any later version.
*
* video-collection is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
* GNU General Public License for more details.
*
* You should have received a copy of the GNU General Public License
* along with video-collection.  If not, see <http://www.gnu.org/licenses/>.
*}

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
    <script type="text/javascript" src="{$javascriptDir}/TmdbClass.js"></script>
    {literal}
    <script type="text/javascript">
        var vcMain;
        var tmdb;
        {/literal}var baseUrl = '{$baseUrl}';{literal}
        $(document).ready(function() {
            vcMain = new VcMainClass(baseUrl);
            {/literal}tmdb = new TmdbClass('{$configData.tmdbApiKey}');{literal}

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

            $('#languageManagement').click(function() {
                vcMain.showMainView('control-center/language/');
            });
        });
    </script>
    {/literal}
</head>

<body>
<h1>Video-Collection - Control-Center</h1>
<div id="menuContainer">
    <ul class="mainMenu">
        <li id="movieManagement">Movies</li>
        {if $userType == 'Administrator' OR $userType == 'Standard'}
            <li id="genreManagement">Genres</li>
            <li id="actorManagement">Actors</li>
            <li id="directorManagement">Directors</li>
            <li id="typeManagement">Types</li>
            <li id="storageManagement">Storages</li>
            <li id="languageManagement">Languages</li>
        {/if}
        <li id="userManagement">Users</li>
        <li id="logoutNow">Log out</li>
    </ul>
</div>
<div id="mainContainer" style="display: none;">
</div>
</body>
</html>
