{literal}
    <script type="text/javascript">
        $(document).ready(function() {
            $('#editType').click(function() {
                $.ajax({
                    type: 'post',
                    url: '{/literal}{$baseUrl}{literal}control-center/type/edit/edit.php',
                    dataType: 'json',
                    data: {
                        typeName: $('#typeName').val(),
                        id: '{/literal}{$type.id}{literal}'
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

<h2>Edit type</h2>
<p>
    <input type="hidden" value="{$type.id}" />
    <label for="typeName">Type name</label>
    <input type="text" id="typeName" value="{$type.name}" /><br /><br />
    <button type="button" id="editType">Edit type</button>
    <button type="button" id="cancel">Cancel</button>
</p>
