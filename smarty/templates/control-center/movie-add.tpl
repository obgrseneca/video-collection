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
