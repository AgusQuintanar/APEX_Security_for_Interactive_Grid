create or replace FUNCTION FNC_CHECAR_PERMISOS_PAGINA 
(
  USUARIO in VARCHAR2,
  NUM_PAGINA IN NUMBER 
) RETURN VARCHAR2 AS 


    CURSOR Cur_Ti_Permisos IS 
    SELECT TI_PERMISO
        FROM SEG_TI_PERMISO
        WHERE PAGINA = NUM_PAGINA;

    C_Ti_Permisos Cur_Ti_Permisos%ROWTYPE;

    ti_permisos_sin_permiso VARCHAR2(300) := '';

BEGIN
    OPEN Cur_Ti_Permisos;
    
    LOOP
        FETCH Cur_Ti_Permisos INTO C_Ti_Permisos;
        EXIT WHEN Cur_Ti_Permisos%NOTFOUND;       

        IF NOT FNC_CHECAR_PERMISO(USUARIO,NUM_PAGINA, upper(C_Ti_Permisos.TI_PERMISO)) THEN
            ti_permisos_sin_permiso := CONCAT( ti_permisos_sin_permiso, USUARIO || ' no tiene permiso de ' || C_Ti_Permisos.TI_PERMISO || ' en esta página.'|| chr(13)||chr(10) );
        END IF;
       
    END LOOP;

    CLOSE Cur_Ti_Permisos;

  RETURN ti_permisos_sin_permiso;

END;