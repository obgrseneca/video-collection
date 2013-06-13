{literal}
<script type="text/javascript">
    var actors = [];
    {/literal}
    {foreach from=$actors item=aRow}
    actors.push("{$aRow.name}");
    {/foreach}
    {literal}

    function catchActorEnterButtonPressed(e) {
        var returnValue = true;
        var actor = $('#actorInput').val();
        if (e.which == 13 || e.keyCode == 13) {
            addActor(actor);
            returnValue = false;
        }
        return returnValue;
    }

    function addActor(actor) {
        if (actor != '' && (actor.match(/^ +$/) == null)) {
            actor = actor.replace(/ *$/,'').replace(/^ */,'');
            var selectedActors = $('#actors').val();
            if (selectedActors.indexOf(actor) == -1) {
                if (selectedActors != '') {
                    $('#actors').val(selectedActors + ';' + actor);
                } else {
                    $('#actors').val(actor);
                }
                htmlString = '<span style="margin: 2px; background-color: #f1f1f1; border: 1px solid #cccccc; ' +
                        'border-radius: 2px; cursor: pointer;" onclick="removeActor(\'' + actor + '\');">' + actor + '</span>';
                $('#selectedActorDiv').append(htmlString);
            }
        }
        $('#actorInput').val('');
    }

    function removeActor(actor) {
        var selectedActors = $('#actors').val();
        if (selectedActors.indexOf(';') != -1) {
            selectedActors = selectedActors.split(';');
        } else {
            selectedActors = [selectedActors];
        }
        var newSelectedActors = [];
        htmlString = '';
        for (var aRow in selectedActors) {
            if (selectedActors[aRow] != actor) {
                newSelectedActors.push(selectedActors[aRow]);
                htmlString += '<span style="margin: 2px; background-color: #f1f1f1; border: 1px solid #cccccc; ' +
                        'border-radius: 2px; cursor: pointer;" ' +
                        'onclick="removeActor(\'' + selectedActors[aRow] + '\');">' +
                        selectedActors[aRow] +
                        '</span>';
            }
        }
        selectedActors = newSelectedActors.join(';');
        $('#actors').val(selectedActors);
        $('#selectedActorDiv').html(htmlString);
    }

</script>
{/literal}
<span id="selectedActorDiv">
    {if $selectedActors != ''}
        {foreach from=$selectedActorArray item=sRow}
            <span style="margin: 2px; background-color: #f1f1f1; border: 1px solid #cccccc; border-radius: 2px; cursor: pointer;" onclick="removeActor('{$sRow}');">{$sRow}</span>
        {/foreach}
    {/if}
</span>
<input type="hidden" id="actors" value="{$selectedActors}" />
<input list="actorList" id="actorInput" onkeypress="return catchActorEnterButtonPressed(event);" />
<datalist id="actorList">
    {foreach from=$actors item=aRow}
        <option>{$aRow.name}</option>
    {/foreach}
</datalist>