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
{if $error == "login"}
    <p style="color: #f00">User name or password wrong</p>
{/if}
<p>
    <label for="userName">User name</label>
    <input type="text" id="userName" /><br />
    <label for="password">Password</label>
    <input type="password" id="password" /><br /><br />
    <button type="button" id="loginNow">Login</button><br /><br />
    <a href="{$baseUrl}login/lost-password/">Lost your password?</a>
</p>
</body>
</html>