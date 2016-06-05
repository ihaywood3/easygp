-- Function: billing.update_invoice_payment()

-- DROP FUNCTION billing.update_invoice_payment();

CREATE OR REPLACE FUNCTION billing.update_invoice_payment()
  RETURNS trigger AS
$BODY$
    DECLARE
       pk_invoice iNTEGER;
    BEGIN
        If (TG_OP = 'DELETE') THEN
      pk_invoice = OLD.fk_invoice;
   Else
      pk_invoice = New .fk_invoice;
   End If ;
        update billing.invoices set total_paid = billing.invoice_received(pk) where pk = pk_invoice;
   update billing.invoices set paid = (total_paid >= total_bill) where pk = pk_invoice;
        Return Null; -- result Is Ignored since this Is An AFTER trigger
    End ;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION billing.update_invoice_payment()   OWNER TO easygp;

update db.lu_version set lu_minor = 511;
