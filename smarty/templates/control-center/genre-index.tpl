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
                success: function (data) {
                    if (data) {
                        vcMain.showMainView('control-center/genre/');
                    }
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    console.log(textStatus);
                }
            });
        }
    }

    $(document).ready(function () {

    });
</script>
{/literal}

<h2>Genres</h2>
<p>
    {if $userType == 'Administrator' OR $userType == 'Standard'}
        <a href="#" onclick="vcMain.showMainView('control-center/genre/add/');">Add genre</a>
    {/if}
</p>
<table>
    <tr>
        <th>Genre name</th>
        <th>&nbsp;</th>
        <th>&nbsp;</th>
    </tr>
    {foreach from=$genres item="gRow"}
        <tr>
            <td>{$gRow.name}</td>
            <td>{if $userType == 'Administrator' OR $userType == 'Standard'}
                    <a href="#" onclick="vcMain.showMainView('control-center/genre/edit/?genreId={$gRow.id}')">Edit</a>
                {/if}</td>
            <td>{if $userType == 'Administrator'  OR $userType == 'Standard'}
                    <a href="#" onclick="deleteGenre('{$gRow.id}', '{$gRow.name}');">Delete</a>
                {/if}</td>
        </tr>
    {/foreach}
    <tr>
        <th>Genre name</th>
        <th>&nbsp;</th>
        <th>&nbsp;</th>
    </tr>
</table>
