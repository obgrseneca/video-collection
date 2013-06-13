{*
* Copyright (c) 2013 Oliver Burger obgr_seneca@mageia.org
*
* This file is part of video-collection.
*
* video-collection is free software: you can redistribute it and/or modify
* it under the terms of the GNU General Public License as published by
* the Free Software Foundation, either version 3 of the License, or
* (at your option) any later version.
*
* video-collection is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
* GNU General Public License for more details.
*
* You should have received a copy of the GNU General Public License
* along with video-collection.  If not, see <http://www.gnu.org/licenses/>.
*}

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
