CLASS zcl_space_age DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    TYPES age_in_years TYPE p LENGTH 3 DECIMALS 2.
    
    METHODS age
      IMPORTING
        planet        TYPE string
        seconds       TYPE i
      RETURNING
        VALUE(result) TYPE age_in_years
      RAISING
        cx_parameter_invalid.
        
  PROTECTED SECTION.
  
  PRIVATE SECTION.

ENDCLASS.

CLASS zcl_space_age IMPLEMENTATION.
  METHOD age.
    CONSTANTS earth_years_in_seconds TYPE i VALUE 31557600.
  
    TYPES: 
      BEGIN OF ty_planet,
        planet         TYPE string,
        orbital_period TYPE decfloat34,
      END OF ty_planet,
      tt_planet TYPE TABLE OF ty_planet WITH NON-UNIQUE KEY planet.

    DATA(planet_data) = VALUE tt_planet(
      ( planet = 'Mercury' orbital_period = '0.2408467'  )
      ( planet = 'Venus'   orbital_period = '0.61519726' )
      ( planet = 'Earth'   orbital_period = '1.0'        )
      ( planet = 'Mars'    orbital_period = '1.8808158'  )
      ( planet = 'Jupiter' orbital_period = '11.862615'  )
      ( planet = 'Saturn'  orbital_period = '29.447498'  )
      ( planet = 'Uranus'  orbital_period = '84.016846'  )
      ( planet = 'Neptune' orbital_period = '164.79132'  ) ).
  
    TRY.
        DATA(orbital_period) = planet_data[ planet = planet ]-orbital_period.
      CATCH cx_sy_itab_line_not_found.
        RAISE EXCEPTION TYPE cx_parameter_invalid.
    ENDTRY.

    result = seconds / earth_years_in_seconds / orbital_period.
  ENDMETHOD.

ENDCLASS.