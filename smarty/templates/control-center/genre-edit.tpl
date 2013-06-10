{literal}
    <script type="text/javascript">
        $(document).ready(function() {
            $('#editGenre').click(function() {
                $.ajax({
                    type: 'post',
                    url: '{/literal}{$baseUrl}{literal}control-center/genre/edit/edit.php',
                    dataType: 'json',
                    data: {
                        genreName: $('#genreName').val(),
                        id: '{/literal}{$genre.id}{literal}'
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

<h2>Edit genre</h2>
<p>
    <input type="hidden" value="{$genre.id}" />
    <label for="genreName">Genre name</label>
    <input type="text" id="genreName" value="{$genre.name}" /><br /><br />
    <button type="button" id="editGenre">Edit genre</button>
    <button type="button" id="cancel">Cancel</button>
</p>
