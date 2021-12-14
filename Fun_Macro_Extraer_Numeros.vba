Function EXTRAENUM(cadena As String)
 
'Variable numeros contendrá solo números de la cadena
Dim numeros As String
numeros = ""
 
'Recorrer la cadena
For i = 1 To Len(cadena)
     
    'Evaluar SI el carácter actual es un número
    If IsNumeric(Mid(cadena, i, 1)) Then
         
        'Concatenar valor numérico a la variable numeros
        numeros = numeros & Mid(cadena, i, 1)
     
    End If
Next
 
'Devolver los números encontrados.
EXTRAENUM = numeros
 
End Function
