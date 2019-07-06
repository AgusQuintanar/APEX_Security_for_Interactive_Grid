begin 
     case :APEX$ROW_STATUS 
     when 'C' then -- Note: In EA2 this has been changed from I to C for consistency with Tabular Forms
     
        insert into SEG_USUARIOS_OPC (SEG_USUARIOS_ID, SEG_OPCIONES_ID, CONSULTA, EDIT, ALTA, CAN, PERMISO5, PERMISO6) 
        values (:P23_ID, :ID, :CONSULTA, :EDIT, :ALTA, :CAN, :PERMISO5, :PERMISO6 ) 
        returning ROWID into :ROWID; 

     when 'U' then         
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
     when 'D' then 
         delete SEG_USUARIOS_OPC
         where SEG_USUARIOS_ID  = :P23_ID
          AND SEG_OPCIONES_ID = :ID; 
     end case; 
end;

