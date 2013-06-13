{literal}
<script type="text/javascript">
    var result, a, b;
    function sendPassword(name) {
        $.ajax({
            type: 'post',
            url: '{/literal}{$baseUrl}{literal}login/lost-password/sendNewPassword.php',
            dataType: 'json',
            data: {
                name: name,
                tempHash: '{/literal}{$tempHash}{literal}'
            },
            success: function (data) {
                console.log(name);
                $('#mailSent').html('A mail containing a new password was sent to your registered mail address.').css('display', 'block');
                $('#sendNow').attr('disabled', 'disabled');
            },
            error: function (jqXHR, textStatus, errorThrown) {
                console.log(textStatus);
            }
        });
    }

    $(document).ready(function () {
        a = Math.floor(Math.random() * 10);
        b = Math.floor(Math.random() * 10);
        $('#excercise').html('Please enter the result of ' + a + ' + ' + b + ' below!');
        $('#sendNow').click(function () {
            var userName = $('#userName').val();
            if (userName != '' && Number($('#result').val()) == a + b) {
                sendPassword(userName);
            }
        });
    });
</script>
{/literal}
<h2>Password recovery</h2>
<table style="margin: auto;">
    <tr>
        <th>User name</th>
        <td>
            <input type="text" id="userName"/>
        </td>
    </tr>
    <tr>
        <td colspan="2"><span id="excercise"></span></td>
    </tr>
    <tr>
        <th>Result</th>
        <td>
            <input type="text" id="result"/>
        </td>
    </tr>
</table><br/>
<button type="button" id="sendNow">Send password</button><br /><br />
<p id="mailSent" style="display: none;"></p>