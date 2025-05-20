@AbapCatalog.viewEnhancementCategory: [ #NONE ]

@AccessControl.authorizationCheck: #NOT_REQUIRED

@EndUserText.label: 'Header báo cáo giao dịch sản xuất trong ngày'

@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true

@ObjectModel.usageType: { serviceQuality: #X, sizeCategory: #S, dataClass: #MIXED }

define view entity ZWM_I_HEADER
  with parameters
    @Consumption.valueHelpDefinition: [ { entity: { element: 'value_low', name: 'ZWM_I_LOCCHUNGTUVH' } } ]
    @EndUserText.label: 'Lọc chứng từ'
    loc_chung_tu : zdm_i_locchungtu

  as select from    I_MaterialDocumentItem_2 as item

    left outer join I_Product                as prd  on prd.Product = item.Material

  association [1..1] to I_SalesDocument            as sd
    on sd.SalesDocument = item.SalesOrder

  association [1..1] to I_ProductUnitsOfMeasure    as prdunit
    on  prdunit.AlternativeUnit = 'Z1'
    and prdunit.Product         = prd.Product

  association [1..1] to I_ProductDescription_2     as prd_des
    on  prd_des.Language = 'E'
    and prd_des.Product  = item.Material

  association [1..1] to I_GoodsMovementTypeT       as goods_movement
    on  goods_movement.Language          = 'E'
    and goods_movement.GoodsMovementType = item.GoodsMovementType

  association [1..1] to I_StorageLocation          as storage_location
    on storage_location.StorageLocation = item.StorageLocation

  association [1..1] to ZWM_I_CHARCVALUE           as charcvalue
    on  charcvalue.batch    = item.Batch
    and charcvalue.material = item.Material

  association [1..1] to I_ProductGroupText_2       as prd_gr_t
    on  prd_gr_t.Language     = 'E'
    and prd_gr_t.ProductGroup = prd.ProductGroup

  association [1..1] to I_ProductTypeText_2        as prd_type_t
    on  prd_type_t.Language    = 'E'
    and prd_type_t.ProductType = prd.ProductType

  association [1..1] to I_BusinessPartner          as supplier
    on supplier.BusinessPartner = item.Supplier

  association [1..1] to I_BusinessPartner          as Customer
    on Customer.BusinessPartner = item.Customer

  association [1..1] to I_CostCenterText           as CostCenter
    on  CostCenter.ControllingArea    = item.ControllingArea
    and CostCenter.CostCenter         = item.CostCenter
    and CostCenter.ValidityEndDate   >= item.PostingDate
    and CostCenter.ValidityStartDate <= item.PostingDate

  association [1..1] to ztb_lxh_ttvc               as bophansoxe
    on  bophansoxe.mjahr = item.MaterialDocumentYear
    and bophansoxe.mblnr = item.MaterialDocument

  association [1..1] to I_MaterialDocumentHeader_2 as header
    on  header.MaterialDocumentYear = item.MaterialDocumentYear
    and header.MaterialDocument     = item.MaterialDocument

  association [1..1] to ZWM_I_LOC_REVERSED         as reverse
    on  reverse.MaterialDocument     = item.MaterialDocument
    and reverse.MaterialDocumentItem = item.MaterialDocumentItem
    and reverse.MaterialDocumentYear = item.MaterialDocumentYear

  association [1..1] to I_UnitOfMeasure            as unit
    on unit.UnitOfMeasure = 'Z1'

  association [1..1] to I_CustomFieldCodeListText  as YY1_LOAIHINHSANXUAT
    on  YY1_LOAIHINHSANXUAT.CustomFieldID = 'YY1_LOAIHINHSANXUAT'
    and YY1_LOAIHINHSANXUAT.Code          = prd.YY1_Loaihinhsanxuat_PRD
    and YY1_LOAIHINHSANXUAT.Language      = 'E'

  association [1..1] to I_CustomFieldCodeListText  as YY1_KICHCOHINHDANGSIZE
    on  YY1_KICHCOHINHDANGSIZE.CustomFieldID = 'YY1_KICHCOHINHDANGSIZE'
    and YY1_KICHCOHINHDANGSIZE.Code          = prd.YY1_KichcoHinhdangSize_PRD
    and YY1_KICHCOHINHDANGSIZE.Language      = 'E'

  association [1..1] to I_CustomFieldCodeListText  as YY1_LOAITPTHUHOI
    on  YY1_LOAITPTHUHOI.CustomFieldID = 'YY1_LOAITPTHUHOI'
    and YY1_LOAITPTHUHOI.Code          = prd.YY1_LoaiTPthuhoi_PRD
    and YY1_LOAITPTHUHOI.Language      = 'E'

  association [1..1] to I_CustomFieldCodeListText  as YY1_GIAVIPHUGIA
    on  YY1_GIAVIPHUGIA.CustomFieldID = 'YY1_GIAVIPHUGIA'
    and YY1_GIAVIPHUGIA.Code          = prd.YY1_GiaviPhugia_PRD
    and YY1_GIAVIPHUGIA.Language      = 'E'

  association [1..1] to I_CustomFieldCodeListText  as YY1_QUYCACHDONGGOI
    on  YY1_QUYCACHDONGGOI.CustomFieldID = 'YY1_QUYCACHDONGGOI'
    and YY1_QUYCACHDONGGOI.Code          = prd.YY1_Quycachdonggoi_PRD
    and YY1_QUYCACHDONGGOI.Language      = 'E'

  association [1..1] to I_CustomFieldCodeListText  as YY1_CHUNGNHAN
    on  YY1_CHUNGNHAN.CustomFieldID = 'YY1_CHUNGNHAN'
    and YY1_CHUNGNHAN.Code          = prd.YY1_Chungnhan_PRD
    and YY1_CHUNGNHAN.Language      = 'E'

  association [1..1] to I_CustomFieldCodeListText  as YY1_DONGSANPHAM
    on  YY1_DONGSANPHAM.CustomFieldID = 'YY1_DONGSANPHAM'
    and YY1_DONGSANPHAM.Code          = prd.YY1_Dongsanpham_PRD
    and YY1_DONGSANPHAM.Language      = 'E'

  association [1..1] to I_StorageLocation          as sloc
    on sloc.StorageLocation = item.IssuingOrReceivingStorageLoc

{
      @Consumption.valueHelpDefinition: [ { entity: { name: 'I_MaterialDocumentYear', element: 'MaterialDocumentYear' } } ]

  key item.MaterialDocumentYear,

  key item.MaterialDocument,
  key item.MaterialDocumentItem,

      item.Material,
      prd_des.ProductDescription,
      item.Plant,
      item.StorageLocation,
      storage_location.StorageLocationName,
      item.Batch,
      item.ShelfLifeExpirationDate,
      item.ManufactureDate,

      case when item.Customer is not initial then
      item.Customer
      else sd.SoldToParty end                                                                                           as Customer,

      item.CompanyCodeCurrency,

      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
      //      @DefaultAggregation: #SUM
      @UI.hidden: true
      case when item.DebitCreditCode = 'H' then item.TotalGoodsMvtAmtInCCCrcy * -1
      else item.TotalGoodsMvtAmtInCCCrcy  end                                                                           as TotalGoodsMvtAmtInCCCrcy,

      item.IsAutomaticallyCreated,
      item.CompanyCode,
      item.CostCenter,
      CostCenter.CostCenterName,

      case when item.DebitCreditCode = 'H' then 'Xuất'
      else 'Nhập' end                                                                                                   as DebitCreditCode,

      item.DeliveryDocument,
      item.DeliveryDocumentItem,
      item.DocumentDate,
      item.PurchaseOrder,
      item.PurchaseOrderItem,
      item.MaterialDocumentItemText,
      item.OrderID,
      item.OrderItem,
      item.GoodsMovementType,
      goods_movement.GoodsMovementTypeName,
      item.PostingDate,

      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      case when item.DebitCreditCode = 'H' then item.QuantityInBaseUnit * -1
      else item.QuantityInBaseUnit  end                                                                                 as QuantityInBaseUnit,

      item.MaterialBaseUnit,

      @Semantics.quantity.unitOfMeasure: 'EntryUnit'
      case when item.DebitCreditCode = 'H' then item.QuantityInEntryUnit * -1
      else item.QuantityInEntryUnit  end                                                                                as QuantityInEntryUnit,

      item.EntryUnit,
      bophansoxe.transportno,
      item.GoodsReceiptType,
      item.Reservation,
      item.ReservationItem,
      // bo sung sau
      item.ReversedMaterialDocumentItem,
      item.ReversedMaterialDocumentYear,
      item.ReversedMaterialDocument,
      item.SalesOrderItem,
      item.SalesOrder,
      item.SalesOrderScheduleLine,
      item.IssgOrRcvgSpclStockInd,
      item.Supplier,
      item.IssuingOrReceivingPlant,
      item.IssuingOrReceivingStorageLoc,
      item.IssgOrRcvgMaterial,
      item.IssgOrRcvgBatch,
      header.CreatedByUser,
      header.CreationDate,
      header.CreationTime,
      header.InventoryTransactionType,
      header.MaterialDocumentHeaderText,
      item.ControllingArea,

      charcvalue[Characteristic = 'Z_GRD'].CharcFromDate                                                                as ngaynhapkho,
      charcvalue[Characteristic = 'Z_NSX'].CharcFromDate                                                                as ngaysanxuat,
      charcvalue[Characteristic = 'Z_HSD'].CharcFromDate                                                                as hansudung,
      charcvalue[Characteristic = 'Z_DSX'].CharcValue                                                                   as donvisanxuat,
      charcvalue[Characteristic = 'Z_NCC'].CharcValue                                                                   as nhacungcap,
      charcvalue[Characteristic = 'Z_GHICHU'].CharcValue                                                                as ghichu,
      charcvalue[Characteristic = 'Z_SHD'].CharcValue                                                                   as sohopdong,
      charcvalue[Characteristic = 'Z_CSX'].CharcValue                                                                   as casanxuat,
      charcvalue[Characteristic = 'Z_LOT'].CharcValue                                                                   as lotnumber,
      charcvalue[Characteristic = 'Z_VTGC'].CharcValue                                                                  as KhGuiGiaCong,
      charcvalue[Characteristic = 'Z_NGSP'].CharcValue                                                                  as nguongocsanpham,

      case when prdunit.Product is not initial  then
      case when charcvalue[Characteristic = 'Z_HSQD'].CharcFromDecimalValue is not initial then
      charcvalue[Characteristic = 'Z_HSQD'].CharcFromDecimalValue
      else  cast(prdunit.QuantityNumerator as abap.dec(16,3))  end  end                                                 as kgthung,

      prd.BaseUnit,

      @Semantics.quantity.unitOfMeasure: 'altUnit'
      //      case when kg/thung.CharcFromDecimalValue is not initial then
      case when item.DebitCreditCode = 'H' then
      cast(cast(item.QuantityInBaseUnit as abap.quan(13)) / cast(charcvalue[Characteristic = 'Z_HSQD'].CharcFromDecimalValue * -1  as abap.quan(13)) as abap.quan(13))
      else cast(cast(item.QuantityInBaseUnit as abap.quan(13)) / cast(charcvalue[Characteristic = 'Z_HSQD'].CharcFromDecimalValue  as abap.quan(13)) as abap.quan(13))
      //      else item.QuantityInBaseUnit end
      end                                                                                                               as quantity_in_altunit,

      unit.UnitOfMeasure                                                                                                as altUnit,
      prd.ProductGroup,
      prd_gr_t.ProductGroupName,
      prd.ProductType,
      prd_type_t.ProductTypeName,

      case when item.Customer is not initial then
      case
      when Customer.OrganizationBPName2 <> '' or Customer.OrganizationBPName3 <> '' or Customer.OrganizationBPName4 <> ''
      then concat_with_space(Customer.OrganizationBPName2, concat_with_space(Customer.OrganizationBPName3, Customer.OrganizationBPName4, 1), 1)
      else Customer.OrganizationBPName1 end
      else          sd._SoldToParty.BusinessPartnerName1       end                                                      as customerName,

      case
      when supplier.OrganizationBPName2 <> '' or supplier.OrganizationBPName3 <> '' or supplier.OrganizationBPName4 <> ''
      then concat_with_space(supplier.OrganizationBPName2, concat_with_space(supplier.OrganizationBPName3, supplier.OrganizationBPName4, 1), 1)
      else supplier.OrganizationBPName1 end                                                                             as supplierName,

      @UI.hidden: true
      concat_with_space('Material Document :', concat_with_space(item.MaterialDocument, concat_with_space('Item :', item.MaterialDocumentItem, 1), 1), 1)
                                                                                                                        as header,

      YY1_CHUNGNHAN.Description                                                                                         as YY1_Chungnhan_PRD,
      YY1_DONGSANPHAM.Description                                                                                       as YY1_Dongsanpham_PRD,
      YY1_GIAVIPHUGIA.Description                                                                                       as YY1_GiaviPhugia_PRD,
      YY1_KICHCOHINHDANGSIZE.Description                                                                                as YY1_KichcoHinhdangSize_PRD,
      YY1_LOAIHINHSANXUAT.Description                                                                                   as YY1_Loaihinhsanxuat_PRD,
      YY1_LOAITPTHUHOI.Description                                                                                      as YY1_LoaiTPthuhoi_PRD,
      YY1_QUYCACHDONGGOI.Description                                                                                    as YY1_Quycachdonggoi_PRD,
      bophansoxe.deliveryname,
      bophansoxe.deliverytransport,
      bophansoxe.deliverycontractno,
      bophansoxe.contno,
      bophansoxe.sealno,
      reverse.isreversed                                                                                                as isreversed,
      sloc.StorageLocationName                                                                                          as IssuingOrReceivingsloc_name,

      @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZWM_CL_ZMB51_CACULATED'
      cast('' as abap.char(100))                                                                                        as tendai,

      cast('' as abap.cuky(5))                                                                                          as currrency,

      @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZWM_CL_ZMB51_CACULATED'
      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
      //      @DefaultAggregation: #SUM
      cast(0.00 as abap.curr(16,2))                                                                                     as amount,

      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      case when item.DebitCreditCode = 'H' then cast(item.QuantityInBaseUnit as abap.quan(16,2))  else cast(0 as abap.quan(16,2))  end
                                                                                                                        as xuat,

      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      case when item.DebitCreditCode = 'S' then cast(item.QuantityInBaseUnit as abap.quan(16,2))  else cast(0 as abap.quan(16,2)) end
                                                                                                                        as nhap,
      item.GLAccount                                                                                                                        
//      item.GoodsMovementType
}

where (
         // khi không tích
       $parameters.loc_chung_tu = 'O'
and (    item.ReversedMaterialDocument      = ''
     and item.ReversedMaterialDocumentItem  = '0000'
     and item.ReversedMaterialDocumentYear  = '0000'
     and reverse.isreversed                <> 'O'   ))
                                                      or (    $parameters.loc_chung_tu  = 'X'
                                                          and reverse.isreversed       <> '')
