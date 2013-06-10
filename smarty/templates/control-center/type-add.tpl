{literal}
    <script type="text/javascript">
        $(document).ready(function() {
            $('#addType').click(function() {
                $.ajax({
                    type: 'post',
                    url: '{/literal}{$baseUrl}{literal}control-center/type/add/add.php',
                    dataType: 'json',
                    data: {
                        typeName: $('#typeName').val()
                    },
                    success: function(data) {
                        if (data) {
                            vcMain.showMainView('control-center/type/');
                        }
                    },
                    error: function(jqXHR, textStatus, errorThrown) {
                        console.log(textStatus);
                    }
                });
            });
            $('#cancel').click(function() {
                vcMain.showMainView('control-center/type/');
            });
        });
    </script>
{/literal}

<h2>New type</h2>
<p>
    <label for="typeName">Type name</label>
    <input type="text" id="typeName" /><br /><br />
    <button type="button" id="addType">Add type</button>
    <button type="button" id="cancel">Cancel</button>
</p>
