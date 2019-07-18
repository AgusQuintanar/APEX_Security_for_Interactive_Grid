SELECT opc.NOMBRE,
        opc.ID, 
        v.seg_usuarios_id, 
        v.CONSULTA, 
        v.EDIT, 
        v.ALTA, 
        v.CAN,
        v.PERMISO5,
        v.PERMISO6


FROM SEG_OPCIONES opc LEFT JOIN SEG_USUARIOS_OPC v 
ON v.SEG_OPCIONES_ID = opc.ID AND seg_usuarios_id = :P23_ID 
WHERE opc.ARCHIVO IS NOT NULL


