CLASS zcl_pangram DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    METHODS is_pangram
      IMPORTING
        VALUE(sentence) TYPE string
      RETURNING
        VALUE(result) TYPE abap_bool.
        
  PROTECTED SECTION.
  
  PRIVATE SECTION.

ENDCLASS.

CLASS zcl_pangram IMPLEMENTATION.
  
  METHOD is_pangram.
    DATA alphabet TYPE string VALUE 'abcdefghijklmnopqrstuvwxyz'.
    DATA number_of_alphabet_characters TYPE i VALUE 26.

    result = abap_true.

    DATA(local_sentence) = to_lower( sentence ).

    DO number_of_alphabet_characters TIMES.
      DATA(position) = sy-index - 1.
      DATA(character) = alphabet+position(1).

      IF local_sentence NS character.
        result = abap_false.
        RETURN.
      ENDIF.
    ENDDO.
  ENDMETHOD.

ENDCLASS.