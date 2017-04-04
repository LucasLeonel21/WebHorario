<?php
# Entrada
Route::name('home')->get('/', function () { return view('welcome'); });

# TURNOS
Route::name('turnos')->get('turnos', 'TurnoController@index');
Route::name('turno.cadastrar')->get('turno/cadastrar', 'TurnoController@cadastrar');
Route::name('turno.salvar')->post('turno/salvar', 'TurnoController@salvar');
Route::name('turno.editar')->get('turno/editar/{id}', 'TurnoController@editar');
Route::name('turno.atualizar')->patch('turno/atualizar', 'TurnoController@atualizar');

# DISCIPLINAS
Route::name('disciplinas')->get("disciplinas", 'DisciplinaController@index');
Route::name('disciplina.cadastrar')->get('disciplina/cadastrar', 'DisciplinaController@cadastrar');
Route::name('disciplina.salvar')->post('disciplina/salvar', 'DisciplinaController@salvar');
Route::name('disciplina.editar')->get('disciplina/editar/{id}', 'DisciplinaController@editar');
Route::name('disciplina.atualizar')->patch('disciplina/atualizar', 'DisciplinaController@atualizar');

# CURSOS
Route::name('cursos')->get('cursos', 'CursoController@index');
Route::name('curso.cadastrar')->get('curso/cadastrar', 'CursoController@cadastrar');
Route::name('curso.editar')->get('curso/editar/{id}', 'CursoController@editar');
Route::name('curso.salvar')->post('curso/salvar', 'CursoController@salvar');
Route::name('curso.atualizar')->put('curso/atualizar/{id}', 'CursoController@atualizar');
Route::name('curso.deletar')->get('curso/deletar/{id}', 'CursoController@deletar');

