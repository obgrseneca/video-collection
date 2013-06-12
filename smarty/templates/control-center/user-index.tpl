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
                success: function (data) {
                    if (data) {
                        vcMain.showMainView('control-center/user/');
                    }
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    console.log(textStatus);
                }
            });
        }
    }

    $(document).ready(function () {
        $('#userTable').dataTable({
            "bJQueryUI": true,
            "sPaginationType": "full_numbers"
        });
    });
</script>
{/literal}

<h2>Users</h2>
<div id="formContainer"></div>
<div id="tableContainer">
<p>
    <a href="#" onclick="vcMain.showUserDialog('control-center/user/add/', 0, '{$userHash}');">Add user</a>
</p>
<table id="userTable" style="width: 100%;">
    <thead>
    <tr>
        <th>User name</th>
        <th>Email</th>
        <th>Type</th>
        <th>&nbsp;</th>
    </tr>
    </thead>
    <tbody>
    {foreach from=$users item="uRow"}
        <tr>
            <td>{$uRow.name}</td>
            <td>{$uRow.email}</td>
            <td>{$uRow.type_name}</td>
            <td>{if $userType == 'Administrator' OR $uRow.name == $userName}
                    <a href="#" onclick="vcMain.showUserDialog('control-center/user/edit/?userId={$uRow.id}', {$uRow.id}, '{$userHash}')">Edit</a>
                {/if}{if $userType == 'Administrator' AND $uRow.name != $userName}
                    <a href="#" onclick="deleteUser('{$uRow.id}', '{$uRow.name}');">Delete</a>
                {/if}</td>
        </tr>
    {/foreach}
    </tbody>
    <tfoot>
    <tr>
        <th>User name</th>
        <th>Email</th>
        <th>Type</th>
        <th>&nbsp;</th>
    </tr>
    </tfoot>
</table>
</div>
