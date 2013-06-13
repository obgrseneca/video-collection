<h2>Edit user</h2>
<table>
    <tr>
        <th>User name</th>
        <td>
            <input type="text" id="userName" value="{$user.name}" />
        </td>
    </tr>
    <tr>
        <th>Email</th>
        <td>
            <input type="text" id="email" value="{$user.email}" />
        </td>
    </tr>
    <tr>
        <th>Password</th>
        <td>
            <input type="password" id="password" />
            <span style="color: #ff0000; display: none;" id="passwordMatchWarning">&nbsp;&nbsp;Passwords must match</span>
        </td>
    </tr>
    <tr>
        <th>Repeat password</th>
        <td>
            <input type="password" id="password2" />
        </td>
    </tr>
    <tr>
        <th>User type</th>
        <td>
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
            {/if}
        </td>
    </tr>
</table>
<input type="hidden" value="{$user.id}" /><br />
<button type="button" id="editUser">Edit user</button>
<button type="button" id="cancel">Cancel</button>
