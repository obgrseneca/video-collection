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
        <th>Movie name</th><td><input type="text" id="movieName" value="{$movie.name}" /></td>
    </tr>
    <tr>
        <th>Language</th><td>
            <select id="language">
                <option value="-1">Please choose</option>
                {foreach from=$languages item="lRow"}
                    <option value="{$lRow.id}"{if $lRow.id == $movie.language_fk} selected="selected"{/if}>{$lRow.name}>{$lRow.acronym} - {$lRow.name}</option>
                {/foreach}
            </select>
        </td>
    </tr>
    <tr>
        <th>Movie type</th><td>
            <select id="movieType">
                <option value="-1">Please choose</option>
                {foreach from=$types item="tRow"}
                    <option value="{$tRow.id}"{if $tRow.id == $movie.type_fk} selected="selected"{/if}>{$tRow.name}</option>
                {/foreach}
            </select>
        </td>
    </tr>
    <tr>
        <th>Storage</th><td>
            <select id="storage">
                <option value="-1">Please choose</option>
                {foreach from=$storages item="sRow"}
                    <option value="{$sRow.id}"{if $sRow.id == $movie.storage_fk} selected="selected"{/if}>{$sRow.name}</option>
                {/foreach}
            </select>
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
        <th>Date</th><td><input type="text" id="date" value="{$movie.date}" /></div></td>
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
<button type="button" id="editMovie">Edit movie</button>
<button type="button" id="cancel">Cancel</button>
