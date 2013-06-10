{literal}
<script type="text/javascript">
    function deleteStorage(id, name) {
        if (confirm('Really delete storage ' + name + '?')) {
            $.ajax({
                type: 'post',
                url: '{/literal}{$baseUrl}{literal}control-center/storage/delete/delete.php',
                dataType: 'json',
                data: {
                    id: id
                },
                success: function (data) {
                    if (data) {
                        vcMain.showMainView('control-center/storage/');
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

<h2>Storages</h2>
<p>
    {if $userType == 'Administrator' OR $userType == 'Standard'}
        <a href="#" onclick="vcMain.showMainView('control-center/storage/add/');">Add storage</a>
    {/if}
</p>
<table>
    <tr>
        <th>Storage name</th>
        <th>&nbsp;</th>
        <th>&nbsp;</th>
    </tr>
    {foreach from=$storages item="sRow"}
        <tr>
            <td>{$sRow.name}</td>
            <td>{if $userType == 'Administrator' OR $userType == 'Standard'}
                    <a href="#" onclick="vcMain.showMainView('control-center/storage/edit/?storageId={$sRow.id}')">Edit</a>
                {/if}</td>
            <td>{if $userType == 'Administrator'  OR $userType == 'Standard'}
                    <a href="#" onclick="deleteStorage('{$sRow.id}', '{$sRow.name}');">Delete</a>
                {/if}</td>
        </tr>
    {/foreach}
    <tr>
        <th>Storage name</th>
        <th>&nbsp;</th>
        <th>&nbsp;</th>
    </tr>
</table>
