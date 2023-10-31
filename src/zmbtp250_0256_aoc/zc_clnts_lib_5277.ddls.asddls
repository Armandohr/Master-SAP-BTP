@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Ventas'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity zc_clnts_lib_5277
  as select from ztclnts_lib_5277
{
  key id_libro                     as IdLibro,
      count( distinct id_cliente ) as Ventas
}
group by
  id_libro;
