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
        function deleteGenre(id, name) {
            if (confirm('Really delete genre ' + name + '?')) {
                $.ajax({
                    type: 'post',
                    url: '{/literal}{$baseUrl}{literal}control-center/genre/delete/delete.php',
                    dataType: 'json',
                    data: {
                        id: id
                    },
                    success: function(data) {
                        if (data) {
                            window.location = '{/literal}{$baseUrl}{literal}control-center/genre/';
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
<h1>Video-Collection - Genres</h1>
<p>
    {if $userType == 'Administrator' OR $userType == 'Standard'}
        <a href="{$baseUrl}control-center/genre/add/">Add genre</a>&nbsp;&nbsp;&ndash;&nbsp;&nbsp;
    {/if}
    <a href="{$baseUrl}control-center/">Back</a>
<table>
    <tr>
        <th>Genre name</th><th>&nbsp;</th><th>&nbsp;</th>
    </tr>
    {foreach from=$genres item="gRow"}
        <tr>
            <td>{$gRow.name}</td>
            <td>{if $userType == 'Administrator' OR $userType == 'Standard'}
                    <a href="{$baseUrl}control-center/genre/edit/?genreId={$gRow.id}">Edit</a>
                {/if}</td>
            <td>{if $userType == 'Administrator'  OR $userType == 'Standard'}
                    <a href="#" onclick="deleteGenre('{$gRow.id}', '{$gRow.name}');">Delete</a>
                {/if}</td>
        </tr>
    {/foreach}
    <tr>
        <th>Genre name</th><th>&nbsp;</th><th>&nbsp;</th>
    </tr>
</table>
</p>
</body>
</html>