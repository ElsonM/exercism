CLASS zcl_anagram DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    METHODS anagram
      IMPORTING
        input         TYPE string
        candidates    TYPE string_table
      RETURNING
        VALUE(result) TYPE string_table.

  PROTECTED SECTION.

  PRIVATE SECTION.

ENDCLASS.

CLASS zcl_anagram IMPLEMENTATION.

  METHOD anagram.
    DATA position TYPE i.

    DATA sorted_chars_of_input TYPE string_table.
    DATA sorted_chars_of_candidate TYPE string_table.

    DATA(lowercase_input) = to_lower( input ).
    DATA(length_of_input) = strlen( input ).

    " Build the input character table only once
    DO length_of_input TIMES.
      position = sy-index - 1.
      APPEND lowercase_input+position(1) TO sorted_chars_of_input.
    ENDDO.
    SORT sorted_chars_of_input.
    CLEAR position.

    LOOP AT candidates INTO DATA(candidate).
      DATA(lowercase_candidate) = to_lower( candidate ).

      IF lowercase_candidate = lowercase_input.
        CONTINUE.
      ENDIF.

      DATA(length_of_candidate) = strlen( candidate ).

      IF length_of_input = length_of_candidate.
        DO length_of_candidate TIMES.
          position = sy-index - 1.
          APPEND lowercase_candidate+position(1) TO sorted_chars_of_candidate.
        ENDDO.
        SORT sorted_chars_of_candidate.
        CLEAR position.

        IF sorted_chars_of_input = sorted_chars_of_candidate.
          APPEND candidate TO result.
        ENDIF.

        CLEAR sorted_chars_of_candidate.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.
  
ENDCLASS.