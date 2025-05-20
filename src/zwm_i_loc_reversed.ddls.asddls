@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Lọc Reverse material document'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZWM_I_LOC_REVERSED
  as select from I_MaterialDocumentItem_2 as item
  association [1..1] to ZWM_I_RESERVEMATERIAL as locchungtu on  locchungtu.ReversedMaterialDocument     = item.MaterialDocument
                                                            and locchungtu.ReversedMaterialDocumentItem = item.MaterialDocumentItem
                                                            and locchungtu.ReversedMaterialDocumentYear = item.MaterialDocumentYear
{
  key item.MaterialDocument,
  key item.MaterialDocumentItem,
  key item.MaterialDocumentYear,
      case when locchungtu.isreversed <> '' then locchungtu.isreversed
      else 'X' end as isreversed
}
