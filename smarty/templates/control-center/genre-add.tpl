{literal}
    <script type="text/javascript">
        $(document).ready(function() {
            $('#addGenre').click(function() {
                $.ajax({
                    type: 'post',
                    url: '{/literal}{$baseUrl}{literal}control-center/genre/add/add.php',
                    dataType: 'json',
                    data: {
                        genreName: $('#genreName').val()
                    },
                    success: function(data) {
                        if (data) {
                            vcMain.showMainView('control-center/genre/');
                        }
                    },
                    error: function(jqXHR, textStatus, errorThrown) {
                        console.log(textStatus);
                    }
                });
            });
            $('#cancel').click(function() {
                vcMain.showMainView('control-center/genre/');
            });
        });
    </script>
{/literal}

<h2>New genre</h2>
<p>
    <label for="genreName">Genre name</label>
    <input type="text" id="genreName" /><br /><br />
    <button type="button" id="addGenre">Add genre</button>
    <button type="button" id="cancel">Cancel</button>
</p>
