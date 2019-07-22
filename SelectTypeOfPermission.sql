SELECT 'Consulta', '1' from dual, SEG_OPCIONES opc
WHERE opc.TI_PERMISO1 = 'S' AND :ID_ROLE = opc.ID  
UNION ALL
SELECT 'Editar', '2' from dual, SEG_OPCIONES opc
WHERE opc.TI_PERMISO2 = 'S' AND :ID_ROLE = opc.ID   
UNION ALL
SELECT 'Alta', '3' from dual, SEG_OPCIONES opc 
WHERE opc.TI_PERMISO3 = 'S' AND :ID_ROLE = opc.ID  
UNION ALL
SELECT 'Cancelar', '4' from dual, SEG_OPCIONES opc
WHERE opc.TI_PERMISO4 = 'S' AND :ID_ROLE = opc.ID  