<h2>New user</h2>
<table>
    <tr>
        <th>User name</th>
        <td>
            <input type="text" id="userName"/>
        </td>
    </tr>
    <tr>
        <th>Email</th>
        <td>
            <input type="text" id="email"/>
        </td>
    </tr>
    <tr>
        <th>Password</th>
        <td>
            <input type="password" id="password"/>
            <span style="color: #ff0000; display: none;"
                  id="passwordMatchWarning">&nbsp;&nbsp;Passwords must match</span>
        </td>
    </tr>
    <tr>
        <th>Repeat password</th>
        <td>
            <input type="password" id="password2"/>
        </td>
    </tr>
    <tr>
        <th>User type</th>
        <td>
            <select id="userType">
                <option value="-1">Please choose</option>
                {foreach from=$userTypes item="utRow"}
                    <option value="{$utRow.id}">{$utRow.name}</option>
                {/foreach}
            </select>
        </td>
    </tr>
</table><br/>
<button type="button" id="addUser">Add user</button>
<button type="button" id="cancel">Cancel</button>
