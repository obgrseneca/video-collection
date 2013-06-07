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
        function calculatePasswordHash(userName, password) {
            var passwordHash = password;
            for (var i=0; i<10; i++) {
                passwordHash = SHA1(userName+passwordHash+'{/literal}{$userHash}{literal}');
            }
            return passwordHash;
        }

        $(document).ready(function() {
            $('#editUser').click(function() {
                if ($('#password').val() == $('#password2').val()) {
                    var password = '';
                    if ($('#password').val() != '') {
                        password = calculatePasswordHash($('#userName').val(), $('#password').val());
                    }
                    $.ajax({
                        type: 'post',
                        url: '{/literal}{$baseUrl}{literal}control-center/user/edit/edit.php',
                        dataType: 'json',
                        data: {
                            userName: $('#userName').val(),
                            email: $('#email').val(),
                            password: password,
                            userHash: '{/literal}{$userHash}{literal}',
                            type: $('#userType').val(),
                            id: '{/literal}{$user.id}{literal}'
                        },
                        success: function(data) {
                            if (data) {
                                window.location = '{/literal}{$baseUrl}{literal}control-center/user/';
                            }
                        },
                        error: function(jqXHR, textStatus, errorThrown) {
                            console.log(textStatus);
                        }
                    });
                } else {
                    $('#passwordMatchWarning').css({display: 'block'});
                }
            });
            $('#cancel').click(function() {
                window.location = '{/literal}{$baseUrl}{literal}control-center/user/';
            });
        });
    </script>
    {/literal}
</head>

<body>
<h1>Video-Collection - Edit user</h1>
<p>
    <input type="hidden" value="{$user.id}" />
    <label for="userName">User name</label>
    <input type="text" id="userName" value="{$user.name}" /><br />
    <label for="email">Email</label>
    <input type="text" id="email" value="{$user.email}" /><br />
    <span style="color: #ff0000; display: none;" id="passwordMatchWarning">Passwords must match</span>
    <label for="password">Password</label>
    <input type="password" id="password" /><br />
    <label for="password2">Repeat password</label>
    <input type="password" id="password2" /><br />
    <label for="userType">User type</label>
    {if $userType == 'Administrator' OR $uRow.name == $userName}
    <select id="userType">
        <option value="-1">Please choose</option>
        {foreach from=$userTypes item="utRow"}
            <option value="{$utRow.id}"{if $utRow.id == $user.type_fk} selected="1"{/if}>{$utRow.name}</option>
        {/foreach}
    </select>
    {else}
        <span>{$user.type_name}</span>
        <input type="hidden" id="userType" value="{$user.type}" />
    {/if}<br /><br />
    <button type="button" id="editUser">Edit user</button>
    <button type="button" id="cancel">Cancel</button>
</p>
</body>
</html>