CLASS zcl_phone_number DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    METHODS clean
      IMPORTING
        !number       TYPE string
      RETURNING
        VALUE(result) TYPE string
      RAISING
        cx_parameter_invalid.
        
  PROTECTED SECTION.
  
  PRIVATE SECTION.
  
ENDCLASS.

CLASS zcl_phone_number IMPLEMENTATION.

  METHOD clean.
    result = number.

    " Remove allowed punctuation
    REPLACE ALL OCCURRENCES OF REGEX '[\s().+-]' IN result WITH ''.

    " Must contain only digits
    IF result CN '0123456789'.
      RAISE EXCEPTION TYPE cx_parameter_invalid.
    ENDIF.

    DATA(number_length) = strlen( result ).

    " Number must contain 10 or 11 digits
    IF number_length <> 10 AND number_length <> 11.
      RAISE EXCEPTION TYPE cx_parameter_invalid.
    ENDIF.

    " Handle country code
    IF number_length = 11.
      IF result(1) <> '1'.
        RAISE EXCEPTION TYPE cx_parameter_invalid.
      ENDIF.
      result = result+1.
    ENDIF.

    " Area code must start with 2-9
    IF result(1) CO '01'.
      RAISE EXCEPTION TYPE cx_parameter_invalid.
    ENDIF.

    " Exchange code must start with 2-9
    IF result+3(1) CO '01'.
      RAISE EXCEPTION TYPE cx_parameter_invalid.
    ENDIF.
  ENDMETHOD.
  
ENDCLASS.