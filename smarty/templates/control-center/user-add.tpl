<h2>New user</h2>
<p>
    <label for="userName">User name</label>
    <input type="text" id="userName" /><br />
    <label for="email">Email</label>
    <input type="text" id="email" /><br />
    <span style="color: #ff0000; display: none;" id="passwordMatchWarning">Passwords must match</span>
    <label for="password">Password</label>
    <input type="password" id="password" /><br />
    <label for="password2">Repeat password</label>
    <input type="password" id="password2" /><br />
    <label for="userType">User type</label>
    <select id="userType">
        <option value="-1">Please choose</option>
        {foreach from=$userTypes item="utRow"}
            <option value="{$utRow.id}">{$utRow.name}</option>
        {/foreach}
    </select><br /><br />
    <button type="button" id="addUser">Add user</button>
    <button type="button" id="cancel">Cancel</button>
</p>
