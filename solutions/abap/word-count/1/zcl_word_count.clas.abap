CLASS zcl_word_count DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    TYPES:
      BEGIN OF return_structure,
        word  TYPE string,
        count TYPE i,
      END OF return_structure,
      return_table TYPE STANDARD TABLE OF return_structure WITH KEY word.

    METHODS count_words
      IMPORTING
        !phrase       TYPE string
      RETURNING
        VALUE(result) TYPE return_table.

ENDCLASS.

CLASS zcl_word_count IMPLEMENTATION.

  METHOD count_words.
    DATA(text) = to_lower( phrase ).

    " Replace everything except letters, numbers and apostrophes
    " with spaces.
    REPLACE ALL OCCURRENCES OF REGEX `(\\[nt]|[^a-z0-9'])+`
      IN text
      WITH ` `.

    SPLIT text AT space INTO TABLE DATA(words).

    LOOP AT words INTO DATA(word).
      IF word IS INITIAL.
        CONTINUE.
      ENDIF.

      " Apostrophes at the beginning/end are punctuation,
      " not part of a contraction.
      SHIFT word LEFT  DELETING LEADING  ''''.
      SHIFT word RIGHT DELETING TRAILING ''''.
      REPLACE ALL OCCURRENCES OF '''' IN word WITH ' '.
      CONDENSE word.

      IF word IS INITIAL.
        CONTINUE.
      ENDIF.

      ASSIGN result[ word = word ] TO FIELD-SYMBOL(<entry>).

      IF sy-subrc = 0.
        <entry>-count = <entry>-count + 1.
      ELSE.
        INSERT VALUE #( word  = word
                        count = 1 ) INTO TABLE result.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.
ENDCLASS.
