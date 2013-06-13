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

<script type="text/javascript">
    {literal}
        var languages = {'-1': ''};
    {/literal}
    {foreach from=$languages item="lRow"}
        languages['{$lRow.id}'] = '{$lRow.acronym}';
    {/foreach}

    function queryTmdb() {
        {literal}
            $('#tmdbResult').css({display: 'block'});
        {/literal}
        var movieName = $('#movieName').val();
        var language = languages[$('#language').val()];
        tmdb.getMovieData(movieName, language);
    }

    function fillMovieFields(index) {
        var i;
        $('#date').val(tmdb.movieData[index].date);
        $('#movieName').val(tmdb.movieData[index].title);
        for (i=0; i<tmdb.movieData[index].genres.length; i++) {
            addGenre(tmdb.movieData[index].genres[i]);
        }
        for (i=0; i<tmdb.movieData[index].actors.length; i++) {
            addActor(tmdb.movieData[index].actors[i]);
        }
        for (i=0; i<tmdb.movieData[index].directors.length; i++) {
            addDirector(tmdb.movieData[index].directors[i]);
        }

        {literal}
            $('#tmdbResult').css({display: 'none'});
        {/literal}
    }
</script>
<h2>New movie</h2>
<table>
    <tr>
        <th>Movie name</th><td><input type="text" id="movieName" /></td>
    </tr>
    <tr>
        <th>Language</th><td>
            <select id="language">
                <option value="-1">Please choose</option>
                {foreach from=$languages item="lRow"}
                    <option value="{$lRow.id}">{$lRow.acronym} - {$lRow.name}</option>
                {/foreach}
            </select>
        </td>
    </tr>
    <tr>
        <th>Movie type</th><td>
            <select id="movieType">
                <option value="-1">Please choose</option>
                {foreach from=$types item="tRow"}
                    <option value="{$tRow.id}">{$tRow.name}</option>
                {/foreach}
            </select>
        </td>
    </tr>
    <tr>
        <th>Storage</th><td>
            <input list="storageList" id="storage" onkeypress="return catchActorEnterButtonPressed(event);" />
            <datalist id="storageList">
                {foreach from=$storages item=sRow}
                    <option>{$sRow.name}</option>
                {/foreach}
            </datalist>
        </td>
    </tr>
    <tr>
        <td colspan="2">
            <button type="button" id="addTmdbInfo" onclick="queryTmdb();">
                Query TMDB
            </button>
        </td>
    </tr>
    <tr>
        <td colspan="2">
            <div id="tmdbResult" style="display: none;"></div>
        </td>
    </tr>
    <tr>
        <th>Date</th><td><input type="text" id="date" /></div></td>
    </tr>
    <tr>
        <th>Genres</th><td><div id="genreSelection"></div></td>
    </tr>
    <tr>
        <th>Actors</th><td><div id="actorSelection"></div></td>
    </tr>
    <tr>
        <th>Directors</th><td><div id="directorSelection"></div></td>
    </tr>
</table><br />
<button type="button" id="addMovie">Add movie</button>
<button type="button" id="cancel">Cancel</button>
