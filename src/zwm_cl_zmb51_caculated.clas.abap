CLASS zwm_cl_zmb51_caculated DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_sadl_exit_calc_element_read.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZWM_CL_ZMB51_CACULATED IMPLEMENTATION.


  METHOD if_sadl_exit_calc_element_read~calculate.
    DATA: lt_mat          TYPE STANDARD TABLE OF zwm_i_header WITH DEFAULT KEY,
          lt_product_conv TYPE zcore_cl_get_long_text=>ty_product.
    DATA: ls_check_author TYPE abap_boolean.
    TYPES:
      BEGIN OF y_product,
        material TYPE c LENGTH 18,
        language TYPE c LENGTH 2,
      END OF y_product,
      ty_product TYPE SORTED TABLE OF y_product WITH UNIQUE KEY material.

    lt_mat     = CORRESPONDING #( it_original_data ).
    DATA(lt_product_conv_mat) = CORRESPONDING ty_product( lt_mat DISCARDING DUPLICATES ).

    lt_product_conv = VALUE #( FOR lsproduct_conv_mat IN lt_product_conv_mat
                                     ( product = lsproduct_conv_mat-material
                                        language = 'EN' ) ).

*  lt_product_conv = VALUE #( FOR ls_matr IN lt_mat
*                            ( product = ls_matr-mat ) ).
*    DATA(lt_plant) = CORRESPONDING ty_plant( lt_mat DISCARDING DUPLICATES ).
*    DATA(lt_salesorg) = CORRESPONDING ty_salesorg( lt_mat DISCARDING DUPLICATES ).
    DATA(lt_product) = CORRESPONDING zcore_cl_get_long_text=>ty_product( lt_product_conv DISCARDING DUPLICATES ).
    DATA(lt_basictextmat) = zcore_cl_get_long_text=>get_multi_material_basic_text( it_material = lt_product ).

    AUTHORITY-CHECK OBJECT 'ZAO_BCNXTN'
                        ID 'ACTVT'      FIELD '03'
                        ID 'ZAF_BCNXTN' FIELD 'X'.
    IF sy-subrc <> 0.
      ls_check_author = abap_false.
    ELSE.
      ls_check_author = abap_true.
    ENDIF.

    LOOP AT lt_mat REFERENCE INTO DATA(ls_mat).
      READ TABLE lt_basictextmat INTO DATA(ls_basic) WITH KEY product = ls_mat->material  .
      IF sy-subrc  = 0.
        ls_mat->tendai = ls_basic-long_text.
      ENDIF.
      IF ls_check_author EQ abap_true.
        ls_mat->amount =  ls_mat->totalgoodsmvtamtincccrcy .
      ENDIF.

    ENDLOOP.
    ct_calculated_data = CORRESPONDING #( lt_mat ).

  ENDMETHOD.


  METHOD if_sadl_exit_calc_element_read~get_calculation_info.
    DATA: lt_elements TYPE TABLE OF string .
*    LOOP AT it_requested_calc_elements ASSIGNING FIELD-SYMBOL(<fs_calc_element>).
*      CASE <fs_calc_element>.
*        WHEN 'TYPEDESC'.
*          APPEND 'WHSEPROCESSTYPE' TO lt_elements.
*        WHEN 'CATDESC'.
*          APPEND 'WHSEPROCAT' TO lt_elements.
*        WHEN 'STOCKTYPENAME'.
*          APPEND 'EWMSTOCKTYPE' TO lt_elements.
*        WHEN 'DELIVERYORDER'.
*          APPEND 'EWMWAREHOUSE' TO lt_elements.
*          APPEND 'WAREHOUSETASK' TO lt_elements.
*          APPEND 'WAREHOUSETASKITEM' TO lt_elements.
*        WHEN OTHERS.
*      ENDCASE.
*    ENDLOOP.
    APPEND 'MATERIAL' TO lt_elements.
    APPEND 'TOTALGOODSMVTAMTINCCCRCY' TO lt_elements.
    et_requested_orig_elements = CORRESPONDING #( lt_elements ).
  ENDMETHOD.
ENDCLASS.
