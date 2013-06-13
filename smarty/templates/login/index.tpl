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
    <script type="text/javascript" src="{$javascriptDir}/VcMainClass.js"></script>
    {literal}
    <script type="text/javascript">
        var vcMain = new VcMainClass('{/literal}{$baseUrl}{literal}')
        function getLoginHash(userName, password) {
            $.ajax({
                type: 'get',
                url: './returnUserHash.php',
                dataType: 'json',
                data: {userName: userName},
                success: function(data) {
                    login(userName, password, data['userHash']);
                },
                error: function(jqXHR, textStatus, errorThrown) {
                    console.log(textStatus);
                    console.log(jqXHR);
                }
            });
        }

        function login(userName, password, userHash) {
            console.log(userName);
            console.log(password);
            console.log(userHash);
            $.ajax({
                type: 'get',
                url: './login.php',
                dataType: 'json',
                data: {userName: userName, passwordHash: calculatePasswordHash(userName, password, userHash)},
                success: function(data) {
                    console.log(data);
                    if(data['loginResult']) {
                        window.location = "{/literal}{$baseUrl}{literal}control-center/";
                    } else {
                        window.location = "{/literal}{$baseUrl}{literal}?error=login%20false";
                    }
                },
                error: function(jqXHR, textStatus, errorThrown) {
                    console.log(textStatus);
                }
            });
        }

        function calculatePasswordHash(userName, password, userHash) {
            var passwordHash = password;
            for (var i=0; i<10; i++) {
                passwordHash = SHA1(userName+passwordHash+userHash);
            }
            passwordHash = SHA1(passwordHash+'{/literal}{$tempHash}{literal}');

            return passwordHash;
        }

        $(document).ready(function() {
            $('#loginNow').click(function() {
                var userName = $('#userName').val();
                var password = $('#password').val();

                if(userName != '' && password != '') {
                    getLoginHash(userName, password);
                }
            });
        });
    </script>
    {/literal}
</head>

<body>
<h1>Video-Collection - Login</h1>
<div id="mainContainer" style="display: block; text-align: center;">
{if $error == "login"}
    <p style="color: #f00">User name or password wrong</p>
{/if}
<table style="margin: auto;">
    <tr>
        <th>User name</th>
        <td>
            <input type="text" id="userName" />
        </td>
    </tr>
    <tr>
        <th>Password</th>
        <td>
            <input type="password" id="password" />
        </td>
    </tr>
</table><br />
<button type="button" id="loginNow">Login</button><br /><br />
<a href="#" onclick="vcMain.showMainView('login/lost-password/')">Lost your password?</a>
</div>
</body>
</html>