<h1>Video-Collection - Users</h1>
<p>
<table>
    <tr>
        <th>Name</th><th>Type</th><th>Storage</th>
    </tr>
    {foreach from=$movies item="mRow"}
        <tr>
            <td>{$mRow.name}</td><td>{$mRow.type_name}</td><td>{$mRow.storage_name}</td>
        </tr>
    {/foreach}
    <tr>
        <th>Name</th><th>Type</th><th>Storage</th>
    </tr>
</table>
</p>
