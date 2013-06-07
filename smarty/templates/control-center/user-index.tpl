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
        function deleteUser(id, name) {
            if (confirm('Really delete user ' + name + '?')) {
                $.ajax({
                    type: 'post',
                    url: '{/literal}{$baseUrl}{literal}control-center/user/delete/delete.php',
                    dataType: 'json',
                    data: {
                        id: id
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
            }
        }

        $(document).ready(function() {

        });
    </script>
    {/literal}
</head>

<body>
<h1>Video-Collection - Users</h1>
<p>
    <a href="{$baseUrl}control-center/user/add/">Add user</a>&nbsp;&nbsp;&ndash;&nbsp;&nbsp;<a href="{$baseUrl}control-center/">Back</a>
    <table>
    <tr>
        <th>User name</th><th>Email</th><th>Type</th><th>&nbsp;</th><th>&nbsp;</th>
    </tr>
    {foreach from=$users item="uRow"}
    <tr>
        <td>{$uRow.name}</td><td>{$uRow.email}</td><td>{$uRow.type_name}</td>
        <td>{if $userType == 'Administrator' OR $uRow.name == $userName}
                <a href="{$baseUrl}control-center/user/edit/?userId={$uRow.id}">Edit</a>
        {/if}</td>
        <td>{if $userType == 'Administrator' AND $uRow.name != $userName}
                <a href="#" onclick="deleteUser('{$uRow.id}', '{$uRow.name}');">Delete</a>
        {/if}</td>
    </tr>
    {/foreach}
    <tr>
        <th>User name</th><th>Email</th><th>Type</th><th>&nbsp;</th><th>&nbsp;</th>
    </tr>
    </table>
</p>
</body>
</html>