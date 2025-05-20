@EndUserText.label: 'Header - Báo cáo giao dịch sản xuất trong ngày - Custom'

@ObjectModel.query.implementedBy: 'ABAP:ZWM_CL_ZMB51_HEADER'

define custom entity ZWM_I_HEADER_CUSTOM
  with parameters
    @Consumption.valueHelpDefinition: [ { entity: { element: 'value_low', name: 'ZWM_I_LOCCHUNGTUVH' } } ]
    @EndUserText.label: 'Lọc chứng từ'
    locchungtu : zdm_i_locchungtu

{

      @EndUserText.label: 'Material Document Year'
      @UI.lineItem: [ { position: 10 } ]
  key MaterialDocumentYear         : abap.char(4);

      @Consumption.valueHelpDefinition: [ { entity: { name: 'I_MaterialDocumentHeader_2', element: 'MaterialDocument' },
                                            additionalBinding: [ { element: 'MaterialDocumentYear',
                                                                   localElement: 'MaterialDocumentYear',
                                                                   usage: #RESULT } ] } ]
      @EndUserText.label: 'Material Document'
      @UI.lineItem: [ { position: 10 } ]
  key MaterialDocument             : mblnr;

      @EndUserText.label: 'Material Document Item '
      @UI.lineItem: [ { position: 30 } ]
  key MaterialDocumentItem         : abap.numc(4);

      @Consumption.valueHelpDefinition: [ { entity: { name: 'I_ProductDescription_2', element: 'Product' } } ]
      @EndUserText.label: 'Material'
      @UI.fieldGroup: [ { type: #STANDARD, position: 10, qualifier: 'Fieldgroup4' } ]
      @UI.lineItem: [ { position: 40 } ]
      Material                     : matnr;

      @Consumption.filter.hidden: true
      @EndUserText.label: 'Product Description'
      @UI.lineItem: [ { position: 20 } ]
      ProductDescription           : abap.char(100);

      @Consumption.filter: { defaultValue: '1000', mandatory: true, selectionType: #SINGLE, multipleSelections: true }
      @Consumption.valueHelpDefinition: [ { entity: { name: 'I_Plant', element: 'Plant' } } ]
      @EndUserText.label: 'Plant'
      @UI.identification: [ { position: 10 } ]
      @UI.lineItem: [ { position: 30 } ]
      Plant                        : abap.char(4);

      @Consumption.filter: { selectionType: #SINGLE, multipleSelections: true }
      @Consumption.valueHelpDefinition: [ { entity: { name: 'I_StorageLocationStdVH', element: 'StorageLocation' } } ]
      @EndUserText.label: 'Storage Location'
      @UI.identification: [ { position: 10 } ]
      @UI.lineItem: [ { position: 40 } ]
      StorageLocation              : abap.char(4);

      @Consumption.filter.hidden: true
      @EndUserText.label: 'Storage Location Name'
      @UI.identification: [ { position: 10 } ]
      @UI.lineItem: [ { position: 50 } ]
      StorageLocationName          : abap.char(100);

      @Consumption.valueHelpDefinition: [ { entity: { name: 'I_BatchDistinct', element: 'Batch' } } ]
      @EndUserText.label: 'Batch'
      @UI.fieldGroup: [ { type: #STANDARD, position: 10, qualifier: 'Fieldgroup4' } ]
      @UI.lineItem: [ { position: 60 } ]
      Batch                        : abap.char(10);

      @Consumption.filter.hidden: true
      @EndUserText.label: 'Shelf Life Expiration Date'
      @UI.identification: [ { position: 10 } ]
      @UI.lineItem: [ { position: 70 } ]
      ShelfLifeExpirationDate      : datum;

      @Consumption.filter.hidden: true
      @EndUserText.label: 'Manufacture Date'
      @UI.identification: [ { position: 10 } ]
      @UI.lineItem: [ { position: 80 } ]
      ManufactureDate              : datum;

      @Consumption.valueHelpDefinition: [ { entity: { name: 'I_Customer', element: 'Customer' } } ]
      @EndUserText.label: 'Customer'
      @UI.identification: [ { position: 10 } ]
      @UI.lineItem: [ { position: 90 } ]
      Customer                     : lifnr;

      @Consumption.filter.hidden: true
      @EndUserText.label: 'Company Code Currency'
      @UI.identification: [ { position: 10 } ]
      @UI.lineItem: [ { position: 100 } ]
      CompanyCodeCurrency          : waers;

      @Aggregation.default: #SUM
      @Consumption.filter.hidden: true
      @EndUserText.label: 'Total Goods Mvt Amt In CCCrcy'
      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
      @UI.identification: [ { position: 10 } ]
      @UI.lineItem: [ { position: 110 } ]

      TotalGoodsMvtAmtInCCCrcy     : abap.curr(31,2);

      @Consumption.filter.hidden: true
      @EndUserText.label: 'Is Automatically Created'
      @UI.identification: [ { position: 10 } ]
      @UI.lineItem: [ { position: 120 } ]
      IsAutomaticallyCreated       : abap.char(1);

      @Consumption.filter.hidden: true
      @EndUserText.label: 'Company Code'
      @UI.identification: [ { position: 10 } ]
      @UI.lineItem: [ { position: 130 } ]
      CompanyCode                  : abap.char(4);

      @Consumption.filter.hidden: true
      @EndUserText.label: 'Cost Center'
      @UI.identification: [ { position: 10 } ]
      @UI.lineItem: [ { position: 140 } ]
      CostCenter                   : abap.char(4);

      @Consumption.filter.hidden: true
      @EndUserText.label: 'Cost Center Name'
      @UI.identification: [ { position: 10 } ]
      @UI.lineItem: [ { position: 150 } ]
      CostCenterName               : abap.char(100);

      @EndUserText.label: 'Debit Credit Code'
      @UI.identification: [ { position: 10 } ]
      @UI.lineItem: [ { position: 160 } ]
      DebitCreditCode              : abap.char(1);

      @Consumption.valueHelpDefinition: [ { entity: { name: 'I_DeliveryDocumentStdVH', element: 'DeliveryDocument' } } ]
      @UI.lineItem: [ { position: 30, label: 'Delivery document' } ]
      DeliveryDocument             : vbeln;

      @UI.lineItem: [ { position: 30, label: 'Delivery document item' } ]
      @UI.selectionField: [ { position: 30 } ]
      DeliveryDocumentItem         : abap.numc(6);

      @Consumption.filter.hidden: true
      @EndUserText.label: 'Document Date'
      @UI.identification: [ { position: 10 } ]
      @UI.lineItem: [ { position: 170 } ]
      DocumentDate                 : datum;

      @Consumption.valueHelpDefinition: [ { entity: { name: 'I_PurchaseOrderAPI01', element: 'PurchaseOrder' } } ]
      @UI.lineItem: [ { position: 30, label: 'Purchase Order' } ]
      PurchaseOrder                : vbeln;

      @UI.lineItem: [ { position: 30, label: 'Purchase Order Item' } ]
      @UI.selectionField: [ { position: 30 } ]
      PurchaseOrderItem            : abap.numc(6);

      @Consumption.filter.hidden: true
      @EndUserText.label: 'Material Document Item Text'
      @UI.identification: [ { position: 10 } ]
      @UI.lineItem: [ { position: 180 } ]
      MaterialDocumentItemText     : abap.char(100);

      @Consumption.valueHelpDefinition: [ { entity: { name: 'I_Order', element: 'OrderID' } } ]
      @UI.lineItem: [ { position: 30, label: 'Order ID' } ]

      OrderID                      : abap.char(12);

      @UI.lineItem: [ { position: 30, label: 'Order Item' } ]
      OrderItem                    : abap.numc(4);

      @EndUserText.label: 'Goods Movement Type'
      @UI.identification: [ { position: 10 } ]
      @UI.lineItem: [ { position: 190 } ]
      GoodsMovementType            : bwart;

      @Consumption.filter.hidden: true
      @EndUserText.label: 'Goods Movement Type Name'
      @UI.identification: [ { position: 10 } ]
      @UI.lineItem: [ { position: 200 } ]
      GoodsMovementTypeName        : abap.char(100);

      @Consumption.filter.selectionType: #INTERVAL
      @EndUserText.label: 'Posting Date'
      @UI.identification: [ { position: 10 } ]
      @UI.lineItem: [ { position: 210 } ]
      PostingDate                  : datum;

      @Aggregation.default: #SUM
      @Consumption.filter.hidden: true
      @EndUserText.label: 'Quantity In Base Unit'
      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      @UI.identification: [ { position: 10 } ]
      @UI.lineItem: [ { position: 220 } ]

      QuantityInBaseUnit           : menge_d;

      @Consumption.filter.hidden: true
      @EndUserText.label: 'Material Base Unit'
      @UI.identification: [ { position: 10 } ]
      @UI.lineItem: [ { position: 230 } ]
      MaterialBaseUnit             : meins;

      @Aggregation.default: #SUM
      @Consumption.filter.hidden: true
      @EndUserText.label: 'Quantity In Entry Unit'
      @Semantics.quantity.unitOfMeasure: 'EntryUnit'
      @UI.identification: [ { position: 10 } ]
      @UI.lineItem: [ { position: 240 } ]
      QuantityInEntryUnit          : menge_d;

      @Consumption.filter.hidden: true
      @EndUserText.label: 'Entry Unit'
      @UI.identification: [ { position: 10 } ]
      @UI.lineItem: [ { position: 250 } ]
      EntryUnit                    : meins;

      @Consumption.filter.hidden: true
      @EndUserText.label: 'Bộ phận/Số xe'
      @UI.identification: [ { position: 10 } ]
      @UI.lineItem: [ { position: 260 } ]
      transportno                  : abap.char(20);

      @Consumption.filter.hidden: true
      @EndUserText.label: 'Goods Receipt Type'
      @UI.identification: [ { position: 10 } ]
      @UI.lineItem: [ { position: 290 } ]
      GoodsReceiptType             : abap.char(1);

      @Consumption.filter.hidden: true
      @UI.lineItem: [ { position: 30, label: 'Reservation' } ]
      Reservation                  : vbeln;

      @Consumption.filter.hidden: true
      @UI.lineItem: [ { position: 30, label: 'Reservation Item' } ]
      ReservationItem              : abap.numc(4);

      // bo sung sau
      @Consumption.filter.hidden: true
      @UI.lineItem: [ { position: 30, label: 'Reversed Material Document Item' } ]
      ReversedMaterialDocumentItem : abap.numc(4);

      @Consumption.filter.hidden: true
      @UI.lineItem: [ { position: 30, label: 'Reverse Material Document Year' } ]
      ReversedMaterialDocumentYear : abap.char(4);

      @Consumption.filter.hidden: true
      @UI.lineItem: [ { position: 30, label: 'Reverse Material Document ' } ]
      ReversedMaterialDocument     : mblnr;

      @Consumption.valueHelpDefinition: [ { entity: { name: 'I_SalesOrderItemStdVH', element: 'SalesOrderItem' } } ]
      @UI.lineItem: [ { position: 30, label: 'Sales Order Item' } ]
      SalesOrderItem               : abap.numc(6);

      @Consumption.valueHelpDefinition: [ { entity: { name: 'I_SalesOrderStdVH', element: 'SalesOrder' } } ]
      @UI.lineItem: [ { position: 30, label: 'Sales Order' } ]
      SalesOrder                   : vbeln;

      @Consumption.filter.hidden: true
      @EndUserText.label: 'Sales Order Schedule Line'
      @UI.fieldGroup: [ { type: #STANDARD, position: 10, qualifier: 'Fieldgroup4' } ]
      @UI.lineItem: [ { position: 280 } ]
      SalesOrderScheduleLine       : abap.numc(4);

      @Consumption.valueHelpDefinition: [ { entity: { name: 'I_InventorySpecialStockType',
                                                      element: 'InventorySpecialStockType' } } ]
      @EndUserText.label: 'Issg Or Rcvg Spcl Stock Ind'
      @UI.identification: [ { position: 10 } ]
      @UI.lineItem: [ { position: 290 } ]
      IssgOrRcvgSpclStockInd       : abap.char(1);

      @Consumption.valueHelpDefinition: [ { entity: { name: 'I_Supplier', element: 'Supplier' } } ]
      @EndUserText.label: 'Supplier'
      @UI.identification: [ { position: 10 } ]
      @UI.lineItem: [ { position: 300 } ]
      Supplier                     : lifnr;

      @Consumption.filter.hidden: true
      @EndUserText.label: 'Issuing Or Receiving Plant'
      @UI.identification: [ { position: 10 } ]
      @UI.lineItem: [ { position: 310 } ]
      IssuingOrReceivingPlant      : abap.char(4);

      @Consumption.valueHelpDefinition: [ { entity: { name: 'I_StorageLocationStdVH', element: 'StorageLocation' } } ]
      @EndUserText.label: 'Receiving Storage Loc'
      @UI.identification: [ { position: 10 } ]
      @UI.lineItem: [ { position: 320 } ]
      //      @Consumption.filter.hidden   : true
      IssuingOrReceivingStorageLoc : abap.char(4);

      @Consumption.filter.hidden: true
      @EndUserText.label: 'Issg Or Rcvg Material'
      @UI.identification: [ { position: 10 } ]
      @UI.lineItem: [ { position: 330 } ]
      IssgOrRcvgMaterial           : matnr;

      @Consumption.filter.hidden: true
      @EndUserText.label: 'Issg Or Rcvg Batch'
      @UI.identification: [ { position: 10 } ]
      @UI.lineItem: [ { position: 340 } ]
      IssgOrRcvgBatch              : abap.char(10);

      @UI.lineItem: [ { position: 30, label: 'Created By User' } ]
      CreatedByUser                : unam;

      @Consumption.filter.hidden: true
      @UI.lineItem: [ { position: 30, label: 'Creation Date' } ]
      CreationDate                 : datum;

      @Consumption.filter.hidden: true
      @UI.lineItem: [ { position: 30, label: 'Creation Time' } ]
      @UI.selectionField: [ { position: 30 } ]
      CreationTime                 : uzeit;

      @Consumption.valueHelpDefinition: [ { entity: { name: 'I_InventoryTransactionType',
                                                      element: 'InventoryTransactionType' } } ]
      @EndUserText.label: 'Inventory Transaction Type'
      @UI.identification: [ { position: 10 } ]
      @UI.lineItem: [ { position: 350 } ]
      InventoryTransactionType     : abap.char(2);

      @Consumption.filter.hidden: true
      @EndUserText.label: 'Material Document Header Text'
      @UI.identification: [ { position: 10 } ]
      @UI.lineItem: [ { position: 360 } ]
      MaterialDocumentHeaderText   : abap.char(100);

      @Consumption.filter.hidden: true
      @EndUserText.label: 'Controlling Area'
      @UI.identification: [ { position: 10 } ]
      @UI.lineItem: [ { position: 370 } ]
      ControllingArea              : abap.char(4);

      @Consumption.filter.hidden: true
      @EndUserText.label: 'Ngày nhập kho'
      @UI.identification: [ { position: 10 } ]
      @UI.lineItem: [ { position: 380 } ]
      ngaynhapkho                  : datum;

      @Consumption.filter.hidden: true
      @EndUserText.label: 'Ngày sản xuất'
      @UI.identification: [ { position: 10 } ]
      @UI.lineItem: [ { position: 390 } ]
      ngaysanxuat                  : datum;

      @Consumption.filter.hidden: true
      @EndUserText.label: 'Hạn sử dụng'
      @UI.identification: [ { position: 10 } ]
      @UI.lineItem: [ { position: 400 } ]
      hansudung                    : datum;

      @Consumption.filter.hidden: true
      @EndUserText.label: 'Đơn vị sản xuất'
      @UI.identification: [ { position: 10 } ]
      @UI.lineItem: [ { position: 410 } ]
      donvisanxuat                 : abap.char(70);

      @Consumption.filter.hidden: true
      @EndUserText.label: 'Nhà cung cấp'
      @UI.identification: [ { position: 10 } ]
      @UI.lineItem: [ { position: 420 } ]
      nhacungcap                   : abap.char(70);

      @Consumption.filter.hidden: true
      @EndUserText.label: 'Ghi chú'
      @UI.identification: [ { position: 10 } ]
      @UI.lineItem: [ { position: 430 } ]
      ghichu                       : abap.char(70);

      @Consumption.filter.hidden: true
      @EndUserText.label: 'Số hợp đồng'
      @UI.identification: [ { position: 10 } ]
      @UI.lineItem: [ { position: 440 } ]
      sohopdong                    : abap.char(70);

      @Consumption.filter.hidden: true
      @EndUserText.label: 'Ca sản xuất'
      @UI.identification: [ { position: 10 } ]
      @UI.lineItem: [ { position: 450 } ]
      casanxuat                    : abap.char(70);

      @Consumption.filter.hidden: true
      @EndUserText.label: 'Lot number'
      @UI.identification: [ { position: 10 } ]
      @UI.lineItem: [ { position: 630 } ]
      lotnumber                    : abap.char(70);

      @Consumption.filter.hidden: true
      @EndUserText.label: 'Khách hàng gửi gia công'
      @UI.identification: [ { position: 10 } ]
      @UI.lineItem: [ { position: 640 } ]
      khguigiacong                 : abap.char(70);

      @Consumption.filter.hidden: true
      @EndUserText.label: 'Nguồn gốc sản phẩm'
      @UI.identification: [ { position: 10 } ]
      @UI.lineItem: [ { position: 650 } ]
      NguonGocSanPham                 : abap.char(70);

      @Consumption.filter.hidden: true
      @EndUserText.label: 'KG / thùng'
      @UI.identification: [ { position: 10 } ]
      @UI.lineItem: [ { position: 460 } ]
      kgthung                      : abap.dec(16,3);

      @Aggregation.default: #SUM
      @Consumption.filter.hidden: true
      @EndUserText.label: 'Quantity in altunit'
      @Semantics.quantity.unitOfMeasure: 'altUnit'
      @UI.identification: [ { position: 10 } ]
      @UI.lineItem: [ { position: 470 } ]
      //      case when kg/thung.CharcFromDecimalValue is not initial then
      quantity_in_altunit          : menge_d;

      @Consumption.filter.hidden: true
      @EndUserText.label: 'AltUnit'
      @UI.identification: [ { position: 10 } ]
      @UI.lineItem: [ { position: 480 } ]
      altUnit                      : meins;

      @Consumption.filter.hidden: true
      @Consumption.valueHelpDefinition: [ { entity: { name: 'I_ProductGroup_2', element: 'ProductGroup' } } ]
      @EndUserText.label: 'Product Group'
      @UI.identification: [ { position: 10 } ]
      @UI.lineItem: [ { position: 490 } ]
      ProductGroup                 : matkl;

      @Consumption.filter.hidden: true
      @EndUserText.label: 'Product Group Name'
      @UI.identification: [ { position: 10 } ]
      @UI.lineItem: [ { position: 500 } ]
      ProductGroupName             : abap.char(100);

      @Consumption.filter.hidden: true
      @Consumption.valueHelpDefinition: [ { entity: { name: 'I_ProductType', element: 'ProductType' } } ]
      @EndUserText.label: 'Product Type'
      @UI.identification: [ { position: 10 } ]
      @UI.lineItem: [ { position: 510 } ]
      ProductType                  : producttype;

      @Consumption.filter.hidden: true
      @EndUserText.label: 'Product Type Name'
      @UI.identification: [ { position: 10 } ]
      @UI.lineItem: [ { position: 520 } ]
      ProductTypeName              : abap.char(100);

      @Consumption.filter.hidden: true
      @EndUserText.label: 'Customer Name'
      @UI.identification: [ { position: 10 } ]
      @UI.lineItem: [ { position: 530 } ]
      customerName                 : abap.char(100);

      @Consumption.filter.hidden: true
      @EndUserText.label: 'Supplier Name'
      @UI.identification: [ { position: 10 } ]
      @UI.lineItem: [ { position: 540 } ]
      supplierName                 : abap.char(100);

      //      header                       : abap.char(100);
      @Consumption.filter.hidden: true
      @EndUserText.label: 'Chứng nhận'
      @UI.identification: [ { position: 10 } ]
      @UI.lineItem: [ { position: 550 } ]
      YY1_Chungnhan_PRD            : abap.char(100);

      @Consumption.filter.hidden: true
      @EndUserText.label: 'Dòng sản phẩm'
      @UI.identification: [ { position: 10 } ]
      @UI.lineItem: [ { position: 560 } ]
      YY1_Dongsanpham_PRD          : abap.char(100);

      @Consumption.filter.hidden: true
      @EndUserText.label: 'Gia vị / phụ gia'
      @UI.identification: [ { position: 10 } ]
      @UI.lineItem: [ { position: 570 } ]
      YY1_GiaviPhugia_PRD          : abap.char(100);

      @Consumption.filter.hidden: true
      @EndUserText.label: 'Kích cơ / hình dáng size'
      @UI.identification: [ { position: 10 } ]
      @UI.lineItem: [ { position: 580 } ]
      YY1_KichcoHinhdangSize_PRD   : abap.char(100);

      @Consumption.filter.hidden: true
      @EndUserText.label: 'Loại hình sản xuất'
      @UI.identification: [ { position: 10 } ]
      @UI.lineItem: [ { position: 590 } ]
      YY1_Loaihinhsanxuat_PRD      : abap.char(100);

      @Consumption.filter.hidden: true
      @EndUserText.label: 'Loại TP thu hồi'
      @UI.identification: [ { position: 10 } ]
      @UI.lineItem: [ { position: 600 } ]
      YY1_LoaiTPthuhoi_PRD         : abap.char(100);

      @Consumption.filter.hidden: true
      @EndUserText.label: 'Quy cách đóng gói'
      @UI.identification: [ { position: 10 } ]
      @UI.lineItem: [ { position: 610 } ]
      YY1_Quycachdonggoi_PRD       : abap.char(100);

      @Consumption.filter.hidden: true
      @EndUserText.label: 'Họ và tên người vận chuyển'
      @UI.identification: [ { position: 10 } ]
      @UI.lineItem: [ { position: 260 } ]
      deliveryname                 : abap.char(100);

      @Consumption.filter.hidden: true
      @EndUserText.label: 'Phương tiện di chuyển'
      @UI.identification: [ { position: 10 } ]
      @UI.lineItem: [ { position: 260 } ]
      deliverytransport            : abap.char(100);

      @Consumption.filter.hidden: true
      @EndUserText.label: 'Số hợp đồng vận chuyển'
      @UI.identification: [ { position: 10 } ]
      @UI.lineItem: [ { position: 260 } ]
      deliverycontractno           : abap.char(100);

      @Consumption.filter.hidden: true
      @EndUserText.label: 'Số Cont'
      @UI.identification: [ { position: 10 } ]
      @UI.lineItem: [ { position: 270 } ]
      contno                       : abap.char(100);

      @Consumption.filter.hidden: true
      @EndUserText.label: 'Số Seal'
      @UI.identification: [ { position: 10 } ]
      @UI.lineItem: [ { position: 280 } ]
      sealno                       : abap.char(100);

      isreversed                   : abap.char(1);

      @Consumption.filter.hidden: true
      @EndUserText.label: 'Receiving SLoc Description'
      @UI.identification: [ { position: 10 } ]
      @UI.lineItem: [ { position: 620 } ]
      IssuingOrReceivingsloc_name  : abap.char(100);

      @Consumption.filter.hidden: true
      @EndUserText.label: 'Tên dài sản phẩm'
      @UI.identification: [ { position: 10 } ]
      @UI.lineItem: [ { position: 640 } ]
      tendai                       : abap.char(100);

      currrency                    : abap.cuky(5);

      @EndUserText.label: 'Total Goods Mvt Amt In CCCrcy'
      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
      @UI.hidden: true
      @UI.identification: [ { position: 10 } ]
      @UI.lineItem: [ { position: 110 } ]
      //      @Aggregation.default         : #SUM

      //      @DefaultAggregation: #SUM
      amount                       : abap.curr(31,2);

      @Aggregation.default: #SUM
      @Consumption.filter.hidden: true
      @EndUserText.label: 'Xuất'
      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      @UI.identification: [ { position: 10 } ]
      @UI.lineItem: [ { position: 660 } ]
      xuat                         : menge_d;

      @Aggregation.default: #SUM
      @Consumption.filter.hidden: true
      @EndUserText.label: 'Nhập'
      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      @UI.identification: [ { position: 10 } ]
      @UI.lineItem: [ { position: 650 } ]
      nhap                         : menge_d;

      @Consumption.filter.hidden: true
      @EndUserText.label: 'G/L Account'
      @UI.identification: [ { position: 10 } ]
      @UI.lineItem: [ { position: 660 } ]
      glaccount : abap.char(10);
}
