SELECT 1
FROM  DUAL
WHERE  
    (SELECT ID
        FROM SEG_OPCIONES
        WHERE PAGINA = :APP_PAGE
    )
    IN    
    (SELECT usopc.SEG_OPCIONES_ID --Selecciona todos los ids de permisos que posee el usuario donde pueda consultar  
        FROM SEG_USUARIOS su, SEG_USUARIOS_OPC usopc
        WHERE su.NOMBRE = :APP_USER
        AND su.ID = usopc.SEG_USUARIOS_ID
        AND usopc.CONSULTA = 'S'
    )