@EndUserText.label: 'Travel - Interface'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define root view entity ZI_TRAVEL_0256_A
  provider contract transactional_interface
  as projection on ZR_TRAVEL_0256_A
{
  key TravelUuid,
      TravelId,
      AgencyId,
      CustomerId,
      BeginDate,
      EndDate,
      BookingFee,
      TotalPrice,
      CurrencyCode,
      Description,
      OverallStatus,
      LocalCreatedBy,
      LocalCreatedAt,
      LocalLastChangedBy,
      LocalLastChangedAt,
      LastChangedAt,
      /* Associations */
      _Agency,
      _Booking : redirected to composition child ZI_BOOKING_0256_A,
      _Currency,
      _Customer,
      _OverallStatus

}
