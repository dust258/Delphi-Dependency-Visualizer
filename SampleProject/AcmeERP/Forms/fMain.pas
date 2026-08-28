unit fMain;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.Dialogs,
  uKernelEvents;

type
  TfMain = class(TForm)
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  fMain: TfMain;

implementation

uses
  fLogin,
  fSettings,
  fUserAdmin,
  fAbout,
  dmMain,
  uSvcAuth,
  uSvcNotification,
  uKernelLog,
  uKernelConfig,
  uKernelContainer,
  uKernelUtils,
  fCustomer,
  fOrder,
  fProduct,
  fInvoice,
  fShipment,
  fPayment,
  fSupplier,
  fWarehouse,
  fCategory,
  fDiscount,
  fTax,
  fCurrency,
  fContract,
  fQuotation,
  fReturn,
  fRefund,
  fInventory,
  fStock,
  fPricing,
  fCampaign,
  fLead,
  fOpportunity,
  fContact,
  fAccount,
  fTicket,
  fProject,
  fTask,
  fTimesheet,
  fExpense,
  fBudget,
  fLedger,
  fJournal,
  fAsset,
  fDepreciation,
  fPayroll,
  fEmployee,
  fDepartment,
  fRole,
  fPermission,
  fNotification,
  fReport,
  fDashboard,
  fAudit,
  fSetting,
  fImport,
  fExport,
  fBatch,
  fSchedule,
  fReminder,
  fDocument;

{$R *.dfm}

end.
