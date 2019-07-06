declare 
n number;
v_consulta varchar2(2) := 'N';
v_editar varchar2(2) := 'N';
v_alta varchar2(2) := 'N';
v_cancelar varchar2(2) := 'N';
v_permiso5 varchar2(2) := 'N';
v_permiso6 varchar2(2) := 'N';
nv number;

begin 
     case :APEX$ROW_STATUS 
     when 'C' then -- Note: In EA2 this has been changed from I to C for consistency with Tabular Forms
     
     SELECT count(REGEXP_SUBSTR(:TI_PERMISO, '[^:]+', 1, LEVEL)) INTO n FROM dual
     CONNECT BY REGEXP_SUBSTR(:TI_PERMISO, '[^:]+', 1, LEVEL) IS NOT NULL ;

    FOR nivel in 1..n
    LOOP
        SELECT REGEXP_SUBSTR(:TI_PERMISO, '[^:]+', 1, nivel) INTO nv FROM dual;
        IF (nv = 1) THEN
        v_consulta := 'S';
        ELSIF (nv = 2) THEN
        v_editar := 'S';
        ELSIF (nv = 3) THEN
        v_alta := 'S';
        ELSIF (nv = 4) THEN
        v_cancelar := 'S';
        ELSIF (nv = 5) THEN
        v_permiso5 := 'S';
        ELSIF (nv = 6) THEN
        v_permiso6 := 'S';
        END IF;
        
    END LOOP;
     
        insert into SEG_USUARIOS_OPC (SEG_USUARIOS_ID, SEG_OPCIONES_ID, TI_PERMISO, CONSULTA, EDIT, ALTA, CAN, PERMISO5, PERMISO6) 
        values (:P23_ID, :ID, :TI_PERMISO, v_consulta, v_editar, v_alta, v_cancelar, v_permiso5, v_permiso6 ) 
        returning ROWID into :ROWID; 

     when 'U' then 
     
     SELECT count(REGEXP_SUBSTR(:TI_PERMISO, '[^:]+', 1, LEVEL)) INTO n FROM dual
     CONNECT BY REGEXP_SUBSTR(:TI_PERMISO, '[^:]+', 1, LEVEL) IS NOT NULL ;

    FOR nivel in 1..n
    LOOP
        SELECT REGEXP_SUBSTR(:TI_PERMISO, '[^:]+', 1, nivel) INTO nv FROM dual;
        IF (nv = 1) THEN
        v_consulta := 'S';
        ELSIF (nv = 2) THEN
        v_editar := 'S';
        ELSIF (nv = 3) THEN
        v_alta := 'S';
        ELSIF (nv = 4) THEN
        v_cancelar := 'S';
        ELSIF (nv = 5) THEN
        v_permiso5 := 'S';
        ELSIF (nv = 6) THEN
        v_permiso6 := 'S';
        END IF;  
    END LOOP;
        
         update SEG_USUARIOS_OPC 
            set 
                TI_PERMISO = :TI_PERMISO, 
                CONSULTA = v_consulta,
                EDIT = v_editar,
                ALTA = v_alta,
                CAN = v_cancelar,
                PERMISO5 = v_permiso5,
                PERMISO6 = v_permiso6
                
          where SEG_USUARIOS_ID  = :P23_ID
          AND SEG_OPCIONES_ID = :ID; 
     when 'D' then 
         delete SEG_USUARIOS_OPC
         where SEG_USUARIOS_ID  = :P23_ID
          AND SEG_OPCIONES_ID = :ID; 
     end case; 
end;

