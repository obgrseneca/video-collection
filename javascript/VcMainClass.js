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

function VcMainClass(baseUrl) {
    this.baseUrl = baseUrl;
}

VcMainClass.prototype.showMainView = function (urlPart) {
    $.ajax({
        type: 'get',
        url: this.baseUrl + urlPart,
        dataType: 'text',
        success: function (data) {
            $('#mainContainer').html(data).css({display: 'block'});
        },
        error: function (jqXHR, textStatus, errorThrown) {
            console.log(textStatus);
            console.log(jqXHR);
            console.log(errorThrown);
        }
    });
};

VcMainClass.prototype.logoutNow = function (logoutUrl) {
    $.ajax({
        type: 'get',
        url: this.baseUrl + logoutUrl,
        dataType: 'json',
        success: function (data) {
            window.location = data;
        },
        error: function (jqXHR, textStatus, errorThrown) {
            console.log(textStatus);
        }
    });
};

VcMainClass.prototype.showMovieDialog = function (urlPart, movieId, genres, actors, directors) {
    var thisClass = this;
    var thisData;
    var evalParams = {
        'notEmpty': ['movieName', 'storage'],
        'selectNotEmpty': ['language', 'movieType']
    };
    $.ajax({
        type: 'get',
        url: this.baseUrl + urlPart,
        dataType: 'text',
        success: function (data) {
            $('#formContainer').html(data).dialog({
                autoOpen: true,
                height: 450,
                width: 900,
                modal: true
            });

            thisData = {};
            if (typeof genres != 'undefined' && genres != '') {
                thisData.genres = genres;
            }
            $.ajax({
                type: 'get',
                url: thisClass.baseUrl + 'control-center/movie/ajax/genre.php',
                dataType: 'text',
                data: thisData,
                success: function (data) {
                    $('#genreSelection').html(data)
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    console.log(textStatus);
                }
            });

            thisData = {};
            if (typeof actors != 'undefined' && actors != '') {
                thisData.actors = actors;
            }
            $.ajax({
                type: 'get',
                url: thisClass.baseUrl + 'control-center/movie/ajax/actor.php',
                dataType: 'text',
                data: thisData,
                success: function (data) {
                    $('#actorSelection').html(data)
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    console.log(textStatus);
                }
            });

            thisData = {};
            if (typeof directors != 'undefined' && directors != '') {
                thisData.directors = directors;
            }
            $.ajax({
                type: 'get',
                url: thisClass.baseUrl + 'control-center/movie/ajax/director.php',
                dataType: 'text',
                data: thisData,
                success: function (data) {
                    $('#directorSelection').html(data)
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    console.log(textStatus);
                }
            });
            if (urlPart.indexOf('add') != -1) {
                $('#addMovie').click(function () {
                    var genres;
                    if ($('#genres').val() != '') {
                        if ($('#genreInput').val() != '') {
                            genres = $('#genres').val() + ';' + $('#genreInput').val();
                        } else {
                            genres = $('#genres').val();
                        }
                    } else {
                        genres = $('#genreInput').val();
                    }
                    if (thisClass.evaluateForm(evalParams)) {
                    $.ajax({
                        type: 'post',
                        url: thisClass.baseUrl + 'control-center/movie/add/add.php',
                        dataType: 'json',
                        data: {
                            movieName: $('#movieName').val(),
                            date: $('#date').val(),
                            language: $('#language').val(),
                            type: $('#movieType').val(),
                            storage: $('#storage').val(),
                            genres: genres,
                            actors: $('#actors').val(),
                            directors: $('#directors').val()
                        },
                        success: function (data) {
                            if (data) {
                                thisClass.showMainView('control-center/movie/');
                                $('#formContainer').html('').dialog('destroy');
                            }
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            console.log(textStatus);
                        }
                    });
                    }
                });
            } else if (urlPart.indexOf('edit') != -1) {
                $('#editMovie').click(function () {
                    if (thisClass.evaluateForm(evalParams)) {
                    $.ajax({
                        type: 'post',
                        url: thisClass.baseUrl + 'control-center/movie/edit/edit.php',
                        dataType: 'json',
                        data: {
                            movieName: $('#movieName').val(),
                            date: $('#date').val(),
                            language: $('#language').val(),
                            type: $('#movieType').val(),
                            storage: $('#storage').val(),
                            genres: $('#genres').val(),
                            actors: $('#actors').val(),
                            directors: $('#directors').val(),
                            movieId: movieId
                        },
                        success: function (data) {
                            if (data) {
                                thisClass.showMainView('control-center/movie/');
                                $('#formContainer').html('').dialog('destroy');
                            }
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            console.log(textStatus);
                        }
                    });
                    }
                });
            }
            $('#cancel').click(function () {
                thisClass.showMainView('control-center/movie/');
                $('#formContainer').html('').dialog('destroy');
            });
        },
        error: function (jqXHR, textStatus, errorThrown) {
            console.log(textStatus);
            console.log(jqXHR);
            console.log(errorThrown);
        }
    });
};

VcMainClass.prototype.showGenreDialog = function (urlPart, genreId) {
    var thisClass = this;
    var thisDialogue, thisData;
    var evalParams = {
        'notEmpty': ['genreName']
    };

    $.ajax({
        type: 'get',
        url: this.baseUrl + urlPart,
        dataType: 'text',
        success: function (data) {
            thisDialogue = $('#formContainer').html(data).dialog({
                autoOpen: true,
                height: 450,
                width: 900,
                modal: true
            });

            if (urlPart.indexOf('add') != -1) {
                $('#addGenre').click(function () {
                    if (thisClass.evaluateForm(evalParams)) {
                    $.ajax({
                        type: 'post',
                        url: thisClass.baseUrl + 'control-center/genre/add/add.php',
                        dataType: 'json',
                        data: {
                            genreName: $('#genreName').val()
                        },
                        success: function (data) {
                            if (data) {
                                thisClass.showMainView('control-center/genre/');
                                $('#formContainer').html('').dialog('destroy');
                            }
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            console.log(textStatus);
                        }
                    });
                    }
                });
            } else if (urlPart.indexOf('edit') != -1) {
                $('#editGenre').click(function () {
                    if (thisClass.evaluateForm(evalParams)) {
                    $.ajax({
                        type: 'post',
                        url: thisClass.baseUrl + 'control-center/genre/edit/edit.php',
                        dataType: 'json',
                        data: {
                            genreName: $('#genreName').val(),
                            id: genreId
                        },
                        success: function (data) {
                            if (data) {
                                thisClass.showMainView('control-center/genre/');
                                $('#formContainer').html('').dialog('destroy');
                            }
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            console.log(textStatus);
                        }
                    });
                    }
                });
            }
            $('#cancel').click(function () {
                thisClass.showMainView('control-center/genre/');
                $('#formContainer').html('').dialog('destroy');
            });
        },
        error: function (jqXHR, textStatus, errorThrown) {
            console.log(textStatus);
            console.log(jqXHR);
            console.log(errorThrown);
        }
    });
};

VcMainClass.prototype.showActorDialog = function (urlPart, actorId) {
    var thisClass = this;
    var thisDialogue, thisData;
    var evalParams = {
        'notEmpty': ['actorName']
    };

    $.ajax({
        type: 'get',
        url: this.baseUrl + urlPart,
        dataType: 'text',
        success: function (data) {
            thisDialogue = $('#formContainer').html(data).dialog({
                autoOpen: true,
                height: 450,
                width: 900,
                modal: true
            });

            if (urlPart.indexOf('add') != -1) {
                $('#addActor').click(function () {
                    if (thisClass.evaluateForm(evalParams)) {
                    $.ajax({
                        type: 'post',
                        url: thisClass.baseUrl + 'control-center/actor/add/add.php',
                        dataType: 'json',
                        data: {
                            actorName: $('#actorName').val()
                        },
                        success: function (data) {
                            if (data) {
                                thisClass.showMainView('control-center/actor/');
                                $('#formContainer').html('').dialog('destroy');
                            }
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            console.log(textStatus);
                        }
                    });
                    }
                });
            } else if (urlPart.indexOf('edit') != -1) {
                $('#editActor').click(function () {
                    if (thisClass.evaluateForm(evalParams)) {
                    $.ajax({
                        type: 'post',
                        url: thisClass.baseUrl + 'control-center/actor/edit/edit.php',
                        dataType: 'json',
                        data: {
                            actorName: $('#actorName').val(),
                            id: actorId
                        },
                        success: function (data) {
                            if (data) {
                                thisClass.showMainView('control-center/actor/');
                                $('#formContainer').html('').dialog('destroy');
                            }
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            console.log(textStatus);
                        }
                    });
                    }
                });
            }
            $('#cancel').click(function () {
                thisClass.showMainView('control-center/actor/');
                $('#formContainer').html('').dialog('destroy');
            });
        },
        error: function (jqXHR, textStatus, errorThrown) {
            console.log(textStatus);
            console.log(jqXHR);
            console.log(errorThrown);
        }
    });
};

VcMainClass.prototype.showDirectorDialog = function (urlPart, directorId) {
    var thisClass = this;
    var thisDialogue, thisData;
    var evalParams = {
        'notEmpty': ['directorName']
    };

    $.ajax({
        type: 'get',
        url: this.baseUrl + urlPart,
        dataType: 'text',
        success: function (data) {
            thisDialogue = $('#formContainer').html(data).dialog({
                autoOpen: true,
                height: 450,
                width: 900,
                modal: true
            });

            if (urlPart.indexOf('add') != -1) {
                $('#addDirector').click(function () {
                    if (thisClass.evaluateForm(evalParams)) {
                    $.ajax({
                        type: 'post',
                        url: thisClass.baseUrl + 'control-center/director/add/add.php',
                        dataType: 'json',
                        data: {
                            directorName: $('#directorName').val()
                        },
                        success: function (data) {
                            if (data) {
                                thisClass.showMainView('control-center/director/');
                                $('#formContainer').html('').dialog('destroy');
                            }
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            console.log(textStatus);
                        }
                    });
                    }
                });
            } else if (urlPart.indexOf('edit') != -1) {
                $('#editDirector').click(function () {
                    if (thisClass.evaluateForm(evalParams)) {
                    $.ajax({
                        type: 'post',
                        url: thisClass.baseUrl + 'control-center/director/edit/edit.php',
                        dataType: 'json',
                        data: {
                            directorName: $('#directorName').val(),
                            id: directorId
                        },
                        success: function (data) {
                            if (data) {
                                thisClass.showMainView('control-center/director/');
                                $('#formContainer').html('').dialog('destroy');
                            }
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            console.log(textStatus);
                        }
                    });
                    }
                });
            }
            $('#cancel').click(function () {
                thisClass.showMainView('control-center/director/');
                $('#formContainer').html('').dialog('destroy');
            });
        },
        error: function (jqXHR, textStatus, errorThrown) {
            console.log(textStatus);
            console.log(jqXHR);
            console.log(errorThrown);
        }
    });
};

VcMainClass.prototype.showStorageDialog = function (urlPart, storageId) {
    var thisClass = this;
    var thisDialogue, thisData;
    var evalParams = {
        'notEmpty': ['storageName']
    };

    $.ajax({
        type: 'get',
        url: this.baseUrl + urlPart,
        dataType: 'text',
        success: function (data) {
            thisDialogue = $('#formContainer').html(data).dialog({
                autoOpen: true,
                height: 450,
                width: 900,
                modal: true
            });

            if (urlPart.indexOf('add') != -1) {
                $('#addStorage').click(function () {
                    if (thisClass.evaluateForm(evalParams)) {
                    $.ajax({
                        type: 'post',
                        url: thisClass.baseUrl + 'control-center/storage/add/add.php',
                        dataType: 'json',
                        data: {
                            storageName: $('#storageName').val()
                        },
                        success: function (data) {
                            if (data) {
                                thisClass.showMainView('control-center/storage/');
                                $('#formContainer').html('').dialog('destroy');
                            }
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            console.log(textStatus);
                        }
                    });
                    }
                });
            } else if (urlPart.indexOf('edit') != -1) {
                $('#editStorage').click(function () {
                    if (thisClass.evaluateForm(evalParams)) {
                    $.ajax({
                        type: 'post',
                        url: thisClass.baseUrl + 'control-center/storage/edit/edit.php',
                        dataType: 'json',
                        data: {
                            storageName: $('#storageName').val(),
                            id: storageId
                        },
                        success: function (data) {
                            if (data) {
                                thisClass.showMainView('control-center/storage/');
                                $('#formContainer').html('').dialog('destroy');
                            }
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            console.log(textStatus);
                        }
                    });
                    }
                });
            }
            $('#cancel').click(function () {
                thisClass.showMainView('control-center/storage/');
                $('#formContainer').html('').dialog('destroy');
            });
        },
        error: function (jqXHR, textStatus, errorThrown) {
            console.log(textStatus);
            console.log(jqXHR);
            console.log(errorThrown);
        }
    });
};

// ********************

VcMainClass.prototype.showLanguageDialog = function (urlPart, languageId) {
    var thisClass = this;
    var thisDialogue, thisData;
    var evalParams = {
        'notEmpty': ['languageName', 'acronym']
    }

    $.ajax({
        type: 'get',
        url: this.baseUrl + urlPart,
        dataType: 'text',
        success: function (data) {
            thisDialogue = $('#formContainer').html(data).dialog({
                autoOpen: true,
                height: 450,
                width: 900,
                modal: true
            });

            if (urlPart.indexOf('add') != -1) {
                $('#addLanguage').click(function () {
                    if (thisClass.evaluateForm(evalParams)) {
                    $.ajax({
                        type: 'post',
                        url: thisClass.baseUrl + 'control-center/language/add/add.php',
                        dataType: 'json',
                        data: {
                            languageName: $('#languageName').val(),
                            acronym: $('#acronym').val()
                        },
                        success: function (data) {
                            if (data) {
                                thisClass.showMainView('control-center/language/');
                                $('#formContainer').html('').dialog('destroy');
                            }
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            console.log(textStatus);
                        }
                    });
                    }
                });
            } else if (urlPart.indexOf('edit') != -1) {
                $('#editLanguage').click(function () {
                    if (thisClass.evaluateForm(evalParams)) {
                    $.ajax({
                        type: 'post',
                        url: thisClass.baseUrl + 'control-center/language/edit/edit.php',
                        dataType: 'json',
                        data: {
                            languageName: $('#languageName').val(),
                            acronym: $('#acronym').val(),
                            id: languageId
                        },
                        success: function (data) {
                            if (data) {
                                thisClass.showMainView('control-center/language/');
                                $('#formContainer').html('').dialog('destroy');
                            }
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            console.log(textStatus);
                        }
                    });
                    }
                });
            }
            $('#cancel').click(function () {
                thisClass.showMainView('control-center/language/');
                $('#formContainer').html('').dialog('destroy');
            });
        },
        error: function (jqXHR, textStatus, errorThrown) {
            console.log(textStatus);
            console.log(jqXHR);
            console.log(errorThrown);
        }
    });
};
// ********************


VcMainClass.prototype.showTypeDialog = function (urlPart, typeId) {
    var thisClass = this;
    var thisDialogue, thisData;
    var evalParams = {
        'notEmpty': ['typeName']
    }

    $.ajax({
        type: 'get',
        url: this.baseUrl + urlPart,
        dataType: 'text',
        success: function (data) {
            thisDialogue = $('#formContainer').html(data).dialog({
                autoOpen: true,
                height: 450,
                width: 900,
                modal: true
            });

            if (urlPart.indexOf('add') != -1) {
                $('#addType').click(function () {
                    if (thisClass.evaluateForm(evalParams)) {
                    $.ajax({
                        type: 'post',
                        url: thisClass.baseUrl + 'control-center/type/add/add.php',
                        dataType: 'json',
                        data: {
                            typeName: $('#typeName').val()
                        },
                        success: function (data) {
                            if (data) {
                                thisClass.showMainView('control-center/type/');
                                $('#formContainer').html('').dialog('destroy');
                            }
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            console.log(textStatus);
                        }
                    });
                    }
                });
            } else if (urlPart.indexOf('edit') != -1) {
                $('#editType').click(function () {
                    if (thisClass.evaluateForm(evalParams)) {
                    $.ajax({
                        type: 'post',
                        url: thisClass.baseUrl + 'control-center/type/edit/edit.php',
                        dataType: 'json',
                        data: {
                            typeName: $('#typeName').val(),
                            id: typeId
                        },
                        success: function (data) {
                            if (data) {
                                thisClass.showMainView('control-center/type/');
                                $('#formContainer').html('').dialog('destroy');
                            }
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            console.log(textStatus);
                        }
                    });
                    }
                });
            }
            $('#cancel').click(function () {
                thisClass.showMainView('control-center/type/');
                $('#formContainer').html('').dialog('destroy');
            });
        },
        error: function (jqXHR, textStatus, errorThrown) {
            console.log(textStatus);
            console.log(jqXHR);
            console.log(errorThrown);
        }
    });
};

VcMainClass.prototype.showUserDialog = function (urlPart, userId, userHash) {
    var evalParams = {
        'match': [['password', 'password2']],
        'notEmpty': ['userName', 'email'],
        'selectNotEmpty': ['userType']
    };
    var thisClass = this;
    var thisDialogue, thisData;

    $.ajax({
        type: 'get',
        url: this.baseUrl + urlPart,
        dataType: 'text',
        success: function (data) {
            thisDialogue = $('#formContainer').html(data).dialog({
                autoOpen: true,
                height: 450,
                width: 900,
                modal: true
            });

            if (urlPart.indexOf('add') != -1) {
                $('#addUser').click(function () {
                    if (thisClass.evaluateForm(evalParams)) {
                        $.ajax({
                            type: 'post',
                            url: thisClass.baseUrl + 'control-center/user/add/add.php',
                            dataType: 'json',
                            data: {
                                userName: $('#userName').val(),
                                email: $('#email').val(),
                                password: thisClass.calculatePasswordHash($('#userName').val(), $('#password').val(), userHash),
                                userHash: userHash,
                                type: $('#userType').val()
                            },
                            success: function (data) {
                                if (data) {
                                    thisClass.showMainView('control-center/user/');
                                    $('#formContainer').html('').dialog('destroy');
                                }
                            },
                            error: function (jqXHR, textStatus, errorThrown) {
                                console.log(textStatus);
                            }
                        });
                    }
                });
            } else if (urlPart.indexOf('edit') != -1) {
                $('#editUser').click(function () {
                    if (thisClass.evaluateForm(evalParams)) {
                        var password = '';
                        if ($('#password').val() != '') {
                            password = thisClass.calculatePasswordHash($('#userName').val(), $('#password').val(), userHash);
                        }
                        $.ajax({
                            type: 'post',
                            url: thisClass.baseUrl + 'control-center/user/edit/edit.php',
                            dataType: 'json',
                            data: {
                                userName: $('#userName').val(),
                                email: $('#email').val(),
                                password: password,
                                userHash: userHash,
                                type: $('#userType').val(),
                                id: userId
                            },
                            success: function (data) {
                                if (data) {
                                    thisClass.showMainView('control-center/user/');
                                    $('#formContainer').html('').dialog('destroy');
                                }
                            },
                            error: function (jqXHR, textStatus, errorThrown) {
                                console.log(textStatus);
                            }
                        });
                    }
                });
            }
            $('#cancel').click(function () {
                thisClass.showMainView('control-center/user/');
                $('#formContainer').html('').dialog('destroy');
            });
        },
        error: function (jqXHR, textStatus, errorThrown) {
            console.log(textStatus);
            console.log(jqXHR);
            console.log(errorThrown);
        }
    });
};

VcMainClass.prototype.calculatePasswordHash = function (userName, password, userHash) {
    var passwordHash = password;
    for (var i = 0; i < 10; i++) {
        passwordHash = SHA1(userName + passwordHash + userHash);
    }
    return passwordHash;
};

VcMainClass.prototype.evaluateForm = function(params) {
    var returnValue = true;
    var val, index;
    $('.evalWarn').remove();
    for (var key in params) {
        val = params[key];
        switch (key) {
            case 'match':
                for (index in val) {
                    if ($('#' + val[index][0]).val() != $('#' + val[index][1]).val()) {
                        $('#' + val[index][0]).after('<span class="evalWarn" style="color: #ff0000; padding-left: 20px;">Passwords must match</span>');
                        $('#' + val[index][0]).css({'background-color': '#ff0000', color: '#ffffff'})
                        $('#' + val[index][1]).css({'background-color': '#ff0000'})
                        returnValue = false;
                    }
                }
                break;
            case 'notEmpty':
                for (index in val) {
                    if ($('#' + val[index]).val() == '') {
                        $('#' + val[index]).after('<span class="evalWarn" style="color: #ff0000; padding-left: 20px;">May not be empty</span>');
                        $('#' + val[index]).css({'background-color': '#ff0000'})
                        returnValue = false;
                    }
                }
                break;
            case 'selectNotEmpty':
                for (index in val) {
                    if ($('#' + val[index]).val() == -1) {
                        $('#' + val[index]).after('<span class="evalWarn" style="color: #ff0000; padding-left: 20px;">Value must be chosen</span>');
                        $('#' + val[index]).css({'background-color': '#ff0000'})
                        returnValue = false;
                    }
                }
                break;
        }
    }
    return returnValue;
};
