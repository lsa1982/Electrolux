Imports Elx.CommonClass

Public Class clsMatrizResponsabilidad
	Inherits clsEntidad

    Sub Lista()
        Dim strCx As New StringConex
        Dim dt As DataTable
        Dim strSql As String

        strSql = "Select " & _
                    "AL1.IDROL AS ID_ROL,  " & _
                 "al2.ROL AS categoryName,  " & _
                    "al1.nombre AS subCategoryName  " & _
                    "    From " & _
                 "elx_hr_personal al1, " & _
                 "elx_hr_rol al2 " & _
                    "    Where " & _
                 "al1.idRol = al2.IDROL"

            strCx.ejecutaSql(strSql)
       
        dt = strCx.retornaDataTable(strSql)

        If strCx.flagError Then
            rsp.estadoError(100, "Lista: No se pudo acceder a la base")
        Else
            rsp.totalFila = dt.Rows.Count
            rsp.args = Me.retornaTablaSerializada(dt)
            Debug.Print(rsp.args)
        End If
    End Sub

End Class
