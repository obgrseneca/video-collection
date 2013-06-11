{literal}
<script type="text/javascript">
    $(document).ready(function() {
        $('#editMovie').click(function() {
            $.ajax({
                type: 'post',
                url: '{/literal}{$baseUrl}{literal}control-center/movie/edit/edit.php',
                dataType: 'json',
                data: {
                    movieName: $('#movieName').val(),
                    type: $('#movieType').val(),
                    storage: $('#storage').val(),
                    genres: $('#genres').val(),
                    actors: $('#actors').val(),
                    directors: $('#directors').val(),
                    movieId: {/literal}{$movie.id}{literal}
                },
                success: function(data) {
                    if (data) {
                        vcMain.showMainView('control-center/movie/');
                    }
                },
                error: function(jqXHR, textStatus, errorThrown) {
                    console.log(textStatus);
                }
            });
        });
        $('#cancel').click(function() {
            vcMain.showMainView('control-center/movie/');
        });

        $.ajax({
            type: 'get',
            url: '{/literal}{$baseUrl}{literal}control-center/movie/ajax/genre.php',
            dataType: 'text',
            data: {
                genres: '{/literal}{$movie.genres}{literal}'
            },
            success: function(data) {
                $('#genreSelection').html(data)
            },
            error: function(jqXHR, textStatus, errorThrown) {
                console.log(textStatus);
            }
        });

        $.ajax({
            type: 'get',
            url: '{/literal}{$baseUrl}{literal}control-center/movie/ajax/actor.php',
            dataType: 'text',
            data: {
                actors: '{/literal}{$movie.actors}{literal}'
            },
            success: function(data) {
                $('#actorSelection').html(data)
            },
            error: function(jqXHR, textStatus, errorThrown) {
                console.log(textStatus);
            }
        });

        $.ajax({
            type: 'get',
            url: '{/literal}{$baseUrl}{literal}control-center/movie/ajax/director.php',
            dataType: 'text',
            data: {
                directors: '{/literal}{$movie.directors}{literal}'
            },
            success: function(data) {
                $('#directorSelection').html(data)
            },
            error: function(jqXHR, textStatus, errorThrown) {
                console.log(textStatus);
            }
        });
    });
</script>
{/literal}

<h2>New movie</h2>
<p>
    <input type="hidden" id="movieId" value="{$movie.id}" />
    <label for="movieName">Movie name</label>
    <input type="text" id="movieName" value="{$movie.name}" /><br />
    <label for="movieType">Movie type</label>
    <select id="movieType">
        <option value="-1">Please choose</option>
        {foreach from=$types item="tRow"}
            <option value="{$tRow.id}"{if $tRow.id == $movie.type_fk} selected="selected"{/if}>{$tRow.name}</option>
        {/foreach}
    </select><br />
    <label for="storage">Storage media</label>
    <select id="storage">
        <option value="-1">Please choose</option>
        {foreach from=$storages item="sRow"}
            <option value="{$sRow.id}"{if $sRow.id == $movie.storage_fk} selected="selected"{/if}>{$sRow.name}</option>
        {/foreach}
    </select><br />
    <div id="genreSelection"></div>
    <div id="actorSelection"></div>
    <div id="directorSelection"></div>
    <br />
    <button type="button" id="editMovie">Edit movie</button>
    <button type="button" id="cancel">Cancel</button>
</p>
