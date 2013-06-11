{literal}
<script type="text/javascript">
    $(document).ready(function() {
        $('#addMovie').click(function() {
            var genres;
            if ($('#genres').val() != '') {
                if ($('#genreInput').val() != '') {
                    genres = $('#genres').val() + ';' + $('#genreInput').val();
                } else {
                    genres = $('#genres').val();
                }
            } else {
                genres = $('#genreInput').val();
            }
            $.ajax({
                type: 'post',
                url: '{/literal}{$baseUrl}{literal}control-center/movie/add/add.php',
                dataType: 'json',
                data: {
                    movieName: $('#movieName').val(),
                    type: $('#movieType').val(),
                    storage: $('#storage').val(),
                    genres: genres,
                    actors: $('#actors').val(),
                    directors: $('#directors').val()
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
            data: {},
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
            data: {},
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
            data: {},
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
    <label for="movieName">Movie name</label>
    <input type="text" id="movieName" /><br />
    <label for="movieType">Movie type</label>
    <select id="movieType">
        <option value="-1">Please choose</option>
        {foreach from=$types item="tRow"}
            <option value="{$tRow.id}">{$tRow.name}</option>
        {/foreach}
    </select><br />
    <label for="storage">Storage media</label>
    <select id="storage">
        <option value="-1">Please choose</option>
        {foreach from=$storages item="sRow"}
            <option value="{$sRow.id}">{$sRow.name}</option>
        {/foreach}
    </select><br />
    <div id="genreSelection"></div>
    <div id="actorSelection"></div>
    <div id="directorSelection"></div>
    <br />
    <button type="button" id="addMovie">Add movie</button>
    <button type="button" id="cancel">Cancel</button>
</p>
