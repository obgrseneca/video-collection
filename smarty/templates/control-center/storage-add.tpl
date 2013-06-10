{literal}
    <script type="text/javascript">
        $(document).ready(function() {
            $('#addStorage').click(function() {
                $.ajax({
                    type: 'post',
                    url: '{/literal}{$baseUrl}{literal}control-center/storage/add/add.php',
                    dataType: 'json',
                    data: {
                        storageName: $('#storageName').val()
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

<h2>New storage</h2>
<p>
    <label for="storageName">Storage name</label>
    <input type="text" id="storageName" /><br /><br />
    <button type="button" id="addStorage">Add storage</button>
    <button type="button" id="cancel">Cancel</button>
</p>
