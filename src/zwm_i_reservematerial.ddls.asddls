@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Reserve material document'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZWM_I_RESERVEMATERIAL
  as select distinct from I_MaterialDocumentItem_2 as item
  association [1..1] to I_MaterialDocumentItem_2 as item_2 on  item_2.MaterialDocument     = item.ReversedMaterialDocument
                                                           and item_2.MaterialDocumentYear = item.ReversedMaterialDocumentItem
                                                           and item_2.MaterialDocumentItem = item.ReversedMaterialDocumentItem
{
  key item.ReversedMaterialDocument,
  key item.ReversedMaterialDocumentItem,
  key item.ReversedMaterialDocumentYear,
      item_2.MaterialDocument,
      case when item_2.MaterialDocument is not initial  then  'X'
      else 'O' end as isreversed
}
//where
//  item.ReversedMaterialDocument <> ''
