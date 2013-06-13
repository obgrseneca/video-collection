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

<h2>Edit actor</h2>
<p>
    <input type="hidden" value="{$actor.id}" />
    <label for="actorName">Actor name</label>
    <input type="text" id="actorName" value="{$actor.name}" /><br /><br />
    <button type="button" id="editActor">Edit actor</button>
    <button type="button" id="cancel">Cancel</button>
</p>
