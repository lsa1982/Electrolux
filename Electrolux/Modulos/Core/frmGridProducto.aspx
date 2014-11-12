<%@ Page Title="" Language="vb" AutoEventWireup="false"  MasterPageFile="~/Core.Master" %>


<asp:Content ID="Content1" ContentPlaceHolderID="DetailContent" runat="server">
<div class="msgPagina">
<div id="winCargaImagen" style="font-size: 11px">
	<table>
		<tr>
			<td>Seleccione la imagenes que desea subir: </td>
		</tr>
		<tr>
			<td><input id="imgNewImagen" type="file" name="imgNewImagen" validationMessage="Select movie" /></td>
		</tr>
		<tr>
			<td><div id="uploadMsg"></div></td>
		</tr>
	</table>
	<table id="layerInfoImagen" style="display:none">
		<tr>
			<td colspan="2" >Ingrese información adicional sobre la imagen:</td>
		</tr>
		<tr>
			<td>Información</td>
			<td>
				<input id="txtInformacion" type="text" class="k-textbox" /> 
				<input id="txtUpload" type="hidden"/>
			</td>
		</tr>
		<tr>
			<td>Imagen Principal</td>
			<td>
				<select id="txtImagenPrincipal">
					<option value="0">No</option>
					<option value="1">Si</option>
				</select>
			</td>
		</tr>
		<tr>
			<td>&nbsp;</td>
			<td>
				<button id="btnImagenSend" type="button" class="k-button-red">Subir </button>
				<button id="btnImagenCancel" type="button" class="k-button-red">Cancelar </button>
			</td>
		</tr>
	</table>
</div>
	<button id="button" type="button">Agregar Nuevo Producto</button>
</div>
<div id="grid" style="height: 380px"></div>
<div id="winNewRequest">Espere Mientras se actualizan los datos</div>
<script>

	var ds = new kendo.data.DataSource({
		transport: {
			read: { url: strInterOpAs("clsProducto", "lista", "Core"), dataType: "json", type: "POST" },
			destroy: { url: strInterOpAs("clsProducto", "eliminar", "Core"), dataType: "json" },
			update: { url: strInterOpAs("clsProducto", "editar", "Core"), dataType: "json", type: "POST" },
			create: { url: strInterOpAs("clsProducto", "insertar", "Core"), dataType: "json", type: "POST" },
			parameterMap: function (options, operation) {
				if (operation !== "read" && options.models) {
					return { txtidProducto: options.models[0].idProducto,
						"txtidCategoria": options.models[0].idCategoria,
						"txtidLinea": options.models[0].idLinea,
						"txtidLMarca": options.models[0].idMarca,
						"txtNombre": options.models[0].nombre,
						"txtDescripcion": options.models[0].descripcion,
						"txtModelo": options.models[0].modelo,
						"txtCodigo": options.models[0].codigo,
						"txtCodigoBarra": options.models[0].codigoBarra,
						"txtResumen": options.models[0].resumen,
						"txtUltimaModificacion": options.models[0].ultimaModificacion,
						"txtMarca": options.models[0].marca,
						"txtCategoria": options.models[0].categoria
					};
				}
				else {
					return options;
				}
			}
		},
		batch: true,
		resizable: true,
		error: errorGrid,
		serverPaging: true,
		pageSize: 50,
		schema: {
			errors: "msgState",
			data: "args",
			total: "totalFila",
			model: {
				id: "idProducto",
				fields: {
					idProducto: { editable: false, nullable: true },
					categoria: { editable: false, nullable: true },
					marca: { editable: false, nullable: true },
					nombre: { validation: { required: false} },
					descripcion: { validation: { required: false} },
					modelo: { validation: { required: false} },
					codigo: { validation: { required: false} },
					codigoBarra: { validation: { required: false} },
					resumen: { validation: { required: false} },
					ultimaModificacion: { editable: false, nullable: true }

				}
			}
		}
	});


    $(document).ready(function () {


        $("#button").kendoButton({ icon: "plus", click: function (e) {
            $("#winNewRequest").data("kendoWindow").center().open();
        }
        });

      
        var gridColumns = [
			cmdGrid,
			{ field: "idProducto", title: "ID", width: "40px" },
			{ field: "categoria", title: "Categoria", width: "120px" },
            { field: "marca", title: "Marca", width: "100px" },
            { field: "nombre", title: "Nombre", width: "170px" },
            { field: "descripcion", title: "Descripcion", width: "120px" },
			{ field: "modelo", title: "Modelo", width: "130px" },
            { field: "codigo", title: "Codigo", width: "100px" },
            { field: "codigoBarra", title: "Codigo Barra", width: "100px" },
			{ field: "resumen", title: "Resumen", width: "120px" },
            { field: "ultimaModificacion", title: "Ultima Modificacion", width: "150px" },
			];


        $("#grid").kendoGrid({
            dataSource: ds,
            pageable: true,
            height: 550,
            filterable: filtroGrid,
            columns: gridColumns,
            editable: {
                mode: "inline",
                confirmation: "¿Está seguro que desea borrar el registro?"
            }

        });

        $("#winNewRequest").kendoWindow({
            width: "400px",
            title: "Ingreso Nuevo Producto",
            actions: ["Close"],
            visible: false,
            modal: true,
            content: "frmProducto.html"
        });
    });
</script>

</asp:Content>
