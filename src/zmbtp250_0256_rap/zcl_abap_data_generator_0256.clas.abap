CLASS zcl_abap_data_generator_0256 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_abap_data_generator_0256 IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    out->write( |----> Travel| ).

    DELETE FROM ztravel_0256_a.                         "#EC CI_NOWHERE
    DELETE FROM ztravel_0256_d.                         "#EC CI_NOWHERE

    INSERT ztravel_0256_a FROM (
        SELECT FROM /dmo/travel FIELDS
           " client
           uuid( ) AS travel_uuid,
           travel_id,
           agency_id,
           customer_id,
           begin_date,
           end_date,
           booking_fee,
           total_price,
           currency_code,
           description,
           CASE status WHEN 'B' THEN 'A'
                       WHEN 'p' THEN 'O'
                       WHEN 'N' THEN 'O'
                       ELSE 'X'  END AS overall_status,
           createdby  AS local_created_by,
           createdat AS  local_created_at,
           lastchangedby  AS     local_last_changed_by,
           lastchangedat AS local_last_changed_at,
           lastchangedat AS last_changed_at
        WHERE travel_id BETWEEN '00000001' AND '00000025' ).


    IF sy-subrc EQ 0.
      out->write( | Travel entries inserted: { sy-dbcnt } | ).
    ENDIF.

    " bookings
    out->write( |-----> Bookings| ).

    DELETE FROM zbooking_0256_a.                        "#EC CI_NOWHERE
    DELETE FROM zbooking_0256_d.                        "#EC CI_NOWHERE

    INSERT zbooking_0256_a FROM (
        SELECT
          FROM /dmo/booking
          JOIN ztravel_0256_a ON /dmo/booking~travel_id = ztravel_0256_a~travel_id
          JOIN /dmo/travel ON /dmo/travel~travel_id = /dmo/booking~travel_id
        FIELDS  "client,
               uuid( ) AS booking_uuid,
               ztravel_0256_a~travel_uuid AS parent_uuid,
               /dmo/booking~booking_id,
               /dmo/booking~booking_date,
               /dmo/booking~customer_id,
               /dmo/booking~carrier_id,
               /dmo/booking~connection_id,
               /dmo/booking~flight_date,
               /dmo/booking~flight_price,
               /dmo/booking~currency_code,
               CASE /dmo/travel~status WHEN 'P' THEN 'N'
                                       ELSE /dmo/travel~status END AS booking_status,
               ztravel_0256_a~last_changed_at AS local_last_changed_at ).

    IF sy-subrc EQ 0.
      out->write( | Booking entries inserted:   { sy-dbcnt }| ).
    ENDIF.

    " supplements
    out->write( |----> Bookings| ).

    DELETE FROM zbksuppl_0256_a.                        "'#EC CI_NOWHERE
    DELETE FROM zbksuppl_0256_d.                        "#EC CI_NOWHERE

    INSERT zbksuppl_0256_a FROM (
        SELECT FROM /dmo/book_suppl AS supp
        JOIN ztravel_0256_a   AS  trvl ON trvl~travel_id = supp~travel_id
        JOIN zbooking_0256_a  AS book ON book~parent_uuid = trvl~travel_uuid
                                     AND book~booking_id = supp~booking_id

        FIELDS
                "client
                uuid( )                              AS booksuppl_uuid,
                trvl~travel_uuid              AS root_uuid,
                book~booking_uuid             AS parent_uuid,
                supp~booking_supplement_id,
                supp~supplement_id,
                supp~price,
                supp~currency_code,
                trvl~last_changed_at      AS local_last_changed_at ).

    IF  sy-subrc EQ 0.
      out->write( | Supplements entries inserted: { sy-dbcnt } | ).
    ENDIF.

  ENDMETHOD.

ENDCLASS.
