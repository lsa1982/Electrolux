<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Core.Master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="DetailContent" runat="server">
<div class="msgPagina">
<button id="button" type="button">Agregar Nuevo Usuario</button>
</div>
<div id="grid" style="height: 380px"></div>
<div id="winNewRequest">Espere Mientras se actualizan los datos</div>
<script>
    var dsUsuario = new kendo.data.DataSource({
        transport: {
            read: { url: strInterOpAs("clsUsuario", "lista", "Core"), dataType: "json", type: "POST" },
            destroy: { url: strInterOpAs("clsUsuario", "eliminar", "Core"), dataType: "json", type: "POST" },
            update: { url: strInterOpAs("clsUsuario", "editar", "Core"), dataType: "json", type: "POST" },
            create: { url: strInterOpAs("clsUsuario", "insertar", "Core"), dataType: "json", type: "POST" },
            parameterMap: function (options, operation) {
                if (operation !== "read" && options.models) {
                    return { txtidUsuario: options.models[0].idUsuario,
                        "txtidRol": options.models[0].idRol,
                        "txtNombre": options.models[0].nombre,
                        "txtApellido": options.models[0].apellido,
                        "txtCargo": options.models[0].cargo,
                        "txtAntiguedad": options.models[0].antiguedad,
                        "txtFechaNacimiento": options.models[0].fechaNacimiento,
                        "txtultimaModificacion": options.models[0].ultimaModificacion,
                        "txtFono": options.models[0].fono,
                        "txtEmail": options.models[0].email,
                        "txtUsuario": options.models[0].email,
                        "txtROL": options.models[0].ROL
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
        serverFiltering: true,
        pageSize: 30,
        schema: {
            errors: "msgState",
            data: "args",
            total: "totalFila",
            model: {
                id: "idUsuario",
                fields: {
                    idUsuario: { editable: false, nullable: true },
                    idRol: { editable: false, nullable: true },
                    nombre: { validation: { required: false} },
                    apellido: { validation: { required: false} },
                    cargo: { validation: { required: false} },
                    antiguedad: { validation: { required: false} },
                    fechaNacimiento: { validation: { required: false} },
                    fono: { validation: { required: false} },
                    email: { validation: { required: false} },
                    usuario: { validation: { required: false} },
                    ROL: { validation: { required: false} },
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
{ field: "idUsuario", title: "ID", width: "40px" },
{ field: "ROL", title: "Rol", width: "120px" },
{ field: "nombre", title: "Nombre", width: "120px" },
{ field: "apellido", title: "Apellido", width: "100px" },
{ field: "cargo", title: "Cargo", width: "80px" },
{ field: "antiguedad", title: "Antiguedad", width: "100px" },
{ field: "fechaNacimiento", title: "Fecha Nacimiento", width: "150px" },
{ field: "fono", title: "Fono", width: "100px" },
{ field: "email", title: "Email", width: "100px" },
{ field: "usuario", title: "Usuario", width: "100px" },
{ field: "ultimaModificacion", title: "Ultima Modificacion", width: "180px" }
];
        $("#grid").kendoGrid({
            pageable: { pageable: true, pageSizes: [5, 10, 25, 50] },
            dataSource: dsUsuario,
            sortable: true,
            filterable: filtroGrid,
            selectable: "multiple",
            resizable: true,
            height: 450,
            columns: gridColumns,
            editable: {
                mode: "inline",
                confirmation: "¿Está seguro que desea borrar el registro?"
            }
        });
        $("#winNewRequest").kendoWindow({
            width: "400px",
            title: "Ingreso Nuevo Usuario",
            actions: ["Close"],
            visible: false,
            modal: true,
            content: "frmUsuario.html"
        });
    });
</script>
</asp:Content>