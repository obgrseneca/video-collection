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
        $('#genreTable').dataTable({
            "bJQueryUI": true,
            "sPaginationType": "full_numbers"
        });
    });
</script>
{/literal}

<h2>Genres</h2>
<div id="formContainer"></div>
<div id="tableContainer">
<p>
    {if $userType == 'Administrator' OR $userType == 'Standard'}
        <a href="#" onclick="vcMain.showGenreDialog('control-center/genre/add/');">Add genre</a>
    {/if}
</p>
<table id="genreTable" style="width: 100%;">
    <thead>
    <tr>
        <th>Genre name</th>
        {if $userType == 'Administrator' OR $userType == 'Standard'}
            <th style="width: auto !important;">&nbsp;</th>
        {/if}
    </tr>
    </thead>
    <tbody>
    {foreach from=$genres item="gRow"}
        <tr>
            <td>{$gRow.name}</td>
            {if $userType == 'Administrator' OR $userType == 'Standard'}
                <td>
                    <a href="#" onclick="vcMain.showGenreDialog('control-center/genre/edit/?genreId={$gRow.id}', {$gRow.id})">Edit</a>
                    <a href="#" onclick="deleteGenre('{$gRow.id}', '{$gRow.name}');">Delete</a>
                </td>
            {/if}
        </tr>
    {/foreach}
    </tbody>
    <tfoot>
    <tr>
        <th>Genre name</th>
        {if $userType == 'Administrator' OR $userType == 'Standard'}
            <th>&nbsp;</th>
        {/if}
    </tr>
    </tfoot>
</table>
</div>
