

declare
  var_id_repetido number;

begin 


     select count(*)
     into   var_id_repetido
     from   SEG_USUARIOS_OPC
     where  SEG_OPCIONES_ID = :ID;
     
     case :APEX$ROW_STATUS 
     when 'C' then -- Note: In EA2 this has been changed from I to C for consistency with Tabular Forms
         
         
         IF :EDIT = 'S' AND :CONSULTA = 'N' THEN
            apex_error.add_error (
            p_message => 'No se puede tener permiso de Editar sin tener permiso de Consulta',
            p_display_location => apex_error.c_inline_in_notification);
         ELSE 
         
            insert into SEG_USUARIOS_OPC (SEG_USUARIOS_ID, SEG_OPCIONES_ID, CONSULTA, EDIT, ALTA, CAN, PERMISO5, PERMISO6) 
            values (:P23_ID, :ID, :CONSULTA, :EDIT, :ALTA, :CAN, :PERMISO5, :PERMISO6 ) 
            returning ROWID into :ROWID; 
            
         END IF;

     when 'U' then 
     
     
      IF :EDIT = 'S' AND :CONSULTA = 'N' THEN
            apex_error.add_error (
            p_message => 'No se puede tener permiso de Editar sin tener permiso de Consulta',
            p_display_location => apex_error.c_inline_in_notification);
       
      
     ELSIF var_id_repetido = 0 AND (:CONSULTA = 'S' OR :EDIT = 'S' OR :ALTA = 'S' OR :CAN = 'S' OR :PERMISO5 = 'S' OR :PERMISO6 = 'S') THEN 
             insert into SEG_USUARIOS_OPC (SEG_USUARIOS_ID, SEG_OPCIONES_ID, CONSULTA, EDIT, ALTA, CAN, PERMISO5, PERMISO6) 
               values (:P23_ID, :ID, :CONSULTA, :EDIT, :ALTA, :CAN, :PERMISO5, :PERMISO6);
               
     ELSIF var_id_repetido = 1 AND (:CONSULTA <> 'S' AND :EDIT <> 'S' AND :ALTA <> 'S' AND :CAN <> 'S' AND :PERMISO5 <> 'S' AND :PERMISO6 <> 'S') THEN 
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

