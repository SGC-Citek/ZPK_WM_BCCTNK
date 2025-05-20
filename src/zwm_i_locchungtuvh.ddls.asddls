@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Lọc chứng từ valuehelp domain'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@ObjectModel.resultSet.sizeCategory: #XS

define view entity ZWM_I_LOCCHUNGTUVH
  as select from DDCDS_CUSTOMER_DOMAIN_VALUE_T( p_domain_name: 'ZDM_LOCCHUNGTU_BCGDNSXTN' )
{
  key domain_name,
  key value_position,
      @Semantics.language: true
  key language,
      @ObjectModel.text.element:[ 'text' ]
      value_low,
      text
}
