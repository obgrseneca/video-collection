function VcMainClass(baseUrl) {
    this.baseUrl = baseUrl;
}

VcMainClass.prototype.showMainView = function(urlPart) {
    $.ajax({
        type: 'get',
        url: this.baseUrl + urlPart,
        dataType: 'text',
        success: function(data) {
            $('#mainContainer').html(data).css({display: 'block'});
        },
        error: function(jqXHR, textStatus, errorThrown) {
            console.log(textStatus);
            console.log(jqXHR);
            console.log(errorThrown);
        }
    });
};

VcMainClass.prototype.logoutNow = function(logoutUrl) {
    $.ajax({
        type: 'get',
        url: this.baseUrl + logoutUrl,
        dataType: 'json',
        success: function(data) {
            window.location = data;
        },
        error: function(jqXHR, textStatus, errorThrown) {
            console.log(textStatus);
        }
    });
};

VcMainClass.prototype.showMovieDialog = function(urlPart, movieId, genres, actors, directors) {
    var thisClass = this;
    var thisDialogue, thisData;
    $.ajax({
        type: 'get',
        url: this.baseUrl + urlPart,
        dataType: 'text',
        success: function(data) {
            thisDialogue = $('#formContainer').html(data).dialog({
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
                success: function(data) {
                    $('#genreSelection').html(data)
                },
                error: function(jqXHR, textStatus, errorThrown) {
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
                success: function(data) {
                    $('#actorSelection').html(data)
                },
                error: function(jqXHR, textStatus, errorThrown) {
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
                success: function(data) {
                    $('#directorSelection').html(data)
                },
                error: function(jqXHR, textStatus, errorThrown) {
                    console.log(textStatus);
                }
            });
            if (urlPart.indexOf('add') != -1) {
                $('#addMovie').click(function() {
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
                    $.ajax({
                        type: 'post',
                        url: thisClass.baseUrl + 'control-center/movie/add/add.php',
                        dataType: 'json',
                        data: {
                            movieName: $('#movieName').val(),
                            type: $('#movieType').val(),
                            storage: $('#storage').val(),
                            genres: genres,
                            actors: $('#actors').val(),
                            directors: $('#directors').val()
                        },
                        success: function(data) {
                            if (data) {
                                thisClass.showMainView('control-center/movie/');
                                $('#formContainer').html('').dialog( 'destroy' );
                            }
                        },
                        error: function(jqXHR, textStatus, errorThrown) {
                            console.log(textStatus);
                        }
                    });
                });
            } else if (urlPart.indexOf('edit') != -1) {
                $('#editMovie').click(function() {
                        $.ajax({
                            type: 'post',
                            url: thisClass.baseUrl + 'control-center/movie/edit/edit.php',
                            dataType: 'json',
                            data: {
                                movieName: $('#movieName').val(),
                                type: $('#movieType').val(),
                                storage: $('#storage').val(),
                                genres: $('#genres').val(),
                                actors: $('#actors').val(),
                                directors: $('#directors').val(),
                                movieId: movieId
                            },
                            success: function(data) {
                                if (data) {
                                    vcMain.showMainView('control-center/movie/');
                                    $('#formContainer').html('').dialog( 'destroy' );
                                }
                            },
                            error: function(jqXHR, textStatus, errorThrown) {
                                console.log(textStatus);
                            }
                        });
                });
            }
            $('#cancel').click(function() {
                vcMain.showMainView('control-center/movie/');
                $('#formContainer').html('').dialog( 'destroy' );
            });
        },
        error: function(jqXHR, textStatus, errorThrown) {
            console.log(textStatus);
            console.log(jqXHR);
            console.log(errorThrown);
        }
    });
};

VcMainClass.prototype.showGenreDialog = function(urlPart, genreId) {
    var thisClass = this;
    var thisDialogue, thisData;

    $.ajax({
        type: 'get',
        url: this.baseUrl + urlPart,
        dataType: 'text',
        success: function(data) {
            thisDialogue = $('#formContainer').html(data).dialog({
                autoOpen: true,
                height: 450,
                width: 900,
                modal: true
            });

            if (urlPart.indexOf('add') != -1) {
                $('#addGenre').click(function() {
                    $.ajax({
                        type: 'post',
                        url: thisClass.baseUrl + 'control-center/genre/add/add.php',
                        dataType: 'json',
                        data: {
                            genreName: $('#genreName').val()
                        },
                        success: function(data) {
                            if (data) {
                                vcMain.showMainView('control-center/genre/');
                                $('#formContainer').html('').dialog( 'destroy' );
                            }
                        },
                        error: function(jqXHR, textStatus, errorThrown) {
                            console.log(textStatus);
                        }
                    });
                });
            } else if (urlPart.indexOf('edit') != -1) {
                $('#editGenre').click(function() {
                    $.ajax({
                        type: 'post',
                        url: thisClass.baseUrl + 'control-center/genre/edit/edit.php',
                        dataType: 'json',
                        data: {
                            genreName: $('#genreName').val(),
                            id: genreId
                        },
                        success: function(data) {
                            if (data) {
                                vcMain.showMainView('control-center/genre/');
                                $('#formContainer').html('').dialog( 'destroy' );
                            }
                        },
                        error: function(jqXHR, textStatus, errorThrown) {
                            console.log(textStatus);
                        }
                    });
                });
            }
            $('#cancel').click(function() {
                vcMain.showMainView('control-center/genre/');
                $('#formContainer').html('').dialog( 'destroy' );
            });
        },
        error: function(jqXHR, textStatus, errorThrown) {
            console.log(textStatus);
            console.log(jqXHR);
            console.log(errorThrown);
        }
    });
};

VcMainClass.prototype.showActorDialog = function(urlPart, actorId) {
    var thisClass = this;
    var thisDialogue, thisData;

    $.ajax({
        type: 'get',
        url: this.baseUrl + urlPart,
        dataType: 'text',
        success: function(data) {
            thisDialogue = $('#formContainer').html(data).dialog({
                autoOpen: true,
                height: 450,
                width: 900,
                modal: true
            });

            if (urlPart.indexOf('add') != -1) {
                $('#addActor').click(function() {
                    $.ajax({
                        type: 'post',
                        url: thisClass.baseUrl + 'control-center/actor/add/add.php',
                        dataType: 'json',
                        data: {
                            actorName: $('#actorName').val()
                        },
                        success: function(data) {
                            if (data) {
                                vcMain.showMainView('control-center/actor/');
                                $('#formContainer').html('').dialog( 'destroy' );
                            }
                        },
                        error: function(jqXHR, textStatus, errorThrown) {
                            console.log(textStatus);
                        }
                    });
                });
            } else if (urlPart.indexOf('edit') != -1) {
                $('#editActor').click(function() {
                    $.ajax({
                        type: 'post',
                        url: thisClass.baseUrl + 'control-center/actor/edit/edit.php',
                        dataType: 'json',
                        data: {
                            actorName: $('#actorName').val(),
                            id: actorId
                        },
                        success: function(data) {
                            if (data) {
                                vcMain.showMainView('control-center/actor/');
                                $('#formContainer').html('').dialog( 'destroy' );
                            }
                        },
                        error: function(jqXHR, textStatus, errorThrown) {
                            console.log(textStatus);
                        }
                    });
                });
            }
            $('#cancel').click(function() {
                vcMain.showMainView('control-center/actor/');
                $('#formContainer').html('').dialog( 'destroy' );
            });
        },
        error: function(jqXHR, textStatus, errorThrown) {
            console.log(textStatus);
            console.log(jqXHR);
            console.log(errorThrown);
        }
    });
};

VcMainClass.prototype.showDirectorDialog = function(urlPart, directorId) {
    var thisClass = this;
    var thisDialogue, thisData;

    $.ajax({
        type: 'get',
        url: this.baseUrl + urlPart,
        dataType: 'text',
        success: function(data) {
            thisDialogue = $('#formContainer').html(data).dialog({
                autoOpen: true,
                height: 450,
                width: 900,
                modal: true
            });

            if (urlPart.indexOf('add') != -1) {
                $('#addDirector').click(function() {
                    $.ajax({
                        type: 'post',
                        url: thisClass.baseUrl + 'control-center/director/add/add.php',
                        dataType: 'json',
                        data: {
                            directorName: $('#directorName').val()
                        },
                        success: function(data) {
                            if (data) {
                                vcMain.showMainView('control-center/director/');
                                $('#formContainer').html('').dialog( 'destroy' );
                            }
                        },
                        error: function(jqXHR, textStatus, errorThrown) {
                            console.log(textStatus);
                        }
                    });
                });
            } else if (urlPart.indexOf('edit') != -1) {
                $('#editDirector').click(function() {
                    $.ajax({
                        type: 'post',
                        url: thisClass.baseUrl + 'control-center/director/edit/edit.php',
                        dataType: 'json',
                        data: {
                            directorName: $('#directorName').val(),
                            id: directorId
                        },
                        success: function(data) {
                            if (data) {
                                vcMain.showMainView('control-center/director/');
                                $('#formContainer').html('').dialog( 'destroy' );
                            }
                        },
                        error: function(jqXHR, textStatus, errorThrown) {
                            console.log(textStatus);
                        }
                    });
                });
            }
            $('#cancel').click(function() {
                vcMain.showMainView('control-center/director/');
                $('#formContainer').html('').dialog( 'destroy' );
            });
        },
        error: function(jqXHR, textStatus, errorThrown) {
            console.log(textStatus);
            console.log(jqXHR);
            console.log(errorThrown);
        }
    });
};

VcMainClass.prototype.showUserDialog = function(urlPart) {
    var thisClass = this;
    var thisDialogue, thisData;

    $.ajax({
        type: 'get',
        url: this.baseUrl + urlPart,
        dataType: 'text',
        success: function(data) {
            thisDialogue = $('#formContainer').html(data).dialog({
                autoOpen: true,
                height: 450,
                width: 900,
                modal: true
            });

            $('#cancel').click(function() {
                vcMain.showMainView('control-center//');
                $('#formContainer').html('').dialog( 'destroy' );
            });
        },
        error: function(jqXHR, textStatus, errorThrown) {
            console.log(textStatus);
            console.log(jqXHR);
            console.log(errorThrown);
        }
    });
};

VcMainClass.prototype.showStorageDialog = function(urlPart, storageId) {
    var thisClass = this;
    var thisDialogue, thisData;

    $.ajax({
        type: 'get',
        url: this.baseUrl + urlPart,
        dataType: 'text',
        success: function(data) {
            thisDialogue = $('#formContainer').html(data).dialog({
                autoOpen: true,
                height: 450,
                width: 900,
                modal: true
            });

            if (urlPart.indexOf('add') != -1) {
                $('#addStorage').click(function() {
                    $.ajax({
                        type: 'post',
                        url: thisClass.baseUrl + 'control-center/storage/add/add.php',
                        dataType: 'json',
                        data: {
                            storageName: $('#storageName').val()
                        },
                        success: function(data) {
                            if (data) {
                                thisClass.showMainView('control-center/storage/');
                                $('#formContainer').html('').dialog( 'destroy' );
                            }
                        },
                        error: function(jqXHR, textStatus, errorThrown) {
                            console.log(textStatus);
                        }
                    });
                });
            } else if (urlPart.indexOf('edit') != -1) {
                $('#editStorage').click(function() {
                    $.ajax({
                        type: 'post',
                        url: thisClass.baseUrl + 'control-center/storage/edit/edit.php',
                        dataType: 'json',
                        data: {
                            storageName: $('#storageName').val(),
                            id: storageId
                        },
                        success: function(data) {
                            if (data) {
                                thisClass.showMainView('control-center/storage/');
                                $('#formContainer').html('').dialog( 'destroy' );
                            }
                        },
                        error: function(jqXHR, textStatus, errorThrown) {
                            console.log(textStatus);
                        }
                    });
                });
            }
            $('#cancel').click(function() {
                vcMain.showMainView('control-center/storage/');
                $('#formContainer').html('').dialog( 'destroy' );
            });
        },
        error: function(jqXHR, textStatus, errorThrown) {
            console.log(textStatus);
            console.log(jqXHR);
            console.log(errorThrown);
        }
    });
};


VcMainClass.prototype.showTypeDialog = function(urlPart, typeId) {
    var thisClass = this;
    var thisDialogue, thisData;

    $.ajax({
        type: 'get',
        url: this.baseUrl + urlPart,
        dataType: 'text',
        success: function(data) {
            thisDialogue = $('#formContainer').html(data).dialog({
                autoOpen: true,
                height: 450,
                width: 900,
                modal: true
            });

            if (urlPart.indexOf('add') != -1) {
                $('#addType').click(function() {
                    $.ajax({
                        type: 'post',
                        url: thisClass.baseUrl + 'control-center/type/add/add.php',
                        dataType: 'json',
                        data: {
                            typeName: $('#typeName').val()
                        },
                        success: function(data) {
                            if (data) {
                                vcMain.showMainView('control-center/type/');
                                $('#formContainer').html('').dialog( 'destroy' );
                            }
                        },
                        error: function(jqXHR, textStatus, errorThrown) {
                            console.log(textStatus);
                        }
                    });
                });
            } else if (urlPart.indexOf('edit') != -1) {
                $('#editType').click(function() {
                    $.ajax({
                        type: 'post',
                        url: thisClass.baseUrl + 'control-center/type/edit/edit.php',
                        dataType: 'json',
                        data: {
                            typeName: $('#typeName').val(),
                            id: typeId
                        },
                        success: function(data) {
                            if (data) {
                                vcMain.showMainView('control-center/type/');
                                $('#formContainer').html('').dialog( 'destroy' );
                            }
                        },
                        error: function(jqXHR, textStatus, errorThrown) {
                            console.log(textStatus);
                        }
                    });
                });
            }
            $('#cancel').click(function() {
                vcMain.showMainView('control-center/type/');
                $('#formContainer').html('').dialog( 'destroy' );
            });
        },
        error: function(jqXHR, textStatus, errorThrown) {
            console.log(textStatus);
            console.log(jqXHR);
            console.log(errorThrown);
        }
    });
};
