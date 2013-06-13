{*
* Copyright (c) 2013 Oliver Burger obgr_seneca@mageia.org
*
* This file is part of video-collection.
*
* video-collection is free software: you can redistribute it and/or modify
* it under the terms of the GNU General Public License as published by
* the Free Software Foundation, either version 3 of the License, or
* (at your option) any later version.
*
* video-collection is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
* GNU General Public License for more details.
*
* You should have received a copy of the GNU General Public License
* along with video-collection.  If not, see <http://www.gnu.org/licenses/>.
*}

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