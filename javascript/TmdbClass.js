/*
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
*/

function TmdbClass(apiKey) {
    this.apiKey = apiKey;
    this.title = '';
    this.language = '';
    this.baseUrl = '';
    this.imageSize = '';
    this.movieData = [];
}

TmdbClass.prototype.getMovieData = function(title, language) {
    this.title = title;
    this.language = language;
    this.getTmdbConfig();
};

TmdbClass.prototype.getTmdbConfig = function() {
    var thisClass = this;
    $.ajax({
        type: 'get',
        url: 'http://api.themoviedb.org/3/configuration',
        dataType: 'json',
        data: {
            'api_key': this.apiKey
        },
        success: function (data) {
            thisClass.baseUrl = data.images.base_url;
            thisClass.imageSize = data.images.poster_sizes[0];
            thisClass.getSearchresults();
        },
        error: function (jqXHR, textStatus, errorThrown) {
            console.log(textStatus);
            console.log(jqXHR);
            console.log(errorThrown);
        }
    });
};

TmdbClass.prototype.getSearchresults = function() {
    var thisClass = this;
    $.ajax({
        type: 'get',
        url: 'http://api.themoviedb.org/3/search/movie',
        dataType: 'json',
        data: {
            'api_key': this.apiKey,
            'query': this.title,
            'language': this.language
        },
        success: function (data) {
            var htmlString = '';
            var index = 0;
            for (var i=0; i<data.results.length; i++) {
                var dateArray =  data.results[i].release_date.split('-');
                var humanDate = dateArray[2] + '. ' + dateArray[1] + '. ' + dateArray[0];
                if (data.results[i].poster_path != null) {
                    thisClass.movieData[index] = {
                        id: data.results[i].id,
                        posterUrl: thisClass.baseUrl + thisClass.imageSize + data.results[i].poster_path,
                        date: data.results[i].release_date,
                        humanDate: humanDate,
                        origTitle: data.results[i].original_title,
                        title: data.results[i].title,
                        genres: [],
                        actors: [],
                        directors: []
                    }
                    thisClass.loadMovieData(data.results[i].id, index);
                    index++;
                }
            }
        },
        error: function (jqXHR, textStatus, errorThrown) {
            console.log(textStatus);
            console.log(jqXHR);
            console.log(errorThrown);
        }
    });
};

TmdbClass.prototype.loadMovieData = function(id, index) {
    var thisClass = this;
    $.ajax({
        type: 'get',
        url: 'http://api.themoviedb.org/3/movie/' + id,
        dataType: 'json',
        data: {
            'api_key': thisClass.apiKey,
            'language': thisClass.language
        },
        success: function (data) {
            var genres = [];
            for (var j=0; j<data.genres.length; j++) {
                genres.push(data.genres[j].name);
            }
            thisClass.movieData[index].genres = genres;
            thisClass.loadMovieCast(id, index);
        },
        error: function (jqXHR, textStatus, errorThrown) {
            console.log(textStatus);
            console.log(jqXHR);
            console.log(errorThrown);
        }
    });
};

TmdbClass.prototype.loadMovieCast = function(id, index) {
    var thisClass = this;
    $.ajax({
        type: 'get',
        url: 'http://api.themoviedb.org/3/movie/' + id + '/casts',
        dataType: 'json',
        data: {
            'api_key': thisClass.apiKey,
            'language': thisClass.language
        },
        success: function (data) {
            var actors = [];
            for (var j=0; j<data.cast.length; j++) {
                actors.push(data.cast[j].name);
            }
            var directors = [];
            for (var k=0; k<data.crew.length; k++) {
                if (data.crew[k].job == 'Director') {
                    directors.push(data.crew[k].name);
                }
            }
            thisClass.movieData[index].actors = actors;
            thisClass.movieData[index].directors = directors;
            thisClass.fillMovieData();
        },
        error: function (jqXHR, textStatus, errorThrown) {
            console.log(textStatus);
            console.log(jqXHR);
            console.log(errorThrown);
        }
    });
};

TmdbClass.prototype.fillMovieData = function() {

    htmlString = '';
    for (var i=0; i<this.movieData.length; i++) {
        htmlString += '<div style="border: 1px solid #ccc; border-radius: 4px; margin: 10px; padding: 4px;"' +
            'onclick="fillMovieFields(' + i + ')">' +
            '<table><tr>' +
            '<th>' +
            '<img src="' + this.movieData[i].posterUrl + '" />' +
            '</th>' +
            '<th>' +
            'Name : ' + this.movieData[i].title + '<br />' +
            'Date : ' + this.movieData[i].humanDate + '<br />' +
            'Genres : ' + this.movieData[i].genres.join('; ') + '<br />' +
            'Actors : ' + this.movieData[i].actors.join('; ') + '<br />' +
            'Directors : ' + this.movieData[i].directors.join('; ') + '<br />' +
            '</th>' +
            '</tr></table></div>';
    }
    $('#tmdbResult').html(htmlString);
};