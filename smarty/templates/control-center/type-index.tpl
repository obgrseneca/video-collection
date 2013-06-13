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
        $('#typeTable').dataTable({
            "bJQueryUI": true,
            "sPaginationType": "full_numbers"
        });
    });
</script>
{/literal}

<h2>Types</h2>
<div id="formContainer"></div>
<div id="tableContainer">
<p>
    {if $userType == 'Administrator' OR $userType == 'Standard'}
        <a href="#" onclick="vcMain.showTypeDialog('control-center/type/add/');">Add type</a>
    {/if}
</p>
<table id="typeTable" style="width: 100%;">
    <thead>
    <tr>
        <th>Type name</th>
        {if $userType == 'Administrator' OR $userType == 'Standard'}
            <th style="width: auto !important;">&nbsp;</th>
        {/if}
    </tr>
    </thead>
    <tbody>
    {foreach from=$types item="tRow"}
        <tr>
            <td>{$tRow.name}</td>
            {if $userType == 'Administrator' OR $userType == 'Standard'}
                <td>
                    <a href="#" onclick="vcMain.showTypeDialog('control-center/type/edit/?typeId={$tRow.id}', {$tRow.id})">Edit</a>
                    <a href="#" onclick="deleteType('{$tRow.id}', '{$tRow.name}');">Delete</a>
                </td>
            {/if}
        </tr>
    {/foreach}
    </tbody>
    <tfoot>
    <tr>
        <th>Type name</th>
        {if $userType == 'Administrator' OR $userType == 'Standard'}
            <th>&nbsp;</th>
        {/if}
    </tr>
    </tfoot>
</table>
</div>
