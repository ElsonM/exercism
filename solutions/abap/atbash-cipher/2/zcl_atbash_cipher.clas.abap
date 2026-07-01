CLASS zcl_atbash_cipher DEFINITION PUBLIC FINAL CREATE PUBLIC.

  PUBLIC SECTION.
    METHODS decode
      IMPORTING
        cipher_text        TYPE string
      RETURNING
        VALUE(plain_text)  TYPE string.
        
    METHODS encode
      IMPORTING
        plain_text         TYPE string
      RETURNING
        VALUE(cipher_text) TYPE string.
        
  PROTECTED SECTION.
  
  PRIVATE SECTION.
    METHODS translate
      IMPORTING 
        input         TYPE string
      RETURNING 
        VALUE(output) TYPE string.
  
ENDCLASS.

CLASS zcl_atbash_cipher IMPLEMENTATION.

  METHOD decode.
    plain_text = translate( cipher_text ).
  ENDMETHOD.

  METHOD encode.
    DATA(encoded) = translate( plain_text ).

    DATA(length) = strlen( encoded ).

    DO length TIMES.
      DATA(index) = sy-index - 1.

      IF index > 0 AND index MOD 5 = 0.
        cipher_text &&= ` `.
      ENDIF.

      cipher_text &&= encoded+index(1).
    ENDDO.
  ENDMETHOD.

  METHOD translate.
    CONSTANTS:
      plain  TYPE string VALUE 'abcdefghijklmnopqrstuvwxyz',
      cipher TYPE string VALUE 'zyxwvutsrqponmlkjihgfedcba'.

    DATA(length) = strlen( input ).
    
    DO length TIMES.
      DATA(index) = sy-index - 1.
      DATA(digit) = to_lower( input+index(1) ).

      IF digit CO 'abcdefghijklmnopqrstuvwxyz'.
        FIND digit IN plain MATCH OFFSET DATA(offset).
        output &&= cipher+offset(1).
      ELSEIF digit CO '0123456789'.
        output &&= digit.
      ENDIF.
    ENDDO.
  ENDMETHOD.
  
ENDCLASS.