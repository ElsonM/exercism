CLASS zcl_matrix DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    TYPES integertab TYPE STANDARD TABLE OF i WITH EMPTY KEY.
    METHODS matrix_row
      IMPORTING
        string        TYPE string
        index         TYPE i
      RETURNING
        VALUE(result) TYPE integertab.
        
    METHODS matrix_column
      IMPORTING
        string        TYPE string 
        index         TYPE i
      RETURNING
        VALUE(result) TYPE integertab.
        
  PROTECTED SECTION.
  
  PRIVATE SECTION.
    CONSTANTS newline_chars(2) TYPE c VALUE '\n'.

ENDCLASS.

CLASS zcl_matrix IMPLEMENTATION.

  METHOD matrix_row.
    DATA rows   TYPE STANDARD TABLE OF string WITH EMPTY KEY.
    DATA values TYPE STANDARD TABLE OF string WITH EMPTY KEY.

    " Split matrix into rows
    SPLIT string AT newline_chars
      INTO TABLE rows.

    " Get requested row
    DATA(row) = rows[ index ].

    " Split row into individual values
    SPLIT row AT space INTO TABLE values.

    LOOP AT values INTO DATA(value).
      IF value IS NOT INITIAL.
        APPEND CONV i( value ) TO result.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD matrix_column.
    DATA rows   TYPE STANDARD TABLE OF string WITH EMPTY KEY.
    DATA values TYPE STANDARD TABLE OF string WITH EMPTY KEY.

    " Split matrix into rows
    SPLIT string AT newline_chars
      INTO TABLE rows.

    LOOP AT rows INTO DATA(row).
      " Ignore empty rows
      IF row IS INITIAL.
        CONTINUE.
      ENDIF.

      " Split current row into values
      SPLIT row AT space INTO TABLE values.

      " Remove empty entries caused by multiple spaces
      DELETE values WHERE table_line IS INITIAL.

      " Take the requested column
      APPEND CONV i( values[ index ] ) TO result.

      CLEAR values.
    ENDLOOP.
  ENDMETHOD.

ENDCLASS.
