{literal}
<script type="text/javascript">
    function deleteType(id, name) {
        if (confirm('Really delete type ' + name + '?')) {
            $.ajax({
                type: 'post',
                url: '{/literal}{$baseUrl}{literal}control-center/type/delete/delete.php',
                dataType: 'json',
                data: {
                    id: id
                },
                success: function (data) {
                    if (data) {
                        vcMain.showMainView('control-center/type/');
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

<h2>Types</h2>
<p>
    {if $userType == 'Administrator' OR $userType == 'Standard'}
        <a href="#" onclick="vcMain.showMainView('control-center/type/add/');">Add type</a>
    {/if}
</p>
<table>
    <tr>
        <th>Type name</th>
        <th>&nbsp;</th>
        <th>&nbsp;</th>
    </tr>
    {foreach from=$types item="tRow"}
        <tr>
            <td>{$tRow.name}</td>
            <td>{if $userType == 'Administrator' OR $userType == 'Standard'}
                    <a href="#" onclick="vcMain.showMainView('control-center/type/edit/?typeId={$tRow.id}')">Edit</a>
                {/if}</td>
            <td>{if $userType == 'Administrator'  OR $userType == 'Standard'}
                    <a href="#" onclick="deleteType('{$tRow.id}', '{$tRow.name}');">Delete</a>
                {/if}</td>
        </tr>
    {/foreach}
    <tr>
        <th>Type name</th>
        <th>&nbsp;</th>
        <th>&nbsp;</th>
    </tr>
</table>
