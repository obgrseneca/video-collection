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
    <script type="text/javascript" src="{$javascriptDir}/sha1.js"></script>
    {literal}
    <script type="text/javascript">
        $(document).ready(function() {
            {/literal}var baseUrl = '{$baseUrl}';{literal}
            $('#writeNow').click(function() {
                $.ajax({
                    type: 'post',
                    url: baseUrl + 'configuration/write.php',
                    dataType: 'json',
                    data: {
                        dbHostname: $('#dbHostname').val(),
                        dbUser: $('#dbUser').val(),
                        dbPassword: $('#dbPassword').val(),
                        dbName: $('#dbName').val()
                    },
                    success: function(data) {
                        window.location = baseUrl;
                    },
                    error: function(jqXHR, textStatus, errorThrown) {
                        console.log(textStatus);
                    }
                });
            });

            $('#checkDbSettings').click(function() {
                $.ajax({
                    type: 'post',
                    url: baseUrl + 'configuration/checkDbSettings.php',
                    dataType: 'json',
                    data: {
                        dbHostname: $('#dbHostname').val(),
                        dbUser: $('#dbUser').val(),
                        dbPassword: $('#dbPassword').val(),
                        dbName: $('#dbName').val()
                    },
                    success: function(data) {
                        if (data) {
                            $('#createDb').removeAttr('disabled');
                            $('#checkDb').removeAttr('disabled');
                            $('#dbName').css('display','inline');
                            $('#dbHostname').css('display','none');
                            $('#dbHostnameFixed').html($('#dbHostname').val()).css('display','inline');
                            $('#dbUser').css('display','none');
                            $('#dbUserFixed').html($('#dbUser').val()).css('display','inline');
                            $('#dbPassword').css('display','none');
                            $('#dbPasswordFixed').html($('#dbPassword').val()).css('display','inline');
                            $('#checkDbSettings').attr('disabled','disabled');
                        }
                        console.log(data);

                    },
                    error: function(jqXHR, textStatus, errorThrown) {
                        console.log(textStatus);
                        console.log(jqXHR);
                    }
                });
            });

            $('#createDb').click(function() {
                $.ajax({
                    type: 'post',
                    url: baseUrl + 'configuration/createDb.php',
                    dataType: 'json',
                    data: {
                        dbHostname: $('#dbHostname').val(),
                        dbUser: $('#dbUser').val(),
                        dbPassword: $('#dbPassword').val(),
                        dbName: $('#dbName').val()
                    },
                    success: function(data) {
                        if (data[0] == 1) {
                            $('#createDb').attr('disabled','disabled');
                            $('#checkDb').attr('disabled','disabled');
                            $('#dbName').css('display','none');
                            $('#dbNameFixed').html($('#dbName').val()).css('display','inline');
                            $('#writeNow').removeAttr('disabled');
                        } else if (data[0] == 2) {
                            alert('Database already exists. Please check!');
                            $('#dbName').val('');
                        } else if (data[0] == 3) {
                            alert('Error creating database!');
                            $('#dbName').val('');
                        }
                        console.log(data);

                    },
                    error: function(jqXHR, textStatus, errorThrown) {
                        console.log(textStatus);
                        console.log(jqXHR);
                    }
                });
            });

            $('#checkDb').click(function() {
                $.ajax({
                    type: 'post',
                    url: baseUrl + 'configuration/checkDbIntegrity.php',
                    dataType: 'json',
                    data: {
                        dbHostname: $('#dbHostname').val(),
                        dbUser: $('#dbUser').val(),
                        dbPassword: $('#dbPassword').val(),
                        dbName: $('#dbName').val()
                    },
                    success: function(data) {
                        if (data['fatal'].length == 0) {
                            $('#createDb').attr('disabled','disabled');
                            $('#checkDb').attr('disabled','disabled');
                            $('#dbName').css('display','none');
                            $('#dbNameFixed').html($('#dbName').val()).css('display','inline');
                            $('#writeNow').removeAttr('disabled');
                            if (data['warning'] > 0) {
                                $('#dbWarnings').html(data['warning']).css({display: 'block'});
                            }
                        } else {
                            alert('Problems with database integrity!');
                            $('#dbWarnings').html(data['warning']).css({display: 'block'});
                            $('#dbName').val('');
                        }
                        console.log(data);

                    },
                    error: function(jqXHR, textStatus, errorThrown) {
                        console.log(textStatus);
                        console.log(jqXHR);
                    }
                });
            });
        });
    </script>
    {/literal}
</head>

<body>
<h1>Video-Collection - Configuration</h1>
<div id="mainContainer" style="display: block; text-align: center;">
<table style="margin: auto;">
    <tr>
        <th>DB Hostname</th>
        <td>
            <input type="text" id="dbHostname" value="localhost" /><span id="dbHostnameFixed" style="display: none;"></span>
        </td>
    </tr>
    <tr>
        <th>DB User</th>
        <td>
            <input type="text" id="dbUser" value="root" /><span id="dbUserFixed" style="display: none;"></span>
        </td>
    </tr>
    <tr>
        <th>DB Password</th>
        <td>
            <input type="text" id="dbPassword" /><span id="dbPasswordFixed" style="display: none;"></span>
        </td>
    </tr>
    <tr>
        <th>DB Name</th>
        <td>
            <input type="text" id="dbName" style="display: none;" /><span id="dbNameFixed" style="display: none;"></span>
        </td>
    </tr>
</table><br />
    <button type="button" id="checkDbSettings">Check db settings</button>
    <button type="button" id="createDb" disabled="disabled">Create db</button>
    <button type="button" id="checkDb" disabled="disabled">Check db</button><br /><br />
    <button type="button" id="writeNow" disabled="disabled">Save</button>
<p id="dbWarnings" style="display: none;"></p>
</div>
</body>
</html>