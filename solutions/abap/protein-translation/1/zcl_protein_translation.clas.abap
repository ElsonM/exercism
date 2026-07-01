CLASS zcl_protein_translation DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    METHODS proteins
      IMPORTING
        strand        TYPE string
      RETURNING
        VALUE(result) TYPE string_table
      RAISING
        cx_parameter_invalid.
        
  PROTECTED SECTION.
  
  PRIVATE SECTION.

ENDCLASS.

CLASS zcl_protein_translation IMPLEMENTATION.

  METHOD proteins.
    DATA(offset) = 0.
    DATA(length) = strlen( strand ).

    WHILE offset < length.
      TRY.
          DATA(codon) = substring( val = strand
                                   off = offset
                                   len = 3 ).
      
          CASE codon.
            WHEN 'AUG'.
              APPEND 'Methionine' TO result.
            WHEN 'UUU' OR 'UUC'.
              APPEND 'Phenylalanine' TO result.
            WHEN 'UUA' OR 'UUG'.
              APPEND 'Leucine' TO result.
            WHEN 'UCU' OR 'UCC' OR 'UCA' OR 'UCG'.
              APPEND 'Serine' TO result.
            WHEN 'UAU' OR 'UAC'.
              APPEND 'Tyrosine' TO result.
            WHEN 'UGU' OR 'UGC'.
              APPEND 'Cysteine' TO result.
            WHEN 'UGG'.
              APPEND 'Tryptophan' TO result.
            WHEN 'UAA' OR 'UAG' OR 'UGA'.
              RETURN.
            WHEN OTHERS.
              RAISE EXCEPTION TYPE cx_parameter_invalid.
          ENDCASE. 

          offset += 3.
        CATCH cx_sy_range_out_of_bounds.
          RAISE EXCEPTION TYPE cx_parameter_invalid.
      ENDTRY.
    ENDWHILE.
  ENDMETHOD.
  
ENDCLASS.