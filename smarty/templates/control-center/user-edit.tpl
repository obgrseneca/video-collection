<h2>Edit user</h2>
<p>
    <input type="hidden" value="{$user.id}" />
    <label for="userName">User name</label>
    <input type="text" id="userName" value="{$user.name}" /><br />
    <label for="email">Email</label>
    <input type="text" id="email" value="{$user.email}" /><br />
    <span style="color: #ff0000; display: none;" id="passwordMatchWarning">Passwords must match</span>
    <label for="password">Password</label>
    <input type="password" id="password" /><br />
    <label for="password2">Repeat password</label>
    <input type="password" id="password2" /><br />
    <label for="userType">User type</label>
    {if $userType == 'Administrator' OR $uRow.name == $userName}
    <select id="userType">
        <option value="-1">Please choose</option>
        {foreach from=$userTypes item="utRow"}
            <option value="{$utRow.id}"{if $utRow.id == $user.type_fk} selected="1"{/if}>{$utRow.name}</option>
        {/foreach}
    </select>
    {else}
        <span>{$user.type_name}</span>
        <input type="hidden" id="userType" value="{$user.type}" />
    {/if}<br /><br />
    <button type="button" id="editUser">Edit user</button>
    <button type="button" id="cancel">Cancel</button>
</p>
