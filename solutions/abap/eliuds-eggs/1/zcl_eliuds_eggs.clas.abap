CLASS zcl_eliuds_eggs DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    METHODS egg_count 
      IMPORTING 
        number       TYPE i
      RETURNING 
        VALUE(count) TYPE i.
        
  PROTECTED SECTION.
  
  PRIVATE SECTION.
  
ENDCLASS.

CLASS zcl_eliuds_eggs IMPLEMENTATION.

  METHOD egg_count.
    DATA(local_number) = number.

    WHILE local_number > 0.
      IF local_number MOD 2 = 1.
        count += 1.
      ENDIF.

      local_number = local_number DIV 2.
    ENDWHILE.
  ENDMETHOD.
  
ENDCLASS.