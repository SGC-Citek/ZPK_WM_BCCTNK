@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Get charcvalue'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZWM_I_CHARCVALUE
  as select distinct from I_ClfnCharacteristic as header
  association [1..1] to I_ClfnObjectCharcValueDEX as item on  header.CharcInternalID = item.CharcInternalID
                                                          
{
  key left(item.ClfnObjectID,18)  as material,
  key ltrim(right(item.ClfnObjectID,10),' ') as batch,
      header.Characteristic,
      item.CharcValue,
      item.CharcFromDate,
      cast( item.CharcFromDecimalValue as abap.dec(16,3) ) as CharcFromDecimalValue
}
where item.ClassType = '023'
