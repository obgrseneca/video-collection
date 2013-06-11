{literal}
<script type="text/javascript">
    $(document).ready(function() {
        $('#addMovie').click(function() {
            $.ajax({
                type: 'post',
                url: '{/literal}{$baseUrl}{literal}control-center/movie/add/add.php',
                dataType: 'json',
                data: {
                    movieName: $('#movieName').val(),
                    type: $('#movieType').val(),
                    storage: $('#storage').val(),
                    genres: $('#genres').val(),
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
    <label for="genres">Genres</label>
    <input type="text" id="genres" value="" /><br />
    <label for="actors">Actors</label>
    <input type="text" id="actors" value="" /><br />
    <label for="directors">Directors</label>
    <input type="text" id="directors" value="" /><br /><br />
    <button type="button" id="addMovie">Add movie</button>
    <button type="button" id="cancel">Cancel</button>
</p>
