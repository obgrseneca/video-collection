<!DOCTYPE HTML>

<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <title>Video-Collection</title>

    <link rel="stylesheet" type="text/css" href="{$javascriptDir}/jquery-ui-1.10.3.custom/css/smoothness/jquery-ui-1.10.3.custom.css" />

    <script type="text/javascript" src="{$javascriptDir}/jquery-1.10.1.js"></script>
    <script type="text/javascript" src="{$javascriptDir}/jquery-ui-1.10.3.custom/js/jquery-ui-1.10.3.custom.js"></script>
    <script type="text/javascript" src="{$javascriptDir}/sha1.js"></script>
    {literal}
    <script type="text/javascript">
        $(document).ready(function() {
            $('#writeNow').click(function() {
                $.ajax({
                    type: 'post',
                    url: '{/literal}{$baseUrl}{literal}configuration/write.php',
                    dataType: 'json',
                    data: {
                        dbHostname: $('#dbHostname').val(),
                        dbUser: $('#dbUser').val(),
                        dbPassword: $('#dbPassword').val(),
                        dbName: $('#dbName').val()
                    },
                    success: function(data) {
                        window.location = '{/literal}{$baseUrl}{literal}';
                    },
                    error: function(jqXHR, textStatus, errorThrown) {
                        console.log(textStatus);
                    }
                });
            });

            $('#checkDbSettings').click(function() {
                $.ajax({
                    type: 'post',
                    url: '{/literal}{$baseUrl}{literal}configuration/checkDbSettings.php',
                    dataType: 'json',
                    data: {
                        dbHostname: $('#dbHostname').val(),
                        dbUser: $('#dbUser').val(),
                        dbPassword: $('#dbPassword').val(),
                        dbName: $('#dbName').val()
                    },
                    success: function(data) {
                        if (data) {
                            $('#createDb').removeAttr('disabled');
                            $('#checkDb').removeAttr('disabled');
                            $('#dbName').css('display','inline');
                            $('#dbHostname').css('display','none');
                            $('#dbHostnameFixed').html(':&nbsp;' + $('#dbHostname').val()).css('display','inline');
                            $('#dbUser').css('display','none');
                            $('#dbUserFixed').html(':&nbsp;' + $('#dbUser').val()).css('display','inline');
                            $('#dbPassword').css('display','none');
                            $('#dbPasswordFixed').html(':&nbsp;' + $('#dbPassword').val()).css('display','inline');
                            $('#checkDbSettings').attr('disabled','disabled');
                        }
                        console.log(data);

                    },
                    error: function(jqXHR, textStatus, errorThrown) {
                        console.log(textStatus);
                        console.log(jqXHR);
                    }
                });
            });

            $('#createDb').click(function() {
                $.ajax({
                    type: 'post',
                    url: '{/literal}{$baseUrl}{literal}configuration/createDb.php',
                    dataType: 'json',
                    data: {
                        dbHostname: $('#dbHostname').val(),
                        dbUser: $('#dbUser').val(),
                        dbPassword: $('#dbPassword').val(),
                        dbName: $('#dbName').val()
                    },
                    success: function(data) {
                        if (data[0] == 1) {
                            $('#createDb').attr('disabled','disabled');
                            $('#checkDb').attr('disabled','disabled');
                            $('#dbName').css('display','none');
                            $('#dbNameFixed').html(':&nbsp;' + $('#dbName').val()).css('display','inline');
                            $('#writeNow').removeAttr('disabled');
                        } else if (data[0] == 2) {
                            alert('Database already exists. Please check!');
                            $('#dbName').val('');
                        } else if (data[0] == 3) {
                            alert('Error creating database!');
                            $('#dbName').val('');
                        }
                        console.log(data);

                    },
                    error: function(jqXHR, textStatus, errorThrown) {
                        console.log(textStatus);
                        console.log(jqXHR);
                    }
                });
            });

            $('#checkDb').click(function() {
                $.ajax({
                    type: 'post',
                    url: '{/literal}{$baseUrl}{literal}configuration/checkDbIntegrity.php',
                    dataType: 'json',
                    data: {
                        dbHostname: $('#dbHostname').val(),
                        dbUser: $('#dbUser').val(),
                        dbPassword: $('#dbPassword').val(),
                        dbName: $('#dbName').val()
                    },
                    success: function(data) {
                        if (data['fatal'].length == 0) {
                            $('#createDb').attr('disabled','disabled');
                            $('#checkDb').attr('disabled','disabled');
                            $('#dbName').css('display','none');
                            $('#dbNameFixed').html(':&nbsp;' + $('#dbName').val()).css('display','inline');
                            $('#writeNow').removeAttr('disabled');
                            if (data['warning'] > 0) {
                                $('#dbWarnings').html(data['warning']).css({display: 'block'});
                            }
                        } else {
                            alert('Problems with database integrity!');
                            $('#dbWarnings').html(data['warning']).css({display: 'block'});
                            $('#dbName').val('');
                        }
                        console.log(data);

                    },
                    error: function(jqXHR, textStatus, errorThrown) {
                        console.log(textStatus);
                        console.log(jqXHR);
                    }
                });
            });
        });
    </script>
    {/literal}
</head>

<body>
<h1>Video-Collection - Configuration</h1>
<p>
    <label for="dbHostname">DB Hostname</label>
    <input type="text" id="dbHostname" value="localhost" /><span id="dbHostnameFixed" style="display: none;"></span><br />
    <label for="dbUser">DB User</label>
    <input type="text" id="dbUser" value="root" /><span id="dbUserFixed" style="display: none;"></span><br />
    <label for="dbPassword">DB Password</label>
    <input type="text" id="dbPassword" /><span id="dbPasswordFixed" style="display: none;"></span><br />
    <label for="dbName">DB Name</label>
    <input type="text" id="dbName" style="display: none;" /><span id="dbNameFixed" style="display: none;"></span><br /><br />
    <button type="button" id="checkDbSettings">Check db settings</button>
    <button type="button" id="createDb" disabled="disabled">Create db</button>
    <button type="button" id="checkDb" disabled="disabled">Check db</button><br /><br />
    <button type="button" id="writeNow" disabled="disabled">Save</button>
</p>
<p id="dbWarnings" style="display: none;"></p>
</body>
</html>