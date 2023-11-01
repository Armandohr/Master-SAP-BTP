@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Booking - Composition Root Entity'
define view entity ZR_BOOKING_0256_A 
as select from zbooking_0256_a

association to parent ZR_TRAVEL_0256_A as _Travel 
              on $projection.TravelUuid = _Travel.TravelUuid

// composition [0..*] of ZR_TRAVEL_0256_A as _Travel
{
    key booking_uuid          as BookingUuid,
      parent_uuid           as TravelUuid,

      booking_id            as BookingId,
      booking_date          as BookingDate,
      customer_id           as CustomerId,
      carrier_id            as CarrierId,
      connection_id         as ConnectionId,
      flight_date           as FlightDate,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      flight_price          as FlightPrice,
      currency_code         as CurrencyCode,
      booking_status        as BookingStatus,

      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      local_last_changed_at as LocalLastChangedAt,
      //   _association_name // Make association public
      _Travel

}
