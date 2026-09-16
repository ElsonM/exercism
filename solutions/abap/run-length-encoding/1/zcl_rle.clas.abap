CLASS zcl_rle DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    METHODS encode
      IMPORTING
        input         TYPE string
      RETURNING
        VALUE(result) TYPE string.

    METHODS decode
      IMPORTING
        input         TYPE string
      RETURNING
        VALUE(result) TYPE string. 

ENDCLASS.

CLASS zcl_rle IMPLEMENTATION.

  METHOD encode.
    IF input IS INITIAL.
      RETURN.
    ENDIF.

    DATA(current_char) = input(1).
    DATA(count) = 1.
    DATA(number_of_loops) = strlen( input ) - 1.

    DO number_of_loops TIMES.
      DATA(index) = sy-index.
      DATA(char) = input+index(1).

      IF char = current_char.
        count += 1.
      ELSE.
        IF count > 1.
          result &&= |{ count }|.
        ENDIF.

        result &&= current_char.

        current_char = char.
        count = 1.
      ENDIF.
    ENDDO.

    " Add the final run
    IF count > 1.
      result &&= |{ count }|.
    ENDIF.

    result &&= current_char.
  ENDMETHOD.

  METHOD decode.
    IF input IS INITIAL.
      RETURN.
    ENDIF.
  
    DATA count_string TYPE string.

    DATA(number_of_loops) = strlen( input ).

    DO number_of_loops TIMES.
      DATA(index) = sy-index - 1.
      DATA(char)  = input+index(1).

      IF char CO '0123456789'.
        count_string &&= char.
      ELSE.
        DATA(count) = COND i(
          WHEN count_string IS INITIAL
          THEN 1
          ELSE CONV i( count_string )
        ).

        DO count TIMES.
          result &&= char.
        ENDDO.

        CLEAR count_string.
      ENDIF.
    ENDDO.
  ENDMETHOD.
  
ENDCLASS.