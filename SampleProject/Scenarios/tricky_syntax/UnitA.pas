unit UnitA;

interface

uses
  // Ghost1,
  UnitB, {Ghost2,} (* Ghost3, *) System.SysUtils;

const
  Msg = 'uses Ghost4;';

implementation

end.
