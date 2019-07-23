create or replace function "FNC_CHECAR_PERMISO"
    (usuario in VARCHAR2,
    num_pagina in NUMBER,
    ti_permiso in VARCHAR2)
return BOOLEAN 
IS
     C_Permisos number;	
     
 
    CURSOR Cur_Permisos IS 
        SELECT 1 FROM  DUAL
        WHERE  
            (SELECT ID
                FROM SEG_OPCIONES
                WHERE PAGINA = num_pagina
            )
            IN    
            (SELECT usopc.SEG_OPCIONES_ID 
                FROM SEG_USUARIOS su, SEG_USUARIOS_OPC usopc
                WHERE su.NOMBRE = usuario
                AND su.ID = usopc.SEG_USUARIOS_ID
                AND (
                        (upper(ti_permiso) = 'CONSULTA' and usopc.CONSULTA = 'S') or
                        (upper(ti_permiso) = 'EDITAR' and usopc.EDIT = 'S') or
                        (upper(ti_permiso) = 'CANCELAR' and usopc.CAN = 'S') or
                        (upper(ti_permiso) = 'ALTA' and usopc.ALTA = 'S') or
                        (upper(ti_permiso) = 'PERMISO5' and usopc.PERMISO5 = 'S') or
                        (upper(ti_permiso) = 'PERMISO6' and usopc.PERMISO6 = 'S')
                    )
        );
        
       
	
    
BEGIN
    OPEN Cur_Permisos;
    
    LOOP
    FETCH Cur_Permisos INTO C_Permisos;
    IF Cur_Permisos%NOTFOUND
    THEN
    EXIT;
    END IF;
    END LOOP;
    Dbms_output.put_line(C_Permisos);
    CLOSE Cur_Permisos;

    RETURN C_Permisos = 1;

    
END;





