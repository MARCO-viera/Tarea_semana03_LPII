<!DOCTYPE html>
<html lang="esS" >
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
<script type="text/javascript" src="js/jquery.min.js"></script>
<script type="text/javascript" src="js/bootstrap.min.js"></script>
<script type="text/javascript" src="js/bootstrapValidator.js"></script>
<script type="text/javascript" src="js/global.js"></script>

<link rel="stylesheet" href="css/bootstrap.css"/>
<link rel="stylesheet" href="css/bootstrapValidator.css"/>
<title>Ejercicio Semana 03</title>
</head>
<body>

<div class="container">
<h3>Registro Proveedor</h3>
	
	<form  id="id_form" method="post"> 
	 <div class="col-md-12" style="margin-top: 2%">
			
		<div class="form-group col-md-6">
					<label class="control-label" for="id_nombre">Nombre</label>
					<input class="form-control" type="text" id="id_nombre" name="nombre" placeholder="Ingrese el nombre">
		
		</div>				
	
		
				<div class="form-group  col-sm-4">
					<label class="control-label" for="id_dni">DNI</label>
					<input class="form-control" type="text" id="id_dni" name="dni" placeholder="Ingrese el dni" maxlength="8">
		 		
			</div>				



				<div class="col-sm-5">
				<label class="control-label" for="id_fecha">Fecha de Registro</label>
				<input class="form-control" type="date" id="id_fecha" name="fechaRegistro" placeholder="Ingrese la fecha" maxlength="100">
		 		
			</div>
		
		
				<div class="form-group col-md-3">
					<label class="control-label" for="id_tipo">Tipo</label>
					<select id="id_tipo" name="tipo.idTipo" class='form-control'>
						<option value=" ">[Seleccione]</option>    
					</select>
			    </div>
			    
			    
			    
			    
			    <div class="form-group col-md-3">
					<label class="control-label" for="id_pais">Pais</label>
					<select id="id_pais" name="pais.idPais" class='form-control'>
						<option value=" ">[Seleccione]</option>    
					</select>
			    </div>
			 
		
	
		    <div class="row">
				<div class="form-group col-md-12" align="center">
					<button id="id_registrar" type="button" class="btn btn-primary" >Registra</button>
				</div>
			</div>
			</div>
				
	
		
	</form>
	
</div>

<script type="text/javascript">
$.getJSON("listaTipo", {}, function(data){
	console.log(data);
	$.each(data, function(index,item){
		$("#id_tipo").append("<option value="+item.idTipo +">"+ item.descripcion +"</option>");
	});
});

$.getJSON("listaPais", {}, function(data){
	console.log(data);
	$.each(data, function(index,item){
		$("#id_pais").append("<option value="+item.idPais +">"+ item.nombre +"</option>");
	});
});


$("#id_registrar").click(function (){ 

	var validator = $('#id_form').data('bootstrapValidator');
	validator.validate();

	if (validator.isValid()){
		$.ajax({
			type: 'POST',  
			data: $("#id_form").serialize(),
			url: 'registraProveedor',
			success: function(data){
				mostrarMensaje(data.MENSAJE);
				limpiar();
				validator.resetForm();
			},
			error: function(){
				mostrarMensaje(MSG_ERROR);
			}
		});
	}
});

function limpiar(){
	$("#id_nombre").val('');
	$("#id_dni").val('');
	$("#id_fecha").val('');
	$("#id_tipo").val('');
	$("#id_pais").val('');
}

$('#id_form').bootstrapValidator({
    message: 'This value is not valid',
    feedbackIcons: {
        valid: 'glyphicon glyphicon-ok',
        invalid: 'glyphicon glyphicon-remove',
        validating: 'glyphicon glyphicon-refresh'
    },
    fields: {
    	nombre: {
    		selector : '#id_nombre',
            validators: {
                notEmpty: {
                    message: 'El nombre es un campo obligatorio'
                },
                stringLength :{
                	message:'El nombre es de 5 a 100 caracteres',
                	min : 5,
                	max : 100
                },
                remote :{
                	delay: 1000,
                	url: 'buscaPorNombreProveedor',
                	message: 'El nombre ya existe'
                }
            }
        },
        dni:{
            selector: "#id_dni",
            validators:{
                notEmpty: {
                     message: 'El DNI es obligatorio'
                },
                regexp: {
                    regexp: /^[0-9]{8}$/,
                    message: 'el DNI es 8 dígitos'
                },
                remote :{
                	delay: 200,
                	url: 'buscaPorDniProveedor',
                	message: 'El DNI ya existe'
                }
            }
        },
        fechaRegistro:{
            selector: "#id_fecha",
            validators:{
                notEmpty: {
                     message: 'La fecha es obligatorio'
                }
            }
        },
        tipo:{
            selector: "#id_tipo",
            validators:{
                notEmpty: {
                     message: 'El tipo es obligatorio'
                }
            }
        },
        pais: {
    		selector : '#id_pais',
            validators: {
            	notEmpty: {
                    message: 'El pais un campo obligatorio'
                },
            }
        },
    	
    }   
});

</script>


</body>
</html>




