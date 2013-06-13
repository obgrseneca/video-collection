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
    function deleteMovie(id) {
        $.ajax({
            type: 'post',
            url: '{/literal}{$baseUrl}{literal}control-center/movie/delete/delete.php',
            dataType: 'json',
            data: {
                id: id
            },
            success: function (data) {
                if (data['answer']) {
                    vcMain.showMainView('control-center/movie/');
                } else {
                    console.log(data['query']);
                }
            },
            error: function (jqXHR, textStatus, errorThrown) {
                console.log(textStatus);
            }
        });
    }

    $(document).ready(function () {
        $('#movieTable').dataTable({
            "bJQueryUI": true,
            "sPaginationType": "full_numbers"
        });
    });
</script>
{/literal}
<h2>Movies</h2>
<div id="formContainer"></div>
<div id="tableContainer">
    <p>
        {if $userType == 'Administrator' OR userType == 'Standard'}
            <a href="#" onclick="vcMain.showMovieDialog('control-center/movie/add/');">Add movie</a>
        {/if}
    </p>
    <table id="movieTable" style="width: 100%;">
        <thead>
        <tr>
            <th>Name</th>
            <th>Language</th>
            <th>Date</th>
            <th>Type</th>
            <th>Storage</th>
            <th>Genres</th>
            <th>Actors</th>
            <th>Directors</th>
            {if $userType == 'Administrator' OR userType == 'Standard'}
                <th style="width: auto !important;">&nbsp;</th>
            {/if}
        </tr>
        </thead>
        <tbody>
        {foreach from=$movies item="mRow"}
            {if $mRow.id != ''}
                <tr>
                    <td>{$mRow.name}</td>
                    <td>{$mRow.language_name}</td>
                    <td>{$mRow.date}</td>
                    <td>{$mRow.type_name}</td>
                    <td>{$mRow.storage_name}</td>
                    <td>{$mRow.genres}</td>
                    <td>{$mRow.actors}</td>
                    <td>{$mRow.directors}</td>
                    {if $userType == 'Administrator' OR userType == 'Standard'}
                        <td>
                            <a href="#" onclick="vcMain.showMovieDialog('control-center/movie/edit/?movieId={$mRow.id}', {$mRow.id}, '{$mRow.genres}', '{$mRow.actors}', '{$mRow.directors}');">Edit</a>
                            <a href="#" onclick="deleteMovie({$mRow.id});">Delete</a>
                        </td>
                    {/if}
                </tr>
            {/if}
        {/foreach}
        </tbody>
        <tfoot>
        <tr>
            <th>Name</th>
            <th>Language</th>
            <th>Date</th>
            <th>Type</th>
            <th>Storage</th>
            <th>Genres</th>
            <th>Actors</th>
            <th>Directors</th>
            {if $userType == 'Administrator' OR userType == 'Standard'}
                <th>&nbsp;</th>
            {/if}
        </tr>
        </tfoot>
    </table>
</div>
