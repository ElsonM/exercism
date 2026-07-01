CLASS zcl_binary_search DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    TYPES integertab TYPE STANDARD TABLE OF i WITH EMPTY KEY.
    
    METHODS binary_search
      IMPORTING
        val           TYPE i
        table         TYPE integertab
      RETURNING
        VALUE(result) TYPE i
      RAISING
        cx_sy_itab_line_not_found.
        
  PROTECTED SECTION.
  
  PRIVATE SECTION.
  
ENDCLASS.

CLASS zcl_binary_search IMPLEMENTATION.

  METHOD binary_search.
    DATA(low) = 1.
    DATA(high) = lines( table ).

    WHILE low <= high.
      DATA(middle) = ( low + high ) DIV 2.
      DATA(current_number) = table[ middle ].

      IF current_number = val.
        result = middle.
        RETURN.
      ELSEIF current_number < val.
        low = middle + 1.
      ELSE.
        high = middle - 1.
      ENDIF.
    ENDWHILE.

    RAISE EXCEPTION TYPE cx_sy_itab_line_not_found.
  ENDMETHOD.
  
ENDCLASS.