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