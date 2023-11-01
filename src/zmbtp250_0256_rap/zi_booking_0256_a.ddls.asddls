@EndUserText.label: 'Booking - Interface'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define view entity ZI_BOOKING_0256_A 
as projection on ZR_BOOKING_0256_A
{
    key BookingUuid,
      TravelUuid,
      BookingId,
      BookingDate,
      CustomerId,
      AirlineID,
      ConnectionId,
      FlightDate,
      FlightPrice,
      CurrencyCode,
      BookingStatus,
      LocalLastChangedAt,
      /* Associations */
      _BookingStatus,
      _Carrier,
      _Connection,
      _Customer,
      _Travel : redirected to parent ZI_TRAVEL_0256_A

}
