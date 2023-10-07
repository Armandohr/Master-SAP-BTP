CLASS zcl_abap_delete_tables_5277 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_abap_delete_tables_5277 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    delete from ztacc_categ_5277.
    delete from ztcatego_5277.
    delete from ztclientes_5277.
    delete from ztclnts_lib_5277.
    delete from ztlibros_5277.

    if sy-subrc = 0.
        out->write( 'All data deleted' ).
    endif.

  ENDMETHOD.

ENDCLASS.
