{literal}
<script type="text/javascript">
    function deleteActor(id, name) {
        if (confirm('Really delete actor ' + name + '?')) {
            $.ajax({
                type: 'post',
                url: '{/literal}{$baseUrl}{literal}control-center/actor/delete/delete.php',
                dataType: 'json',
                data: {
                    id: id
                },
                success: function (data) {
                    if (data) {
                        vcMain.showMainView('control-center/actor/');
                    }
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    console.log(textStatus);
                }
            });
        }
    }

    $(document).ready(function () {
        $('#actorTable').dataTable({
            "bJQueryUI": true,
            "sPaginationType": "full_numbers"
        });
    });
</script>
{/literal}

<h2>Actors</h2>
<div id="formContainer"></div>
<div id="tableContainer">
<p>
    {if $userType == 'Administrator' OR $userType == 'Standard'}
        <a href="#" onclick="vcMain.showActorDialog('control-center/actor/add/');">Add actor</a>
    {/if}
</p>
<table id="actorTable" style="width: 100%;">
    <thead>
    <tr>
        <th>Actor name</th>
        {if $userType == 'Administrator' OR $userType == 'Standard'}
            <th style="width: auto;">&nbsp;</th>
            <th style="width: auto;">&nbsp;</th>
        {/if}
    </tr>
    </thead>
    <tbody>
    {foreach from=$actors item="aRow"}
        <tr>
            <td>{$aRow.name}</td>
            {if $userType == 'Administrator' OR $userType == 'Standard'}
                <td>
                    <a href="#" onclick="vcMain.showActorDialog('control-center/actor/edit/?actorId={$aRow.id}', {$aRow.id})">Edit</a>
                </td>
                <td>
                    <a href="#" onclick="deleteActor('{$aRow.id}', '{$aRow.name}');">Delete</a>
                </td>
            {/if}
        </tr>
    {/foreach}
    </tbody>
    <tfoot>
    <tr>
        <th>Actor name</th>
        {if $userType == 'Administrator' OR $userType == 'Standard'}
            <th>&nbsp;</th>
            <th>&nbsp;</th>
        {/if}
    </tr>
    </tfoot>
</table>
</div>
