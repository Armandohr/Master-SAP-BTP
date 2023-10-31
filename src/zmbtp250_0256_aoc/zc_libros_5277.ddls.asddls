@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Libros'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Metadata.allowExtensions: true
define view entity zc_libros_5277
  as select from    ztlibros_5277     as Libros
    inner join      ztcatego_5277     as categoria on Libros.bi_categ = categoria.bi_categ
    left outer join zc_clnts_lib_5277 as ventas    on Libros.id_libro = ventas.IdLibro
  association [0..*] to zc_clientes_5277 as _Clientes on $projection.IdLibro = _Clientes.IdLibro
{
  key Libros.id_libro       as IdLibro,
      Libros.titulo         as Titulo,
      Libros.bi_categ       as Categoria,
      Libros.autor          as Autor,
      Libros.editorial      as Editorial,
      Libros.idioma         as Idioma,
      Libros.paginas        as Paginas,
      @Semantics.amount.currencyCode: 'Moneda'
      Libros.precio         as Precio,
      case
         when ventas.Ventas < 1 then 0
         when ventas.Ventas = 1 then 1
         when ventas.Ventas = 2 then 2
        else 3
      end                   as Ventas,
      case ventas.Ventas
        when 0 then ''
        else ''
      end                   as Text,
      Libros.moneda         as Moneda,
      Libros.formato        as Formato,
      categoria.descripcion as Descripcion,
      Libros.url            as Imagen,
      _Clientes
}
