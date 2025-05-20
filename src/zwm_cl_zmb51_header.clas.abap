CLASS zwm_cl_zmb51_header DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES
      if_rap_query_provider.

  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA: gt_data        TYPE TABLE OF zwm_i_header.

    DATA : gr_werks                    TYPE RANGE OF zwm_i_header-plant,
           gr_storagelocation          TYPE RANGE OF zwm_i_header-storagelocation,
           gr_material                 TYPE RANGE OF zwm_i_header-material,
           gr_producttype              TYPE RANGE OF zwm_i_header-producttype,
           gr_productgroup             TYPE RANGE OF zwm_i_header-productgroup,
           gr_issgorrcvgspclstockind   TYPE RANGE OF zwm_i_header-issgorrcvgspclstockind,
           gr_salesorder               TYPE RANGE OF zwm_i_header-salesorder,
           gr_salesorderitem           TYPE RANGE OF zwm_i_header-salesorderitem,
           gr_customer                 TYPE RANGE OF zwm_i_header-customer,
           gr_supplier                 TYPE RANGE OF zwm_i_header-supplier,
           gr_batch                    TYPE RANGE OF zwm_i_header-batch,
           gr_orderid                  TYPE RANGE OF zwm_i_header-orderid,
           gr_purchaseorder            TYPE RANGE OF zwm_i_header-purchaseorder,
           gr_deliverydocument         TYPE RANGE OF zwm_i_header-deliverydocument,
           gr_postingdate              TYPE RANGE OF zwm_i_header-postingdate,
           gr_createdbyuser            TYPE RANGE OF zwm_i_header-createdbyuser,
           gr_materialdocument         TYPE RANGE OF zwm_i_header-materialdocument,
           gr_inventorytransactiontype TYPE RANGE OF zwm_i_header-inventorytransactiontype,
           gr_receivingstorageloc      TYPE RANGE OF zwm_i_header-issuingorreceivingstorageloc,
           gr_goodsmovementtype        TYPE RANGE OF zwm_i_header-goodsmovementtype,
           gr_glaccount                TYPE RANGE OF zwm_i_header-glaccount,
           gp_locchungtu               TYPE c LENGTH 1.
    DATA: gv_sort_string     TYPE string,
          gt_fields          TYPE if_rap_query_request=>tt_requested_elements,
          gt_aggregation     TYPE if_rap_query_request=>tt_requested_elements,
          gv_top             TYPE int8,
          gv_skip            TYPE int8,
          gv_max_rows        TYPE int8,
          gt_aggr_element    TYPE if_rap_query_aggregation=>tt_aggregation_elements,
          gt_grouped_element TYPE   if_rap_query_aggregation=>tt_grouped_elements.
ENDCLASS.



CLASS ZWM_CL_ZMB51_HEADER IMPLEMENTATION.


  METHOD if_rap_query_provider~select.
    gt_fields       = io_request->get_requested_elements( ).
    gt_aggregation  = io_request->get_requested_elements( ).
    gt_aggr_element = io_request->get_aggregation( )->get_aggregated_elements( ).
    gv_top          = io_request->get_paging( )->get_page_size( ).
    gv_skip         = io_request->get_paging( )->get_offset( ).
    gt_grouped_element = io_request->get_aggregation( )->get_grouped_elements( ).
    gv_max_rows = COND #( WHEN gv_top = if_rap_query_paging=>page_size_unlimited
                          THEN 0
                          ELSE gv_top ).

    IF gv_max_rows = -1.
      gv_max_rows = 1.
    ENDIF.

    IF gt_aggr_element IS NOT INITIAL.
      LOOP AT gt_aggr_element ASSIGNING FIELD-SYMBOL(<fs_aggr_element>).
        DELETE gt_fields WHERE table_line = <fs_aggr_element>-result_element.
        DATA(lv_aggregation) = |{ <fs_aggr_element>-aggregation_method }( { <fs_aggr_element>-input_element } ) as { <fs_aggr_element>-result_element }|.
        APPEND lv_aggregation TO gt_fields.
      ENDLOOP.
    ENDIF.

    DATA(lt_parameter) = io_request->get_parameters( ).
    LOOP AT lt_parameter REFERENCE INTO DATA(ls_parameter).
      CASE ls_parameter->parameter_name.
        WHEN 'LOCCHUNGTU'.
          gp_locchungtu = ls_parameter->value.
      ENDCASE.
    ENDLOOP.
    TRY.
        " get and add filter
        DATA(lt_filter_cond) = io_request->get_filter( )->get_as_ranges( ). "  get_filter_conditions( ).

        LOOP AT lt_filter_cond REFERENCE INTO DATA(ls_filter_cond).
          CASE ls_filter_cond->name.
            WHEN 'PLANT'.
              gr_werks = CORRESPONDING #( ls_filter_cond->range[] ).
            WHEN 'BATCH'.
              gr_batch = CORRESPONDING #( ls_filter_cond->range[] ).
            WHEN 'MATERIAL'.
              gr_material = CORRESPONDING #( ls_filter_cond->range[] ).
            WHEN 'STORAGELOCATION'.
              gr_storagelocation = CORRESPONDING #( ls_filter_cond->range[] ).
            WHEN 'PRODUCTTYPE'.
              gr_producttype = CORRESPONDING #( ls_filter_cond->range[] ).
            WHEN 'PRODUCTGROUP'.
              gr_productgroup = CORRESPONDING #( ls_filter_cond->range[] ).
            WHEN 'INVENTORYTRANSACTIONTYPE'.
              gr_inventorytransactiontype = CORRESPONDING #( ls_filter_cond->range[] ).
            WHEN 'SALESORDER'.
              gr_salesorder = CORRESPONDING #( ls_filter_cond->range[] ).
            WHEN 'CUSTOMER'.
              gr_customer = CORRESPONDING #( ls_filter_cond->range[] ).
            WHEN 'ISSGORRCVGSPCLSTOCKIND'.
              gr_issgorrcvgspclstockind = CORRESPONDING #( ls_filter_cond->range[] ).
            WHEN 'SALESORDERITEM'.
              gr_salesorderitem = CORRESPONDING #( ls_filter_cond->range[] ).
            WHEN 'SUPPLIER'.
              gr_supplier = CORRESPONDING #( ls_filter_cond->range[] ).
            WHEN 'ORDERID'.
              gr_orderid = CORRESPONDING #( ls_filter_cond->range[] ).
            WHEN 'PURCHASEORDER'.
              gr_purchaseorder = CORRESPONDING #( ls_filter_cond->range[] ).
            WHEN 'DELIVERYDOCUMENT'.
              gr_deliverydocument = CORRESPONDING #( ls_filter_cond->range[] ).
            WHEN 'POSTINGDATE'.
              gr_postingdate = CORRESPONDING #( ls_filter_cond->range[] ).
            WHEN 'CREATEDBYUSER'.
              gr_createdbyuser = CORRESPONDING #( ls_filter_cond->range[] ).
            WHEN 'MATERIALDOCUMENT'.
              gr_materialdocument = CORRESPONDING #( ls_filter_cond->range[] ).
            WHEN 'ISSUINGORRECEIVINGSTORAGELOC'.
              gr_receivingstorageloc = CORRESPONDING #( ls_filter_cond->range[] ).
            WHEN 'GOODSMOVEMENTTYPE'.
              gr_goodsmovementtype = CORRESPONDING #( ls_filter_cond->range[] ).
            WHEN 'GLACCOUNT'.
              gr_glaccount = CORRESPONDING #( ls_filter_cond->range[] ).
          ENDCASE.
        ENDLOOP.
      CATCH cx_rap_query_filter_no_range INTO DATA(lx_no_sel_option). " TODO: variable is assigned but never used (ABAP cleaner)
    ENDTRY.

    DATA lv_defautl TYPE char255.

    DATA(lt_sort)          = io_request->get_sort_elements( ).
    DATA(lt_sort_criteria) = VALUE string_table(
                                       FOR sort_element IN lt_sort
                                       ( sort_element-element_name && COND #( WHEN sort_element-descending = abap_true
                                                                              THEN ` descending`
                                                                              ELSE ` ascending` ) ) ).
    lv_defautl = 'Plant,Material,StorageLocation,Batch'.

    gv_sort_string = COND #( WHEN lt_sort_criteria IS INITIAL
                             THEN lv_defautl
                             ELSE concat_lines_of( table = lt_sort_criteria
                                                   sep   = `, ` ) ).

    IF lines( gt_aggregation ) <= 6.
      gv_sort_string = concat_lines_of( table = gt_aggregation
                                        sep   = `, ` ).
    ENDIF.

*    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""get data

    SELECT item~materialdocumentyear,
           item~materialdocument,
           item~materialdocumentitem,
           item~material,
           prd_des~productdescription,
           item~plant,
           item~storagelocation,
           storage_location~storagelocationname,
           item~batch,
           item~shelflifeexpirationdate,
           item~manufacturedate,
           CASE WHEN item~customer IS NOT INITIAL THEN
           item~customer
           ELSE sd~soldtoparty END                                                                                                                             AS customer,
           item~companycodecurrency,
           CASE WHEN item~debitcreditcode = 'H' THEN item~totalgoodsmvtamtincccrcy * -1
           ELSE item~totalgoodsmvtamtincccrcy  END                                                                                                             AS totalgoodsmvtamtincccrcy,
           item~isautomaticallycreated,
           item~companycode,
           item~costcenter,
           costcenter~costcentername,
           CASE WHEN item~debitcreditcode = 'H' THEN 'Xuất'
           ELSE 'Nhập' END                                                                                                                                     AS debitcreditcode,
           item~deliverydocument,
           item~deliverydocumentitem,
           item~documentdate,
           item~purchaseorder,
           item~purchaseorderitem,
           item~materialdocumentitemtext,
           item~orderid,
           item~orderitem,
           item~goodsmovementtype,
           goods_movement~goodsmovementtypename,
           item~postingdate,
           CASE WHEN item~debitcreditcode = 'H' THEN item~quantityinbaseunit * -1
           ELSE item~quantityinbaseunit  END                                                                                                                   AS quantityinbaseunit,
           item~materialbaseunit,
           CASE WHEN item~debitcreditcode = 'H' THEN item~quantityinentryunit * -1
           ELSE item~quantityinentryunit  END                                                                                                                  AS quantityinentryunit,
           item~entryunit,
           bophansoxe~transportno,
           item~goodsreceipttype,
           item~reservation,
           item~reservationitem,
           item~reversedmaterialdocumentitem,
           item~reversedmaterialdocumentyear,
           item~reversedmaterialdocument,
           item~salesorderitem,
           item~salesorder,
           item~salesorderscheduleline,
           item~issgorrcvgspclstockind,
           item~supplier,
           item~issuingorreceivingplant,
           item~issuingorreceivingstorageloc,
           item~issgorrcvgmaterial,
           item~issgorrcvgbatch,
           header~createdbyuser,
           header~creationdate,
           header~creationtime,
           header~inventorytransactiontype,
           header~materialdocumentheadertext,
           item~controllingarea,
*           charcvalue
           charcvaluez_grd~charcfromdate                                                                                                                       AS ngaynhapkho,
           charcvaluez_nsx~charcfromdate                                                                                                                       AS ngaysanxuat,
           charcvaluez_hsd~charcfromdate                                                                                                                       AS hansudung,
           charcvaluez_dsx~charcvalue                                                                                                                          AS donvisanxuat,
           charcvaluez_ncc~charcvalue                                                                                                                          AS nhacungcap,
           charcvaluez_ghichu~charcvalue                                                                                                                       AS ghichu,
           charcvaluez_shd~charcvalue                                                                                                                          AS sohopdong,
           charcvaluez_csx~charcvalue                                                                                                                          AS casanxuat,
           charcvaluez_lot~charcvalue                                                                                                                          AS lotnumber,
           charcvaluez_z_vtgc~charcvalue                                                                                                                       AS khguigiacong,
           charcvaluez_z_ngsp~charcvalue                                                                                                                       AS nguongocsanpham,
           CASE WHEN prdunit~product IS NOT INITIAL  THEN
          CASE WHEN charcvaluez_hsqd~charcfromdecimalvalue IS NOT INITIAL THEN
          CAST( charcvaluez_hsqd~charcfromdecimalvalue AS DEC( 16,3 ) )
          ELSE prdunit~quantitynumerator END
            END                                                                                                                                                AS kgthung,
*            case when  charcvaluez_hsqd~CharcFromDecimalValue is not INITIAL and charcvaluez_hsqd~CharcFromDecimalValue * 1 ne 0 and item~QuantityInBaseUnit * charcvaluez_hsqd~CharcFromDecimalValue ne 0  then
*           CASE WHEN item~DebitCreditCode = 'H'   THEN
*           CAST( div( CAST( item~QuantityInBaseUnit AS QUAN( 13 ) ) , CAST( charcvaluez_hsqd~CharcFromDecimalValue  * -1  AS QUAN(
*                                                                                13 ) ) ) AS QUAN( 13 ) )
*           ELSE  CAST( div( CAST( item~QuantityInBaseUnit AS QUAN( 13 ) ) , CAST( charcvaluez_hsqd~CharcFromDecimalValue  AS QUAN(
*                                                                                      13 ) ) ) AS QUAN( 13 ) )
**           //      ELSE item~quantityinbaseunit END
*           END    end                                                                                                                                              AS quantity_in_altunit,
           unit~unitofmeasure                                                                                                                                  AS altunit,
           prd~productgroup,
           prd_gr_t~productgroupname,
           prd~producttype,
           prd_type_t~producttypename,
           CASE WHEN item~customer IS NOT INITIAL THEN
           CASE
           WHEN customer~organizationbpname2 IS NOT INITIAL OR customer~organizationbpname3 IS NOT INITIAL OR customer~organizationbpname4 IS NOT INITIAL
           THEN concat_with_space( customer~organizationbpname2,concat_with_space( customer~organizationbpname3,customer~organizationbpname4,1 ),1 )
           ELSE customer~organizationbpname1 END
           ELSE          soldtoparty~businesspartnername1       END                                                                                            AS customername,
           CASE
           WHEN supplier~organizationbpname2 IS NOT INITIAL OR supplier~organizationbpname3 IS NOT INITIAL OR supplier~organizationbpname4 IS NOT INITIAL
           THEN concat_with_space( supplier~organizationbpname2,concat_with_space( supplier~organizationbpname3,supplier~organizationbpname4,1 ),1 )
           ELSE supplier~organizationbpname1 END                                                                                                               AS suppliername,
           concat_with_space( 'Material Document :',concat_with_space( item~materialdocument,concat_with_space( 'Item :',item~materialdocumentitem,1 ),1 ),1 ) AS header,
           yy1_chungnhan~description                                                                                                                           AS yy1_chungnhan_prd,
           yy1_dongsanpham~description                                                                                                                         AS yy1_dongsanpham_prd,
           yy1_giaviphugia~description                                                                                                                         AS yy1_giaviphugia_prd,
           yy1_kichcohinhdangsize~description                                                                                                                  AS yy1_kichcohinhdangsize_prd,
           yy1_loaihinhsanxuat~description                                                                                                                     AS yy1_loaihinhsanxuat_prd,
           yy1_loaitpthuhoi~description                                                                                                                        AS yy1_loaitpthuhoi_prd,
           yy1_quycachdonggoi~description                                                                                                                      AS yy1_quycachdonggoi_prd,
           bophansoxe~deliveryname,
           bophansoxe~deliverytransport,
           bophansoxe~deliverycontractno,
           bophansoxe~contno,
           bophansoxe~sealno,
           reverse~isreversed                                                                                                                                  AS isreversed,
           sloc~storagelocationname                                                                                                                            AS issuingorreceivingsloc_name,
*           cast('' as abap~char(100))                                                                                                                    as tendai,
*           cast('' as abap~cuky(5)  )                                                                                                                    as currrency,
*           cast(0~00 as abap~curr(16,2))                                                                                                                 as amount,
           CASE WHEN item~debitcreditcode = 'H' THEN CAST( item~quantityinbaseunit AS QUAN( 16,2 ) )  ELSE CAST( 0 AS QUAN(
                                                                                                                     16,2 ) )  END                             AS xuat,
           CASE WHEN item~debitcreditcode = 'S' THEN CAST( item~quantityinbaseunit AS QUAN( 16,2 ) )  ELSE CAST( 0 AS QUAN(
                                                                                                                     16,2 ) ) END                              AS nhap,
            item~glaccount
      FROM i_materialdocumentitem_2 AS item
             LEFT JOIN
               i_product AS prd ON prd~product = item~material
                 LEFT JOIN
                   i_salesdocument AS sd ON sd~salesdocument = item~salesorder
                     LEFT JOIN
                       i_productunitsofmeasure AS prdunit ON  prdunit~alternativeunit = 'Z1'
                                                          AND prdunit~product         = prd~product
                         LEFT JOIN
                           i_productdescription_2 AS prd_des ON  prd_des~language = 'E'
                                                             AND prd_des~product  = item~material
                             LEFT JOIN
                               i_goodsmovementtypet AS goods_movement ON  goods_movement~language          = 'E'
                                                                      AND goods_movement~goodsmovementtype = item~goodsmovementtype
                                 LEFT JOIN
                                   i_storagelocation AS storage_location ON storage_location~storagelocation = item~storagelocation

                                     LEFT JOIN
                                       zwm_i_charcvalue AS charcvaluez_grd ON  charcvaluez_grd~batch          = item~batch
                                                                           AND charcvaluez_grd~material       = item~material
                                                                           AND charcvaluez_grd~characteristic = 'Z_GRD'
                                         LEFT JOIN
                                           zwm_i_charcvalue AS charcvaluez_nsx ON  charcvaluez_nsx~batch          = item~batch
                                                                               AND charcvaluez_nsx~material       = item~material
                                                                               AND charcvaluez_nsx~characteristic = 'Z_NSX'
                                             LEFT JOIN
                                               zwm_i_charcvalue AS charcvaluez_hsd ON  charcvaluez_hsd~batch          = item~batch
                                                                                   AND charcvaluez_hsd~material       = item~material
                                                                                   AND charcvaluez_hsd~characteristic = 'Z_HSD'
                                                 LEFT JOIN
                                                   zwm_i_charcvalue AS charcvaluez_dsx ON  charcvaluez_dsx~batch          = item~batch
                                                                                       AND charcvaluez_dsx~material       = item~material
                                                                                       AND charcvaluez_dsx~characteristic = 'Z_DSX'

                                                     LEFT JOIN
                                                       zwm_i_charcvalue AS charcvaluez_ncc ON  charcvaluez_ncc~batch          = item~batch
                                                                                           AND charcvaluez_ncc~material       = item~material
                                                                                           AND charcvaluez_ncc~characteristic = 'Z_NCC'

                                                         LEFT JOIN
                                                           zwm_i_charcvalue AS charcvaluez_ghichu ON  charcvaluez_ghichu~batch          = item~batch
                                                                                                  AND charcvaluez_ghichu~material       = item~material
                                                                                                  AND charcvaluez_ghichu~characteristic = 'Z_GHICHU'

                                                             LEFT JOIN
                                                               zwm_i_charcvalue AS charcvaluez_shd ON  charcvaluez_shd~batch          = item~batch
                                                                                                   AND charcvaluez_shd~material       = item~material
                                                                                                   AND charcvaluez_shd~characteristic = 'Z_SHD'

                                                                 LEFT JOIN
                                                                   zwm_i_charcvalue AS charcvaluez_csx ON  charcvaluez_csx~batch          = item~batch
                                                                                                       AND charcvaluez_csx~material       = item~material
                                                                                                       AND charcvaluez_csx~characteristic = 'Z_CSX'

                                                                     LEFT JOIN
                                                                       zwm_i_charcvalue AS charcvaluez_lot ON  charcvaluez_lot~batch          = item~batch
                                                                                                           AND charcvaluez_lot~material       = item~material
                                                                                                           AND charcvaluez_lot~characteristic = 'Z_LOT'

                                                                         LEFT JOIN
                                                                           zwm_i_charcvalue AS charcvaluez_hsqd ON  charcvaluez_hsqd~batch          = item~batch
                                                                                                                AND charcvaluez_hsqd~material       = item~material
                                                                                                                AND charcvaluez_hsqd~characteristic = 'Z_HSQD'

                                                                             LEFT JOIN
                                                                               zwm_i_charcvalue AS charcvaluez_z_vtgc ON  charcvaluez_z_vtgc~batch          = item~batch
                                                                                                                      AND charcvaluez_z_vtgc~material       = item~material
                                                                                                                      AND charcvaluez_z_vtgc~characteristic = 'Z_VTGC'
                                                                                 LEFT JOIN
                                                                                   zwm_i_charcvalue AS charcvaluez_z_ngsp ON  charcvaluez_z_ngsp~batch          = item~batch
                                                                                                                          AND charcvaluez_z_ngsp~material       = item~material
                                                                                                                          AND charcvaluez_z_ngsp~characteristic = 'Z_NGSP'
                                                                                     LEFT JOIN
                                                                                       i_productgrouptext_2 AS prd_gr_t ON  prd_gr_t~language     = 'E'
                                                                                                                        AND prd_gr_t~productgroup = prd~productgroup
                                                                                         LEFT JOIN
                                                                                           i_producttypetext_2 AS prd_type_t ON  prd_type_t~language    = 'E'
                                                                                                                             AND prd_type_t~producttype = prd~producttype
                                                                                             LEFT JOIN
                                                                                               i_businesspartner AS supplier ON supplier~businesspartner = item~supplier
                                                                                                 LEFT JOIN
                                                                                                   i_businesspartner AS customer ON customer~businesspartner = item~customer
                                                                                                     LEFT JOIN
                                                                                                       i_customer AS soldtoparty ON soldtoparty~customer = sd~soldtoparty

                                                                                                         LEFT JOIN
                                                                                                           i_costcentertext AS costcenter ON  costcenter~controllingarea    = item~controllingarea
                                                                                                                                          AND costcenter~costcenter         = item~costcenter
                                                                                                                                          AND costcenter~validityenddate   >= item~postingdate
                                                                                                                                          AND costcenter~validitystartdate <= item~postingdate
                                                                                                             LEFT JOIN
                                                                                                               ztb_lxh_ttvc AS bophansoxe ON  bophansoxe~mjahr = item~materialdocumentyear
                                                                                                                                          AND bophansoxe~mblnr = item~materialdocument
                                                                                                                 LEFT JOIN
                                                                                                                   i_materialdocumentheader_2 AS header ON  header~materialdocumentyear = item~materialdocumentyear
                                                                                                                                                        AND header~materialdocument     = item~materialdocument
                                                                                                                     LEFT JOIN
                                                                                                                       zwm_i_loc_reversed AS reverse ON  reverse~materialdocument     = item~materialdocument
                                                                                                                                                     AND reverse~materialdocumentitem = item~materialdocumentitem
                                                                                                                                                     AND reverse~materialdocumentyear = item~materialdocumentyear
                                                                                                                         LEFT JOIN
                                                                                                                           i_unitofmeasure AS unit ON unit~unitofmeasure = 'Z1'

                                                                                                                             LEFT JOIN
                                                                                                                               i_customfieldcodelisttext AS yy1_loaihinhsanxuat ON  yy1_loaihinhsanxuat~customfieldid = 'YY1_LOAIHINHSANXUAT'
                                                                                                                                                                                AND yy1_loaihinhsanxuat~code          = prd~yy1_loaihinhsanxuat_prd
                                                                                                                                                                                AND yy1_loaihinhsanxuat~language      = 'E'
                                                                                                                                 LEFT JOIN
                                                                                                                                   i_customfieldcodelisttext AS yy1_kichcohinhdangsize ON  yy1_kichcohinhdangsize~customfieldid = 'YY1_KICHCOHINHDANGSIZE'
                                                                     AND yy1_kichcohinhdangsize~code          = prd~yy1_kichcohinhdangsize_prd
                                                                                                                                                                                       AND yy1_kichcohinhdangsize~language      = 'E'
                                                                                                                                     LEFT JOIN
                                                                                                                                       i_customfieldcodelisttext AS yy1_loaitpthuhoi ON  yy1_loaitpthuhoi~customfieldid = 'YY1_LOAITPTHUHOI'
                                                                                                                                                                                     AND yy1_loaitpthuhoi~code          = prd~yy1_loaitpthuhoi_prd
                                                                                                                                                                                     AND yy1_loaitpthuhoi~language      = 'E'
                                                                                                                                         LEFT JOIN
                                                                                                                                           i_customfieldcodelisttext AS yy1_giaviphugia ON  yy1_giaviphugia~customfieldid = 'YY1_GIAVIPHUGIA'
                                                                                                                                                                                        AND yy1_giaviphugia~code          = prd~yy1_giaviphugia_prd
                                                                                                                                                                                        AND yy1_giaviphugia~language      = 'E'
                                                                                                                                             LEFT JOIN
                                                                                                                                               i_customfieldcodelisttext AS yy1_quycachdonggoi ON  yy1_quycachdonggoi~customfieldid = 'YY1_QUYCACHDONGGOI'
                                                                     AND yy1_quycachdonggoi~code          = prd~yy1_quycachdonggoi_prd
                                                                                                                                                                                               AND yy1_quycachdonggoi~language      = 'E'
                                                                                                                                                 LEFT JOIN
                                                                                                                                                   i_customfieldcodelisttext AS yy1_chungnhan ON  yy1_chungnhan~customfieldid = 'YY1_CHUNGNHAN'
                                                                                                                                                                                              AND yy1_chungnhan~code          = prd~yy1_chungnhan_prd
                                                                                                                                                                                              AND yy1_chungnhan~language      = 'E'
                                                                                                                                                     LEFT JOIN
                                                                                                                                                       i_customfieldcodelisttext AS yy1_dongsanpham ON  yy1_dongsanpham~customfieldid = 'YY1_DONGSANPHAM'
                                                           AND yy1_dongsanpham~code          = prd~yy1_dongsanpham_prd
                                                                                                                                                                                                    AND yy1_dongsanpham~language      = 'E'
                                                                                                                                                         LEFT JOIN
                                                                                                                                                           i_storagelocation AS sloc ON sloc~storagelocation = item~issuingorreceivingstorageloc

      WHERE (   (
              (
                    @gp_locchungtu = 'O'
                AND (
                      item~reversedmaterialdocument = ''
              AND item~reversedmaterialdocumentitem  = '0000'
              AND item~reversedmaterialdocumentyear  = '0000'
              AND reverse~isreversed                <> 'O' ) )
      OR (
           @gp_locchungtu = 'X'
                                AND
                                    reverse~isreversed <> '' ) ) )
                                                               AND item~plant IN @gr_werks
                                                               AND item~storagelocation                IN @gr_storagelocation
                                                               AND item~material IN @gr_material
                                                               AND prd~producttype IN @gr_producttype
                                                               AND prd~productgroup                    IN @gr_productgroup
                                                               AND item~issgorrcvgspclstockind         IN @gr_issgorrcvgspclstockind
                                                               AND item~salesorder IN @gr_salesorder
                                                               AND item~salesorderitem                 IN @gr_salesorderitem
                                                               AND item~customer IN @gr_customer
                                                               AND item~supplier IN @gr_supplier
                                                               AND item~batch IN @gr_batch
                                                               AND item~orderid IN @gr_orderid
                                                               AND item~purchaseorder                  IN @gr_purchaseorder
                                                               AND item~deliverydocument               IN @gr_deliverydocument
                                                               AND item~postingdate                    IN @gr_postingdate
                                                               AND header~createdbyuser                IN @gr_createdbyuser
                                                               AND item~materialdocument               IN @gr_materialdocument
                                                               AND header~inventorytransactiontype     IN @gr_inventorytransactiontype
                                                               AND item~issuingorreceivingstorageloc IN @gr_receivingstorageloc
                                                               AND item~goodsmovementtype IN @gr_goodsmovementtype
                                                               AND item~glaccount IN @gr_glaccount
      INTO CORRESPONDING FIELDS OF TABLE @gt_data.

*  """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""end get data

*    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""Processing data
    DATA lt_product_conv TYPE zcore_cl_get_long_text=>ty_product.
    " TODO: variable is assigned but only used in commented-out code (ABAP cleaner)
    DATA ls_check_author TYPE abap_boolean.
    TYPES:
      BEGIN OF y_product,
        material TYPE c LENGTH 18,
        language TYPE c LENGTH 2,
      END OF y_product,
      ty_product TYPE SORTED TABLE OF y_product WITH UNIQUE KEY material.

    DATA(lt_product_conv_mat) = CORRESPONDING ty_product( gt_data DISCARDING DUPLICATES ).
    lt_product_conv = VALUE #( FOR lsproduct_conv_mat IN lt_product_conv_mat
                               ( product  = lsproduct_conv_mat-material
                                 language = 'EN'                       )  ).

    DATA(lt_product) = CORRESPONDING zcore_cl_get_long_text=>ty_product( lt_product_conv DISCARDING DUPLICATES ).
    " TODO: variable is assigned but only used in commented-out code (ABAP cleaner)
    DATA(lt_basictextmat) = zcore_cl_get_long_text=>get_multi_material_basic_text( it_material = lt_product ).

    AUTHORITY-CHECK OBJECT 'ZAO_BCNXTN'
                    ID 'ACTVT'      FIELD '03'
                    ID 'ZAF_BCNXTN' FIELD 'X'.
    IF sy-subrc <> 0.
      ls_check_author = abap_false.
    ELSE.
      ls_check_author = abap_true.
    ENDIF.

    LOOP AT gt_data REFERENCE INTO DATA(gs_data).
      IF gs_data->kgthung NE 0.
        gs_data->quantity_in_altunit  = gs_data->quantityinbaseunit / gs_data->kgthung.
      ENDIF.

      READ TABLE lt_basictextmat into data(ls_basictextmat) WITH KEY product = gs_data->Material.
      if sy-subrc = 0.
        gs_data->tendai = ls_basictextmat-long_text.
      ENDIF.

    ENDLOOP.
*    LOOP AT gt_data REFERENCE INTO DATA(gs_data).
*      READ TABLE lt_basictextmat INTO DATA(ls_basic) WITH KEY product = gs_data->material  .
*      IF sy-subrc  = 0.
*        gs_data->tendai = ls_basic-long_text.
*      ENDIF.
*      IF ls_check_author EQ abap_false.
*        gs_data->totalgoodsmvtamtincccrcy =  0 .
*      ENDIF.
*    ENDLOOP.
*   """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" End Processing data

*    IF lines( gt_aggregation ) = 2.
*      gv_sort_string = 'BASEUNIT, MATERIALBASEUNIT'.
*    ELSEIF lines( gt_aggregation ) = 1.
*      READ TABLE gt_aggregation INTO DATA(ls_aggregation) INDEX 1.
*      IF sy-subrc = 0.
*        gv_sort_string = |{ ls_aggregation }|.
*      ENDIF.
*    ENDIF.

*    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""return data
    DATA(lt_grouped_element) = io_request->get_aggregation( )->get_grouped_elements( ).
    DATA(lv_grouping_agree) = concat_lines_of( table = lt_grouped_element
                                               sep   = `, ` ).

    DATA(lv_req_elements) = concat_lines_of( table = gt_fields
                                             sep   = `, ` ).

    DATA lt_data_response TYPE TABLE OF zwm_i_header_custom.
    IF  lv_req_elements IS INITIAL .
      SELECT * FROM @gt_data AS data INTO CORRESPONDING FIELDS OF TABLE @lt_data_response.
    ELSE.
      SELECT (lv_req_elements) FROM @gt_data AS data
        GROUP BY (lv_grouping_agree)
        ORDER BY (gv_sort_string)
        INTO CORRESPONDING FIELDS OF TABLE @lt_data_response
      OFFSET @gv_skip
        UP TO @gv_max_rows ROWS.
    ENDIF.
    io_response->set_total_number_of_records( lines( gt_data ) ).
    io_response->set_data( lt_data_response ).
*   """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""End  return data
  ENDMETHOD.
ENDCLASS.
