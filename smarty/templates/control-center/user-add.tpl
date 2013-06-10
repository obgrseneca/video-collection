{literal}
    <script type="text/javascript">
        function calculatePasswordHash(userName, password) {
            var passwordHash = password;
            for (var i=0; i<10; i++) {
                passwordHash = SHA1(userName+passwordHash+'{/literal}{$userHash}{literal}');
            }
            return passwordHash;
        }

        $(document).ready(function() {
            $('#addUser').click(function() {
                if ($('#password').val() == $('#password2').val()) {
                    $.ajax({
                        type: 'post',
                        url: '{/literal}{$baseUrl}{literal}control-center/user/add/add.php',
                        dataType: 'json',
                        data: {
                            userName: $('#userName').val(),
                            email: $('#email').val(),
                            password: calculatePasswordHash($('#userName').val(), $('#password').val()),
                            userHash: '{/literal}{$userHash}{literal}',
                            type: $('#userType').val()
                        },
                        success: function(data) {
                            if (data) {
                                vcMain.showMainView('control-center/user/');
                            }
                        },
                        error: function(jqXHR, textStatus, errorThrown) {
                            console.log(textStatus);
                        }
                    });
                } else {
                    $('#passwordMatchWarning').css({display: 'block'});
                }
            });
            $('#cancel').click(function() {
                vcMain.showMainView('control-center/user/');
            });
        });
    </script>
{/literal}

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
