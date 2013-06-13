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
    var genres = [];
    {/literal}
    {foreach from=$genres item=gRow}
        genres.push("{$gRow.name}");
    {/foreach}
    {literal}

    function catchGenreEnterButtonPressed(e) {
        var returnValue = true;
        var genre = $('#genreInput').val();
        if (e.which == 13 || e.keyCode == 13) {
            addGenre(genre);
            returnValue = false;
        }
        return returnValue;
    }

    function addGenre(genre) {
        if (genre != '' && (genre.match(/^ +$/) == null)) {
            genre = genre.replace(/ *$/,'').replace(/^ */,'');
            var selectedGenres = $('#genres').val();
            if (selectedGenres.indexOf(genre) == -1) {
                if (selectedGenres != '') {
                    $('#genres').val(selectedGenres + ';' + genre);
                } else {
                    $('#genres').val(genre);
                }
                htmlString = '<span style="margin: 2px; background-color: #f1f1f1; border: 1px solid #cccccc; ' +
                        'border-radius: 2px; cursor: pointer;" onclick="removeGenre(\'' + genre + '\');">' + genre + '</span>';
                $('#selectedGenreDiv').append(htmlString);
            }
        }
        $('#genreInput').val('');
    }

    function removeGenre(genre) {
        var selectedGenres = $('#genres').val();
        if (selectedGenres.indexOf(';') != -1) {
            selectedGenres = selectedGenres.split(';');
        } else {
            selectedGenres = [selectedGenres];
        }
        var newSelectedGenres = [];
        htmlString = '';
        for (var gRow in selectedGenres) {
            if (selectedGenres[gRow] != genre) {
                newSelectedGenres.push(selectedGenres[gRow]);
                htmlString += '<span style="margin: 2px; background-color: #f1f1f1; border: 1px solid #cccccc; ' +
                        'border-radius: 2px; cursor: pointer;" ' +
                        'onclick="removeGenre(\'' + selectedGenres[gRow] + '\');">' +
                        selectedGenres[gRow] +
                        '</span>';
            }
        }
        selectedGenres = newSelectedGenres.join(';');
        $('#genres').val(selectedGenres);
        $('#selectedGenreDiv').html(htmlString);
    }

</script>
{/literal}
<span id="selectedGenreDiv">
    {if $selectedGenres != ''}
        {foreach from=$selectedGenreArray item=sRow}
            <span style="margin: 2px; background-color: #f1f1f1; border: 1px solid #cccccc; border-radius: 2px; cursor: pointer;" onclick="removeGenre('{$sRow}');">{$sRow}</span>
        {/foreach}
    {/if}
</span>
<input type="hidden" id="genres" value="{$selectedGenres}" />
<input list="genreList" id="genreInput" onkeypress="return catchGenreEnterButtonPressed(event);" />
<datalist id="genreList">
    {foreach from=$genres item=gRow}
        <option>{$gRow.name}</option>
    {/foreach}
</datalist>