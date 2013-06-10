{literal}
    <script type="text/javascript">
        $(document).ready(function() {
            $('#editStorage').click(function() {
                $.ajax({
                    type: 'post',
                    url: '{/literal}{$baseUrl}{literal}control-center/storage/edit/edit.php',
                    dataType: 'json',
                    data: {
                        storageName: $('#storageName').val(),
                        id: '{/literal}{$storage.id}{literal}'
                    },
                    success: function(data) {
                        if (data) {
                            vcMain.showMainView('control-center/storage/');
                        }
                    },
                    error: function(jqXHR, textStatus, errorThrown) {
                        console.log(textStatus);
                    }
                });
            });
            $('#cancel').click(function() {
                vcMain.showMainView('control-center/storage/');
            });
        });
    </script>
{/literal}

<h2>Edit storage</h2>
<p>
    <input type="hidden" value="{$storage.id}" />
    <label for="storageName">Storage name</label>
    <input type="text" id="storageName" value="{$storage.name}" /><br /><br />
    <button type="button" id="editStorage">Edit storage</button>
    <button type="button" id="cancel">Cancel</button>
</p>
