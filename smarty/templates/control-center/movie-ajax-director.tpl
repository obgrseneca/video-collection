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
    var directors = [];
    {/literal}
    {foreach from=$directors item=dRow}
    directors.push("{$dRow.name}");
    {/foreach}
    {literal}

    function catchDirectorEnterButtonPressed(e) {
        var returnValue = true;
        var director = $('#directorInput').val();
        if (e.which == 13 || e.keyCode == 13) {
            addDirector(director);
            returnValue = false;
        }
        return returnValue;
    }

    function addDirector(director) {
        if (director != '' && (director.match(/^ +$/) == null)) {
            director = director.replace(/ *$/,'').replace(/^ */,'');
            var selectedDirectors = $('#directors').val();
            if (selectedDirectors.indexOf(director) == -1) {
                if (selectedDirectors != '') {
                    $('#directors').val(selectedDirectors + ';' + director);
                } else {
                    $('#directors').val(director);
                }
                htmlString = '<span style="margin: 2px; background-color: #f1f1f1; border: 1px solid #cccccc; ' +
                        'border-radius: 2px; cursor: pointer;" onclick="removeDirector(\'' + director + '\');">' + director + '</span>';
                $('#selectedDirectorDiv').append(htmlString);
            }
        }
        $('#directorInput').val('');
    }

    function removeDirector(director) {
        var selectedDirectors = $('#directors').val();
        if (selectedDirectors.indexOf(';') != -1) {
            selectedDirectors = selectedDirectors.split(';');
        } else {
            selectedDirectors = [selectedDirectors];
        }
        var newSelectedDirectors = [];
        htmlString = '';
        for (var dRow in selectedDirectors) {
            if (selectedDirectors[dRow] != director) {
                newSelectedDirectors.push(selectedDirectors[dRow]);
                htmlString += '<span style="margin: 2px; background-color: #f1f1f1; border: 1px solid #cccccc; ' +
                        'border-radius: 2px; cursor: pointer;" ' +
                        'onclick="removeDirector(\'' + selectedDirectors[dRow] + '\');">' +
                        selectedDirectors[dRow] +
                        '</span>';
            }
        }
        selectedDirectors = newSelectedDirectors.join(';');
        $('#directors').val(selectedDirectors);
        $('#selectedDirectorDiv').html(htmlString);
    }

</script>
{/literal}
<span id="selectedDirectorDiv">
    {if $selectedDirectors != ''}
        {foreach from=$selectedDirectorArray item=sRow}
            <span style="margin: 2px; background-color: #f1f1f1; border: 1px solid #cccccc; border-radius: 2px; cursor: pointer;" onclick="removeDirector('{$sRow}');">{$sRow}</span>
        {/foreach}
    {/if}
</span>
<input type="hidden" id="directors" value="{$selectedDirectors}" />
<input list="directorList" id="directorInput" onkeypress="return catchDirectorEnterButtonPressed(event);" />
<datalist id="directorList">
    {foreach from=$directors item=dRow}
        <option>{$dRow.name}</option>
    {/foreach}
</datalist>