CLASS zcl_prime_factors DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    TYPES integertab TYPE STANDARD TABLE OF i WITH EMPTY KEY.
    
    METHODS factors
      IMPORTING
        input         TYPE int8
      RETURNING
        VALUE(result) TYPE integertab.
  
  PROTECTED SECTION.
  
  PRIVATE SECTION.

ENDCLASS.

CLASS zcl_prime_factors IMPLEMENTATION.
  
  METHOD factors.
    DATA(number) = input.
    DATA(divisor) = CONV int8( 2 ).

    WHILE number > 1.
      IF number MOD divisor = 0.
        APPEND CONV i( divisor ) TO result.
        number = number DIV divisor.
      ELSE.
        divisor = divisor + 1.
      ENDIF.
    ENDWHILE.
  ENDMETHOD.

ENDCLASS.