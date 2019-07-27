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
            (SELECT ID_PERMISO
                FROM SEG_TI_PERMISO
                WHERE   (
                        (upper(ti_permiso) = 'CONSULTA' and PAG_CONSULTA = num_pagina) or
                        (upper(ti_permiso) = 'EDITAR' and PAG_EDITAR = num_pagina) or
                        (upper(ti_permiso) = 'CANCELAR' and PAG_CANCELAR = num_pagina) or
                        (upper(ti_permiso) = 'ALTA' and PAG_ALTA = num_pagina) or
                        (upper(ti_permiso) = 'PERMISO5' and PAG_PERMISO5 = num_pagina) or
                        (upper(ti_permiso) = 'PERMISO6' and PAG_PERMISO6 = num_pagina)
                    )
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

    RETURN C_Permisos = 1; --Como el Query regresa 1 si es verdadero, este se compara. Y explicitamente si son iguales retorna True, y si no retorna False.

    
END;





