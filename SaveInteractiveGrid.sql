declare
  var_id_repetido number;

begin 
     select count(*)
     into   var_id_repetido
     from   SEG_USUARIOS_OPC
     where  SEG_OPCIONES_ID = :ID;
     
     case :APEX$ROW_STATUS 
     when 'C' then -- Note: In EA2 this has been changed from I to C for consistency with Tabular Forms
     
        insert into SEG_USUARIOS_OPC (SEG_USUARIOS_ID, SEG_OPCIONES_ID, CONSULTA, EDIT, ALTA, CAN, PERMISO5, PERMISO6) 
        values (:P23_ID, :ID, :CONSULTA, :EDIT, :ALTA, :CAN, :PERMISO5, :PERMISO6 ) 
        returning ROWID into :ROWID; 

     when 'U' then 
      
     IF var_id_repetido = 0 AND (:CONSULTA IS NOT NULL OR :EDIT IS NOT NULL OR :ALTA IS NOT NULL OR :CAN IS NOT NULL OR :PERMISO5 IS NOT NULL OR :PERMISO6 IS NOT NULL) THEN 
             insert into SEG_USUARIOS_OPC (SEG_USUARIOS_ID, SEG_OPCIONES_ID, CONSULTA, EDIT, ALTA, CAN, PERMISO5, PERMISO6) 
               values (:P23_ID, :ID, :CONSULTA, :EDIT, :ALTA, :CAN, :PERMISO5, :PERMISO6 );
               
     ELSIF var_id_repetido = 1 AND (:CONSULTA IS NULL AND :EDIT IS NULL AND :ALTA IS NULL AND :CAN IS NULL AND :PERMISO5 IS NULL AND :PERMISO6 IS  NULL) THEN 
       delete SEG_USUARIOS_OPC
       where SEG_USUARIOS_ID  = :P23_ID
       AND SEG_OPCIONES_ID = :ID; 
             
     
     ELSE 
      update SEG_USUARIOS_OPC 
            set  
                CONSULTA = :CONSULTA,
                EDIT = :EDIT,
                ALTA = :ALTA,
                CAN = :CAN,
                PERMISO5 = :PERMISO5,
                PERMISO6 = :PERMISO6
                
          where SEG_USUARIOS_ID  = :P23_ID
          AND SEG_OPCIONES_ID = :ID; 
     
     END IF; 
     
         
     when 'D' then 
         delete SEG_USUARIOS_OPC
         where SEG_USUARIOS_ID  = :P23_ID
          AND SEG_OPCIONES_ID = :ID; 
     end case; 
end;

