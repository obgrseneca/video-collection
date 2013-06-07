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
        var result, a, b;
        function sendPassword(name) {
            $.ajax({
                type: 'post',
                url: '{/literal}{$baseUrl}{literal}login/lost-password/sendNewPassword.php',
                dataType: 'json',
                data: {
                    name: name,
                    tempHash: '{/literal}{$tempHash}{literal}'
                },
                success: function(data) {
                    console.log(name);
                    $('#mailSent').html('A mail containing a new password was sent to your registered mail address.').css('display', 'block');
                    $('#sendNow').attr('disabled', 'disabled');
                },
                error: function(jqXHR, textStatus, errorThrown) {
                    console.log(textStatus);
                }
            });
        }

        $(document).ready(function() {
            a = Math.floor(Math.random()*10);
            b = Math.floor(Math.random()*10);
            $('#excercise').html('Please enter the result of ' + a + ' + ' + b + ' below!');
            $('#sendNow').click(function() {
                var userName = $('#userName').val();
                if(userName != '' && Number($('#result').val()) == a + b) {
                    sendPassword(userName);
                }
            });
        });
    </script>
    {/literal}
</head>

<body>
<h1>Video-Collection - Password recovery</h1>
<p>
<form method="post" action="#" id="loginForm">
    <label for="userName">User name</label>
    <input type="text" id="userName" /><br /><br />
    <span id="excercise"></span><br />
    <label for="result">Result</label>
    <input type="text" id="result" /><br /><br />
    <button type="button" id="sendNow">Send password</button>
</form>
</p>
<p id="mailSent" style="display: none;"></p>
</body>
</html>