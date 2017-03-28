	@extends('layout.principal')

	@section('title', 'Turnos')

	@section('content')
	@parent

	@if(isset($curso))
		{!! Form::model($curso, ['route' => ['curso.atualizar', $curso->id], 'method' => 'PUT']) !!}
	@else
		{!! Form::open(['route' => 'curso.salvar', 'method' => 'post']) !!}
	@endif

	<h1 class="text-center page-header"></h1>

	<div class="form-group">
		{!! Form::label('nome', 'Nome', ['class' => 'control-label']) !!}
		{!! Form::text('nome', '', ['class' => 'form-control']) !!}
	</div>

	<div class="form-group">
		{!! Form::label('turno', 'Turno', ['class' => 'control-label']) !!}
		{!! Form::select('turno_id', $turnos, null, ['placeholder' => 'Escolha um turno', 'required', 'id' => 'turno_id', 'class' => 'form-control']) !!}
	</div>

	<div class="form-group">
		{!! Form::label('disciplinas', 'Disciplinas', ['class' => 'control-label']) !!}
		{!! Form::select('disciplina_id[]', $disciplinas, null, [
		'required', 'id' => 'disciplina_id', 'class' => 'form-control', 'multiple']) !!}
	</div>

	<button type="submit" class="btn btn-success btn-lg right"><span class="glyphicon glyphicon-floppy-disk"></span> Salvar</button>

	{{-- {!! Form::submit("Salvar", ["class" => 'btn btn-lg btn-success right ']) !!} --}}

	{!! Form::close() !!}

	@endsection

	@section('scripts')
	<script type="text/javascript" src="{{ asset('/js/cadastro_turno.js') }}"></script>
	@endsection